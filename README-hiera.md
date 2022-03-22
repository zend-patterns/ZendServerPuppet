## Configure using Hiera

Define params for this class in data/common.yaml, or data/zendserver.yaml depending on your definitions in 
hiera.yaml, e.g.:

    zendserver::accept_eula: true
    zendserver::admin_password: 'mypassword'
    zendserver::manage_repos: true
    zendserver::webserver: 'apache'
    zendserver::phpversion: '7.4'
    zendserver::zend_server_version: '2021.1.1'
    zendserver::admin_api_key_name: 'admin'
    zendserver::admin_api_key_secret: 'my sectret key'
    zendserver::admin_email: 'email@domain.com'


