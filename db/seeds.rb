# Create admin user
if User.where(email: 'admin@dropresume.com').count > 0
  puts 'Admin User already exist and skip to create admin user'
else
  puts 'Creating Admin User....'
  User.create!(first_name: 'Dropresume', last_name: 'Admin', username: 'admin_user', email: 'admin@dropresume.com', password: 'admin@1470')
end

# Create admin profile
user = User.find_by_email('admin@dropresume.com')
if user.profile.present?
  puts 'Admin User profile already exist and skip to create admin user profile'
else
  puts 'Creating Admin User Profile....'
  Profile.create!(user_id: user.id, title: 'Demo title')
end

# Create demo user
if User.where(email: 'demo@dropresume.com').count > 0
  puts 'Demo User already exist and skip to create demo user'
else
  puts 'Creating Demo User....'
  User.create!(first_name: 'Dropresume', last_name: 'Demo', username: 'demo_user', email: 'demo@dropresume.com', password: 'demo@123')
end

# Create demo profile
user = User.find_by_email('demo@dropresume.com')
if user.profile.present?
  puts 'Demo User profile already exist and skip to create demo user profile'
else
  puts 'Creating Demo User Profile....'
  Profile.create!(user_id: user.id, title: 'Demo title')
end

#create some demo objective suggestion
puts 'creating demo objective......'
SampleObjective.any? ? '' : 5.times do |t| SampleObjective.create(objective: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat....') end
