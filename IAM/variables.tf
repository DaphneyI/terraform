variable "roles" {
  type = map(object({
    roles = list(string)
    member = string
    member_type =  string
  }))
}

variable "project_id" {
  type = string
}