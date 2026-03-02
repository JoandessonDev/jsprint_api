# Create default roles
roles = [ "admin", "manager", "developer", "viewer" ]

roles.each do |role|
  Role.find_or_create_by!(name: role)
end

# Find admin role
admin_role = Role.find_by(name: "admin")

# Create default admin user
User.find_or_create_by!(email: "joandesson.dev@gmail.com") do |user|
  user.name = "Joandesson Santos"
  user.cpf = "04350843213"
  user.password = "JSprint2026&"
  user.password_confirmation = "JSprint2026&"
  user.role = admin_role
end
