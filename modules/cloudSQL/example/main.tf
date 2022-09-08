module "relational_db" {
    source = "../../cloudSQL"

  private_instances = {
    "myprivatedb" = {
        name = "myprivatedb"
        network = "default"
        db_version = "MYSQL_5_7"
        region = "europe-west2"
        prefix_length = 29
        deletion_protection = true
        databases = ["dev", "staging", "prod"]
        settings = {
        activation_policy = "ALWAYS"
        authorized_networks = {
            "key" = {
            ip = "my-network"
            name = "10.10.50.0/24"
            }
        }
        availability_type = "REGIONAL"
        disk_autoresize = false
        disk_autoresize_limit = 1
        disk_size = 10
        disk_type = "PD_SSD"
        tier = "db-f1-micro"
        user_labels = {
            "type" = "private"
        }
        }
    }
    "myprivatedb2" = {
        name = "myprivatedb2"
        network = "consul-vpc"
        db_version = "MYSQL_5_7"
        region = "europe-west1"
        prefix_length = 29
        deletion_protection = true
        databases = ["dev", "staging", "prod"]
        settings = {
        activation_policy = "ALWAYS"
        authorized_networks = {
            "key" = {
            ip = "my-network"
            name = "10.10.50.0/24"
            }
        }
        availability_type = "REGIONAL"
        disk_autoresize = false
        disk_autoresize_limit = 1
        disk_size = 10
        disk_type = "PD_SSD"
        tier = "db-f1-micro"
        user_labels = {
            "type" = "private"
        }
        }
    }
    }
    public_instances = {
    "mypublicdb" = {
        name = "mypublicdb"
        db_version = "MYSQL_5_7"
        region = "europe-west2"
        databases = ["dev", "staging", "prod"]
        settings = {
        activation_policy = "ALWAYS"
        authorized_networks = {
            "key" = {
            ip = "my-network"
            name = "35.132.50.0/24"
            }
        }
        availability_type = "REGIONAL"
        disk_autoresize = false
        disk_autoresize_limit = 1
        disk_size = 10
        disk_type = "PD_SSD"
        tier = "db-f1-micro"
        user_labels = {
            "type" = "public"
        }
        }
    }
}
}