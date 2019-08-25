locals {
  instance_count = var.instance_count # length(var.ips)
  tomcat_opts = var.guacamole_client_tomcat_listen_address != "" ? {"port" = var.guacamole_client_tomcat_port, "listen_address" = var.guacamole_client_tomcat_listen_address} : {"port" = var.guacamole_client_tomcat_port }
  services = {
    "devoptimist/guacamole-client" = {
      "channel" = var.guacamole_client_channel,
      "user_toml_config" = {
        "users"  = var.guacamole_client_connection_config,
        "tomcat" = local.tomcat_opts
      }
    }
  }
}

# we can't use effortless package at the moment due to pathing issues
# so calling the cookbook through policyfile bootstrap 

module "guacd_build" {
  source           = "devoptimist/policyfile/chef"
  version          = "0.0.6"
  ips              = var.ips
  instance_count   = local.instance_count
  cookbooks        = var.cookbooks
  policyfile_name  = var.policyfile_name
  runlist          = var.runlist
  user_name        = var.user_name
  user_pass        = var.user_pass
  user_private_key = var.user_private_key
}

module "habitat_install" {
  source            = "devoptimist/habitat/chef"
  version           = "0.0.4"
  ips               = var.ips
  instance_count    = local.instance_count
  user_name         = var.user_name
  user_pass         = var.user_pass
  user_private_key  = var.user_private_key
  user_names        = var.user_names
  user_passes       = var.user_passes
  user_private_keys = var.user_private_keys
  hab_services      = local.services 
}

## the following was removed from the services list due to 
# issues with getting chef effortless packages to run
#  services = {
#    "devoptimist/effortless-guacd" = {
#      "channel" = var.effortless_guacd_channel,
#      "user_toml_config" = {
#        "interval" = var.effortless_guacd_interval,
#        "splay" = var.effortless_guacd_splay
#      }
#    },