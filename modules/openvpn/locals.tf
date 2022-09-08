locals {
    vpn_zone                       = format("%s-a", var.region)
    vpn_labels = merge(var.vpn_labels, {
      environment = var.environment
    })

}