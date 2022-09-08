locals {
    zones                          = var.regional == false ? var.zones : null
    compute_engine_service_account = var.create_node_service_account == false ? var.compute_engine_service_account : null
    cluster_name                   = "${var.cluster_name}-${var.environment}"
    cluster_labels = merge(var.cluster_labels,{
        "env" : "${var.environment}"
    })
}