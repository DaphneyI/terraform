locals {
  member_roles = flatten([
    for member_key, member in var.roles: [
        for role in member.roles : {
        member_key = member_key
        role = role
        member = "${member.member_type}:${member.member}"
      }
    ]
  ])
}

