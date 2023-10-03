# Admin.create!(email: "admin@gmail.com", password: "password", password_confirmation: "password")


['Taipei city', 'New Taipei city'].each do |city|
  City.create(name: city)
end


['Zhongzheng', 'Zhongshan', 'Beitou', 'Wanhua', 'Datong'].each do |district|
  District.create(district_name: district, city_id: 1)
end

['Banqiao', 'Sanchong', 'Shulin', 'Xindian', 'Xinzhuang'].each do |district|
  District.create(district_name: district, city_id: 2)
end
