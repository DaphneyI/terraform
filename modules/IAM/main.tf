
resource "google_project_iam_member" "iam_roles" {
  for_each = {
    for entry in local.member_roles : "${entry.member_key}.${entry.role}" => entry
  }
  project = var.project_id
  role =  each.value.role
  member =  each.value.member
}
