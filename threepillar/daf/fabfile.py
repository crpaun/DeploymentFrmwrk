'''
Created on Sep 3, 2013

@author: cpaun
'''

from fabric.state import env
import  util


env.hosts    = util.read_config_map('authentication')['ssh_hosts'].split(",")
env.user     = util.read_config_map('authentication')['ssh_username']
env.password = util.read_config_map('authentication')['ssh_password']

    
#===============================================================================
# performs the following:
#            app_server_shutdown()
#            reset_db()
#            app_server_cleanup()
#            fetch_deployment_from_repository(deployment_type,version)
#            app_server_startup()    
#            check_deployment_status()
#===============================================================================
def deploy(deployment_type,version):    
    app_server_shutdown()
    reset_db()
    app_server_cleanup()
    fetch_deployment_from_repository(deployment_type,version)
    app_server_startup()
    check_deployment_status()
#===============================================================================
# Starts tomcat on deployment server
#===============================================================================
def app_server_startup():
    """
    startup tomcat instance.
    """
    util.tomcat_startup(verbose=False)
#===============================================================================
# Stops tomcat on deployment server
#===============================================================================
def app_server_shutdown():
    """
    shut down tomcat instance.
    """
    util.tomcat_shutdown(verbose=False)
#===============================================================================
# Remove tomcat working items
#===============================================================================
def app_server_cleanup():
    """
    startup tomcat instance.
    """
    util.tomcat_cleanup(verbose=False)
#===============================================================================
# copy .war from nexus to the deployment server 
#     deployment_type can either be SNAPSHOT or RELEASE
#     version must match the one in maven;s pom.xml
#===============================================================================
def fetch_deployment_from_repository(deployment_type,version):
    util.fetch_deployment_from_nexus(deployment_type,version)
#===============================================================================
# check if application is up and running 
#===============================================================================
def check_deployment_status():
    util.check_deployment_status(env.hosts[0])
    
#===============================================================================
# executes all sql scripts located inside db_scripts_tmp  
#===============================================================================
def reset_db():
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