
variable "public_instances" {
  type  = map(object({
    name = string
    db_version = string
    region = string
    settings = object({
        tier = string
        activation_policy = string
        availability_type = string
        disk_autoresize = bool
        disk_autoresize_limit = number
        disk_size = number
        disk_type = string
        user_labels = map(string)
        authorized_networks = map(object({
            name = string
            ip = string
        }))
    })
    databases = list(string)
  }))
}

variable "private_instances" {
  type = map(object({
    network =  string
    prefix_length = number
    name = string
    deletion_protection = bool
    region = string
    db_version = string
    settings = object({
        tier = string
        availability_type = string
        activation_policy = string
        disk_autoresize = bool
        disk_autoresize_limit = number
        disk_size = number
        disk_type = string
        user_labels = map(string)
        authorized_networks = map(object({
            name = string
            ip = string
        }))
    })
    
    databases = list(string)
  }))
}








