Fabricator(:user) do
  name { sequence(:name) { |i| "username#{i}" }}
  password { random_string }
end
