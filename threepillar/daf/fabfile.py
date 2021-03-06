'''
Created on Sep 3, 2013

@author: cpaun
'''

from fabric.state import env
from util import DeploymentHandler

deployment_handler = DeploymentHandler()

def snapshot():
    init('SNAPSHOT')

def release():
    init('RELEASE')
    
#===============================================================================
# performs the following:
#            app_server_shutdown()
#            reset_db()
#            app_server_cleanup()
#            fetch_deployment_from_repository(deployment_type,version)
#            app_server_startup()    
#            check_deployment_status()
#===============================================================================
def deploy(version):
    app_server_shutdown()
    reset_db()
    app_server_cleanup()
    fetch_deployment_from_repository(version)
    app_server_startup()
    check_deployment_status()
#===============================================================================
# Starts tomcat on deployment server
#===============================================================================
def app_server_startup():
    try:
        deployment_handler.tomcat_startup(verbose=False)
    except Exception as e:
        deployment_handler.handle_exception(e, 'Error starting up application server:')    
#===============================================================================
# Stops tomcat on deployment server
#===============================================================================
def app_server_shutdown():
    try:
        deployment_handler.tomcat_shutdown(verbose=False)
    except Exception as e:
        deployment_handler.handle_exception(e, 'Error shutting down application server:') 
#===============================================================================
# Remove tomcat working items
#===============================================================================
def app_server_cleanup():
    try:
        deployment_handler.tomcat_cleanup(verbose=False)
    except Exception as e:
        deployment_handler.handle_exception(e, 'Error performing application server cleanup tasks:')
#===============================================================================
# copy .war from nexus to the deployment server 
#     deployment_type can either be SNAPSHOT or RELEASE
#     version must match the one in maven;s pom.xml
#===============================================================================
def fetch_deployment_from_repository(version):
    try:
        deployment_handler.fetch_deployment_from_nexus(version)
    except Exception as e:
        deployment_handler.handle_exception(e, 'Error retrieving deployment artifacts '  + ', ' +version + ':')    
    
#===============================================================================
# executes all sql scripts located inside db_scripts_tmp  
#===============================================================================
def reset_db():
    try:
        deployment_handler.setup_mysql_db()
    except Exception as e:
        deployment_handler.handle_exception(e, 'Error executing sql scripts:')

#===============================================================================
# check if application is up and running 
#===============================================================================
def check_deployment_status():
    deployment_handler.check_deployment_status()
    
    
#===============================================================================
# upload static content remotely - copies recursively local folders to remote
# folder
#===============================================================================
def upload_static_content():
    try:
        deployment_handler.upload_static_content()
    except Exception as e:
        deployment_handler.handle_exception(e, 'Error uploading content:')
                
#===============================================================================
# seed jenkins job from xml config file
#===============================================================================
def seed_jenkins_job():
    deployment_handler.seed_jenkins_jobs()
    #print 'Not implemented' 

def init(deployment_type):
    global util
    deployment_handler.set_deployment_type(deployment_type)
    env.hosts    = deployment_handler.read_config_map('authentication')['ssh_hosts'].split(",")
    env.user     = deployment_handler.read_config_map('authentication')['ssh_username']
    env.password = deployment_handler.read_config_map('authentication')['ssh_password']
    
if __name__ == '__main__':
    import sys
    from fabric.main import main
    sys.argv = ['fab', '-f', __file__,] + sys.argv[1:]
    main()