############ connection details #################

variable "ips" {
  description = "A list of ip addresses where we will install hab and run services"
  type        = list
}

variable "instance_count" {
  description = "The number of instances that will have chef-solo run on them"
  type        = number
}

variable "user_name" {
  description = "The ssh or winrm user name used to access the ip addresses provided"
  type        = string
  default     = ""
}

variable "user_names" {
  description = "A list of ssh or winrm user names used to access the ip addresses provided"
  type        = list(string)
  default     = []
}

variable "user_pass" {
  description = "The ssh or winrm user password used to access the ip addresses (either user_pass or user_private_key needs to be set)"
  type        = string
  default     = ""
}

variable "user_passes" {
  description = "A list of ssh or winrm user passwords used to access the ip addresses (either user_pass or user_private_key needs to be set)"
  type        = list(string)
  default     = []
}

variable "user_private_key" {
  description = "The user key used to access the ip addresses (either user_pass or user_private_key needs to be set)"
  type        = string
  default     = ""
}

variable "user_private_keys" {
  description = "A list of user keys used to access the ip addresses (either user_pass/s or user_private_key/s needs to be set)"
  type        = list(string)
  default     = []
}
################# policyfile module ###################

variable "cookbooks" {
  description = "the cookbooks used to deploy chef automate"
  default = {
    "guacd" = "github: 'srb3/cookbook-guacd', tag: 'v1.0.0-20190825143757'",
  }
}

variable "runlist" {
  description = "The chef run list used to deploy chef automate"
  type        = list(string)
  default     = ["guacd::default"]
}

variable "policyfile_name" {
  description = "The name of the policyfile we will create"
  type        = string
  default     = "guacd"
}

########### guacamole settings ##################

variable "effortless_guacd_channel" {
  description = "The builder channel to pull the guacd effortless package from"
  type        = string
  default     = "stable"
}

variable "effortless_guacd_interval" {
  description = "The interval in seconds in which to run effortless chef client"
  type        = number
  default     = 300
}

variable "effortless_guacd_splay" {
  description = "The splay in seconds in which to offset the effortless chef client runs"
  type        = number
  default     = 30
}

variable "guacamole_webserver_channel" {
  description = "The builder channel to pull the guacamole-webserver habitat package from"
  type        = string
  default     = "stable"
}

variable "guacamole_client_channel" {
  description = "The builder channel to pull the guacamole-client habitat package from"
  type        = string
  default     = "stable"
}

variable "guacamole_client_connection_config" {
  description = "the connection configuration to pass to the guacamole client"
  type        = list
  default     = []
}

variable "guacamole_client_tomcat_port" {
  description = "The port for tomcat to listen on"
  type        = string
  default     = "8080"
}

variable "guacamole_client_tomcat_listen_address" {
  description = "The adress for tomcat to listen on, defaults to the ip of the server"
  type        = string
  default     = ""
}

variable "guacamole_webserver_ssl_crt" {
  description = "An ssl certificate to use with the webproxy server"
  type        = string
  default     = ""
}

variable "guacamole_webserver_ssl_key" {
  description = "An ssl key to use with the webproxy server"
  type        = string
  default     = ""
}

variable "guacamole_webserver_hostname" {
  description = "An ssl key to use with the webproxy server"
  type        = string
  default     = ""
}
