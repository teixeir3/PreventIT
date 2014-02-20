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
doug.alert_setting.build
doug.save

5.times do |i|
  v = i+2
  user = User.new({
        email: "user#{v}",
        first_name: "user",
        last_name: "#{v}",
        phone: "(#{v}#{v}#{v}) #{v}#{v}#{v} - #{v}#{v}#{v}#{v}",
        password: "password"
        })

  user.doctor = doug


    3.times do |j|
      user_date = Time.now.change(year: 1999)
        user.reminders.build({
          datetime: user_date,
          title: "Alert title #{j}",
          rem_type: "input",
          patient_id: i
        })
    end

  user.save
end

