User.create! name: "HuynhDung", email: "huynhdung@gmail.com", password: "111111",
  password_confirmation: "111111", is_admin: true
User.create! name: "NgoVanTien", email: "ngovantien93@gmail.com",
  password: "123456789",
  password_confirmation: "123456789", is_admin: true
User.create!(name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  is_admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email,
  password: password,
  password_confirmation: password)
end
