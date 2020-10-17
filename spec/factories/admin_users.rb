FactoryBot.define do
  factory(:admin_user) do
    email { 'admin@admin.com' }
    password { 'Password' }
    password_confirmation { 'Password' }
  end
end
