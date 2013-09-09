'''
Created on Sep 3, 2013

@author: cpaun
'''

from fabric.state import env
import  util


#env.hosts    = ["clj-pc-077.3pillar.corp"]
#env.user     = "pps"
#env.password = "3pg"

    
#===============================================================================
# init args - may not be needed when running from cmd line
#===============================================================================
def init(host,user):
    env.hosts = []
    env.hosts.append(host)
    env.user= user

#===============================================================================
# main desploy task:
#            stop app server
#            cleanup temp app server data
#            fetch deployment artifacts
#            start app server    
#===============================================================================
def deploy(deployment_type):
    app_server_shutdown()
    app_server_cleanup()
    fetch_deployment_from_repository(deployment_type)
    app_server_startup()
    check_deployment_status()
    
#===============================================================================
# Start/stop/cleanup app server
#===============================================================================
def app_server_startup():
    """
    startup tomcat instance.
    """
    util.tomcat_startup(verbose=False)
    
def app_server_shutdown():
    """
    shut down tomcat instance.
    """
    util.tomcat_shutdown(verbose=False)

def app_server_cleanup():
    """
    startup tomcat instance.
    """
    util.tomcat_cleanup(verbose=False)
    

#===============================================================================
# artifact_type can either be SNAPSHOT or RELEASE
#===============================================================================
def fetch_deployment_from_repository(deployment_type):
    util.fetch_deployment_from_nexus(deployment_type)

#===============================================================================
# check if application is running 
#===============================================================================
def check_deployment_status():
    util.check_deployment_status(env.hosts[0])
    
#===============================================================================
# db specific - run sql DDL and seed 
#===============================================================================
def setup_db():
    util.setup_mysql_db()

#===============================================================================
# seed jenkins job from xml config file
#===============================================================================
def seed_jenkins_jobs():
    util.seed_jenkins_jobs()


if __name__ == '__main__':
    import sys
    from fabric.main import main
    sys.argv = ['fab', '-f', __file__,] + sys.argv[1:]
    main()