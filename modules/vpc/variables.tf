
variable "vpc" {
  type = map(object({
    auto_create_subnetworks = bool
    subnets = map(object({
        cidr = string
        region = string
        sec-range = map(object({
            cidr = string
        }))
    }))
  }))
}
