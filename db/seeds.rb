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

# Demo Database
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

20.times do |i|
  v = i+2
  user = User.new({
        email: Faker::Internet.safe_email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        phone: Faker::PhoneNumber.phone_number,
        password: "password"
        })

  user.health.build(height: 69)

  user.doctor = doug


  4.times do |j|
    user_date = Time.now.change(year: 2014, month: 2, day: 20, hour: 10)

      user.reminders.build({
        datetime: user_date,
        title: "Missed Medication #{j}",
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
end
# doug.generate_doctor_alerts


### OTHER PRACTICES

2.times do
  doctor = User.new({
      email: Faker::Internet.safe_email,
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      phone: Faker::PhoneNumber.phone_number,
      password: "password"
    })

  my_practice = Practice.create({
      specialty: "Family Practitioner",
      name: doctor.first_name + "'s Practice"
    })


  doctor.is_doctor = true
  doctor.practice = my_practice
  doctor.alert_setting.build
  doctor.save

  20.times do |i|
    v = i+2
    user = User.new({
          email: Faker::Internet.safe_email,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          phone: Faker::PhoneNumber.phone_number,
          password: "password"
          })

    user.health.build(height: 69)

    user.doctor = doctor


    4.times do |j|
      user_date = Time.now.change(year: 2014, month: 2, day: 20, hour: 10)

        user.reminders.build({
          datetime: user_date,
          title: "Missed Medication #{j}",
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
  end
  # doctor.generate_doctor_alerts
end

### Generate Diagnoses
Diagnosis.create({code: "E1010", description: "Type 1 diabetes mellitus with ketoacidosis without coma"})
Diagnosis.create({code: "E119", description: "Type 2 diabetes mellitus without complications"})
Diagnosis.create({code: "R7309", description: "Other abnormal glucose"})
Diagnosis.create({code: "E1011", description: "Type 1 diabetes mellitus with ketoacidosis with coma"})
Diagnosis.create({code: "H268", description: "Other specified cataract"})
Diagnosis.create({code: "E15", description: "Nondiabetic hypoglycemic coma"})
Diagnosis.create({code: "Q794", description: "Prune belly syndrome"})
Diagnosis.create({code: "K551", description: "Chronic vascular disorders of intestine"})
Diagnosis.create({code: "G9382", description: "Brain death"})

User.generate_all_alerts

