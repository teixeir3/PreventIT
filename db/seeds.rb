# Normal:
# my_practice = Practice.create({
#     specialty: "Family Practitioner",
#     name: "Doug's Family Practice"
#   })
#
# doug = User.new({
#     email: "teixeir3@gmail.com",
#     first_name: "Douglas",
#     last_name: "Teixeira",
#     phone: "908-872-0937",
#     password: "password"
#   })
# doug.is_doctor = true
# doug.practice = my_practice
# doug.alert_setting.build
# doug.save
#
# 5.times do |i|
#   v = i+2
#   user = User.new({
#         email: "user#{v}",
#         first_name: "user",
#         last_name: "#{v}",
#         phone: "(#{v}#{v}#{v}) #{v}#{v}#{v} - #{v}#{v}#{v}#{v}",
#         password: "password"
#         })
#
#   user.doctor = doug
#
#
#     10.times do |j|
#       user_date = Time.now.change(year: 1999)
#         user.reminders.build({
#           datetime: user_date,
#           title: "Alert title #{j}",
#           rem_type: "input",
#           patient_id: i,
#           complete: false
#         })
#     end
#
#   user.save
# end

# Test Alert:
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

3.times do |i|
  v = i+2
  user = User.new({
        email: "user#{v}",
        first_name: "user",
        last_name: "#{v}",
        phone: "(#{v}#{v}#{v}) #{v}#{v}#{v} - #{v}#{v}#{v}#{v}",
        password: "password"
        })

  user.doctor = doug


    4.times do |j|
      user_date = Time.now.change(year: 1999)
        user.reminders.build({
          datetime: user_date,
          title: "Alert title #{j}",
          rem_type: "medication",
          patient_id: i,
          complete: false,
          sub_type: "aspirin"
        })

        user.reminders.build({
          datetime: user_date,
          title: "Alert title #{j}",
          rem_type: "input",
          patient_id: i,
          complete: false,
          sub_type: "A1C"
        })

        user.reminders.build({
          datetime: user_date,
          title: "Alert title #{j}",
          rem_type: "treatment",
          patient_id: i,
          complete: false,
          sub_type: "foot exam"
        })

        user.reminders.build({
          datetime: user_date,
          title: "Alert title #{j}",
          rem_type: "appointment",
          patient_id: i,
          complete: false,
          sub_type: "diabetes checkup"
        })
    end

  user.save
end


