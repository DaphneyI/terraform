
module "openvpn" {
  source     = "DeimosCloud/openvpn/google"
  version    = "2.3.0"
  region     = var.region
  project_id = var.project_id
  zone       = local.vpn_zone
  network    = var.network
  subnetwork = var.subnet
  name       = var.name
  output_dir = "${path.module}/openvpn"
  tags       = var.vpn_tags
  users      = var.vpn_users
  labels     = local.vpn_labels
}


