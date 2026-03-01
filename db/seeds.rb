

# Create some default roles
roles = [ "admin", "manager", "developer", "viewer" ]

roles.each do |role|
    Role.find_or_create_by!(name: role)
end
