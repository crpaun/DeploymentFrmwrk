import ConfigParser
from urllib2 import urlopen
import os
from fabric.operations import run, put, sudo

import jenkins
from nexus import NexusApiClient
from fabric.contrib.files import exists
from glob import glob

__author__ = 'asfat cpaun'

CONFIG_FILE = os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', '..')) + '/config.ini'


#===============================================================================
# check if application has been deployed succesfully 
#===============================================================================
def check_deployment_status(host):
    try:
        urlStr = read_config_map('tomcat')['tomcat_test_url'] 
        fileHandle = urlopen(urlStr)
        code = fileHandle.getcode()
        if(code is 200):
            str1 = "Successfully deployed!"
        if(code is 404):
            str1 =  'URL unavailable: ' + urlStr
    except IOError:
        str1 = 'URL unreachable: ' + urlStr
    print str1
    
 
#===============================================================================
# seed Jenkins jobs
#===============================================================================
def seed_jenkins_jobs():
    jenkins_config = read_config_map('jenkins_config')
    # connect to Jenkins instance
    jenkins_instance = jenkins.Jenkins(jenkins_config['jenkins_url'], jenkins_config['jenkins_username'], jenkins_config['jenkins_passwd'])
    # read config file
    jenkins_xml_cfg = open( os.getcwd()+'/config/Jenkins_xml_config.xml', 'r')
    if not jenkins_instance.job_exists(jenkins_config['jenkins_job_name']):
        jenkins_instance.create_job(jenkins_config['jenkins_job_name'], jenkins_xml_cfg.read())
        jenkins_instance.enable_job(jenkins_config['jenkins_job_name'])
        
#===============================================================================
# Retrieve deployment artifacts from nexus
#===============================================================================
def fetch_deployment_from_nexus(artifact_type,version):
    nexus_url = read_config_map('maven')['nexus_url']
    group_id = read_config_map('maven')['maven_groupId']
    artifact_id = read_config_map('maven')['maven_artifactId']
    #snapshot_version = read_config_map('maven')['maven_snapshot_version']
    #release_version = read_config_map('maven')['maven_release_version']
    packaging = read_config_map('maven')['maven_packaging']
    tomcat_home = read_config_map('tomcat')['tomcat_home']
    deployment_path = tomcat_home + "/webapps/"
    
    nexus_cfg = NexusApiClient(nexus_url, artifact_id, group_id, version, artifact_type,  packaging)
        
    nexus_url = nexus_cfg.build_url()
    
    if exists(deployment_path, use_sudo=True):
        run('mkdir -p ' + deployment_path)

    #run('wget --content-disposition -P ' + home_directory+deployment_path + ' \'' + nexus_url + '\'' )
    wget_cmd = 'wget  -O ' + deployment_path + artifact_id+'.'+packaging + ' \'' + nexus_url + '\''
    #print wget_cmd
    sudo(wget_cmd, pty=True)
    
#===============================================================================
# Tomcat start/stop/cleanup commands
#===============================================================================

def tomcat_startup(verbose=False):
    """
    startup tomcat instance.
    """
    sudo('service tomcat7 restart', pty=True)
    
def tomcat_shutdown(verbose=False):
    """
    shut down tomcat instance.
    """
    sudo('service tomcat7 stop', pty=True)
    
def tomcat_cleanup(verbose=False):
    """
    cleanup tomcat instance.
    """
    tomcat_home = read_config_map('tomcat')['tomcat_home']
    sudo('rm -rf ' + tomcat_home+'/work/Catalina', pty=True)
    sudo('rm -rf ' + tomcat_home+'/webapps/' + read_config_map('maven')['maven_artifactId'] , pty=True)
    sudo('rm -rf ' + tomcat_home+'/webapps/' + read_config_map('maven')['maven_artifactId']+"."+ read_config_map('maven')['maven_packaging'] , pty=True)
    
#===============================================================================
# db specific -  copy sql script files to temporary remote location and executes it 
#===============================================================================
def setup_mysql_db():
    #copy sql script files to remote location
    #parent_folder = os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', '..'))
    #put(parent_folder + '/db_scripts_tmp', '~')
    sql_cfg = read_config_map('mysql')
    script_folder = sql_cfg['sql_script_folder'] 
    put(script_folder, '~')
    #execute scripts
    
    sql_files = sql_cfg['sql_scripts'].split(",")
    for sql_file in sql_files:
        command = 'mysql -h %s -u%s -p%s --default-character-set=UTF8 < %s'\
            % (sql_cfg['db_host'],
            sql_cfg['db_username'],
            sql_cfg['db_password'],
            script_folder+ '/'+sql_file)
        sudo(command, pty=True)
    sudo('rm -rf ' + script_folder, pty=True)


def upload_static_content(remote_folder):
    local_folders = read_config_map('static_content')['local_folders'].split(",")
    
    sudo('mkdir -p ' + remote_folder, pty=True)

    for local_folder in local_folders:
        ret = put(local_folder, remote_folder, use_sudo=True)

def handle_exception(e,msg):
    print '=========================================================='
    print msg 
    print e
    print '=========================================================='
#===============================================================================
# plumbing
#===============================================================================

def get_configparser():
    config = ConfigParser.ConfigParser()
    # following is used to preserve the case of the properties
    config.optionxform = str

    return config


# reads a host group from config.ini and returns a list of hosts of that host group
def read_config_values(host_group):
    hosts = []

    for db_name, db_value in read_config_map(host_group).iteritems():
        hosts.append(db_value)

    return hosts


# reads a host group from config.ini and returns first result from the hosts
def read_config_value(host_group):
    return read_config_values(host_group)[0]


def read_config_map(host_group):
    config = get_configparser()
    config.read(CONFIG_FILE)
    return dict(config.items(host_group))


# class needed for ConfigParser, because it will not parse files without having a section specified in the file to parse
# this will create a dummy section that will not be present only when the file is read, but the file will not actually
# contain this section
class FakeSecHead(object):
    def __init__(self, fp):
        self.fp = fp
        self.sechead = '[dummy_section]\n'

    def readline(self):
        if self.sechead:
            try:
                return self.sechead
            finally:
                self.sechead = None
        else:
            return self.fp.readline()


def read_properties(file_name):
    dummy_section = 'dummy_section'

    config = get_configparser()
    config.readfp(FakeSecHead(open(file_name)))

    return dict(config.items(dummy_section))


# search the host_group and find a configuration property
# every host_group should have a "host_group-configuration" section, so we know
# to differentiate hosts from configuration properties
def get_configuration(host_group, configuration_property):

    section = host_group + '-configuration'
    try:
        properties = read_config_map(section)
    except ConfigParser.NoSectionError:
        print 'no such section=[' + section + ']'

        return None

    return properties[configuration_property]

