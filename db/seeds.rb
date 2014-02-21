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
  user.health.build(height: 69)

  user.doctor = doug


  4.times do |j|
    user_date = Time.now.change(year: 2014, month: 2, day: 20, hour: 10)

      user.reminders.build({
        datetime: user_date,
        title: "Missed Med #{j}",
        rem_type: "medication",
        patient_id: i,
        complete: false,
        sub_type: "aspirin"
      })

      user.reminders.build({
        datetime: user_date,
        title: "Unhealthy A1C #{j}",
        rem_type: "input",
        patient_id: i,
        complete: true,
        sub_type: "a1c",
        input: 5
      })

      user.reminders.build({
        datetime: user_date,
        title: "Healthy A1C #{j}",
        rem_type: "input",
        patient_id: i,
        complete: true,
        sub_type: "a1c",
        input: 20
      })

      user.reminders.build({
        datetime: user_date,
        title: "Unhealthy Weight #{j}",
        rem_type: "input",
        patient_id: i,
        complete: true,
        sub_type: "weight",
        input: 400
      })

      user.reminders.build({
        datetime: user_date,
        title: "Healthy Weight #{j}",
        rem_type: "input",
        patient_id: i,
        complete: true,
        sub_type: "weight",
        input: 150
      })

      user.reminders.build({
        datetime: user_date,
        title: "Overdue Weight #{j}",
        rem_type: "input",
        patient_id: i,
        complete: false,
        sub_type: "weight"
      })

      user.reminders.build({
        datetime: user_date,
        title: "Overdue Foot Exam #{j}",
        rem_type: "treatment",
        patient_id: i,
        complete: false,
        sub_type: "foot exam"
      })

      # should queue 12 alerts
      user.reminders.build({
        datetime: user_date,
        title: "Missed Appt #{j}",
        rem_type: "appointment",
        patient_id: i,
        complete: false,
        sub_type: "diabetes checkup"
      })
  end

  user.save

  # doug.generate_all_alerts
end


