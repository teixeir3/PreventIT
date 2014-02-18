# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

# Adds a comment
my_practice = Practice.create({
    specialty: "Family Practitioner",
    name: "Doug's Family Practice"
  })

doug = User.new({
    email: "teixeir3@gmail.com",
    first_name: "Douglas",
    last_name: "Teixeira",
    phone: "908-872-0937",
    password: "password"
  })
doug.is_doctor = true
doug.practice = my_practice
doug.save

5.times do |i|
user = User.new({
      email: "user#{i}",
      first_name: "user",
      last_name: "#{i}",
      phone: "(#{i}#{i}#{i}) #{i}#{i}#{i} - #{i}#{i}#{i}#{i}",
      password: "password"
      })

user.doctor = doug
user.save

  # 3.times do |j|
#       Reminder.create({
#         date: "2014-2-14 12:30:00",
#         time: "2014-2-14 12:30:00",
#         title: "Alert title #{j}",
#         rem_type: "input",
#         patient_id: i
#       })
#   end
end

