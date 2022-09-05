locals {
    default_autoresize_limit = 0

    public_instances = flatten([
        for instance_key, instance in var.public_instances : {
                instance_key = instance_key
                name = instance.name
                region = instance.region
                db_version = instance.db_version
                settings =  instance.settings
                binary_log_enabled = true ? length(regexall("MYSQL*", instance.db_version)) > 0 : null
                point_in_time_recovery_enabled = true ? length(regexall("POSTGRES*", instance.db_version)) > 0 : null
                disk_autoresize = instance.settings.disk_autoresize ? instance.settings.disk_size == null : false
                disk_autoresize_limit = instance.settings.disk_size == null ? instance.settings.disk_autoresize_limit: 0
                labels = instance.settings.user_labels
                authorized_networks = instance.settings.authorized_networks
            } 
    ])

    public_instances_db = flatten([
        for instance_key, instance in var.public_instances : [
            for db in instance.databases : {
                instance_key = instance_key
                db = db
            }
        ]
    ])
    private_instances = flatten([
        for instance_key, instance in var.private_instances : {
                instance_key = instance_key
                name = instance.name
                region = instance.region
                db_version = instance.db_version
                settings =  instance.settings
                binary_log_enabled = true ? length(regexall("MYSQL*", instance.db_version)) > 0 : null
                point_in_time_recovery_enabled = true ? length(regexall("POSTGRES*", instance.db_version)) > 0 : null
                disk_autoresize = instance.settings.disk_autoresize ? instance.settings.disk_size == null : false
                disk_autoresize_limit = instance.settings.disk_size == null ? instance.settings.disk_autoresize_limit: 0
                labels = instance.settings.user_labels
                authorized_networks = instance.settings.authorized_networks
            } 
    ])

    private_instances_network = flatten([
        for instance_key, instance in var.private_instances : {
            instance_key = instance_key
            network = instance.network
            static_ip_name = "${instance.network}-sql"
            prefix_length = instance.prefix_length
        }
    ])

    private_instances_db = flatten([
        for instance_key, instance in var.private_instances : [
            for db in instance.databases : {
                instance_key = instance_key
                db = db
            }
        ]
    ])
}