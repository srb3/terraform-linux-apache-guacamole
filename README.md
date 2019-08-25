# Overview
This module will install, configure and run the guacd and guacamole-client services on a target server or servers. The guacd
service is compiled and installed via a chef cookbook and the guacamole-client is handled with as a habitat package.
The guacamole-client hab service can be dynamically configured with connections via the guacamole_client_connection_configi map variable. 

#### Supported platform families:
 for guacd
  * Ubuntu
  * CentOS
 for guacamole-client
  * any linux habitat supervisor 

## Usage

```hcl

module "guacamole-install" {
  source               = "devoptimist/apache-guacamole/linux"
  version              = "0.0.1"
  ips                  = ["172.16.0.23"]
  instance_count       = 1
  ssh_user_name        = "ec2-user"
  ssh_user_private_key = "~/.ssh/id_rsa"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|ips|A list of ip addresses where we will install hab and run services|list|[]|no|
|instance_count|The number of instances being created|number|0|no|
|ssh_user_name|The ssh user name used to access the ip addresses provided|string||yes|
|ssh_user_pass|The ssh user password used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)|string|""|no|
|ssh_user_private_key|The ssh user key used to access the ip addresses (either ssh_user_pass or ssh_user_private_key needs to be set)|string|""|no|
|effortless_guacd_channel|The builder channel to pull the guacd effortless package from|string|stable|no|
|guacamole_client_channel|The builder channel to pull the guacamole-client habitat package from|string|stable|no|
|guacamole_client_connection_config|the connection configuration to pass to the guacamole client|list(object)|[]|no|
|guacamole_client_tomcat_port|The port for tomcat to listen on|string|8080|no|
|guacamole_client_tomcat_listen_address|The adress for tomcat to listen on, defaults to the ip of the server|string|""|no|

## Map/List Variable examples

### guacamole_client_connection_config

```hcl
  "users" = [
    {
      "ui_name" = "jdoe",
      "ui_pass" = "mypass",
      "connections" = [
        {
          "name" = "dns1",
          "protocol" = "ssh",
          "params" = {
            "hostname" = "192.168.1.2",
            "port" = 22,
            "username" = "jdoe",
            "password" = "sshpassword"
          }
        },
        {
          "name" = "router1",
          "protocol" = "ssh",
          "params" = {
            "hostname" = "192.168.1.1",
            "port" = 22,
            "username" = "steveb",
            "password" = "routerpassword"
          }
        }
      ]
    },
    {
      "ui_name" = "msmith",
      "ui_pass" = "yourpass",
      "connections" = [
        {
          "name" = "domainmaster",
          "protocol" = "rdp",
          "params" = {
            "hostname" = "192.168.1.3",
            "port" = 3389,
            "username" = "msmith",
            "password" = "rdppassword"
          }
        },
        {
          "name": "build1",
          "protocol": "vnc",
          "params": {
            "hostname": "192.168.1.4",
            "port": 5901,
            "username": "msmith",
            "password": "buildpassword"
          }
        }
      ]
    }
  ]
```
