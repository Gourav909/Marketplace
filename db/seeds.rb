Admin.create(email: "admin@gmail.com", password: "password", password_confirmation: "password") unless Admin.first


['Taipei city', 'New Taipei city'].each do |city|
  City.find_or_create_by!(name: city)
end


['Zhongzheng', 'Zhongshan', 'Beitou', 'Wanhua', 'Datong'].each do |district|
  District.find_or_create_by!(name: district, city_id: 1)
end

['Banqiao', 'Sanchong', 'Shulin', 'Xindian', 'Xinzhuang'].each do |district|
  District.find_or_create_by!(name: district, city_id: 2)
end
