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
puts "Seeding Doug's Family Practice"
my_practice = Practice.create({
    specialty: "Family Practitioner",
    name: "Doug's Family Practice"
  })

puts "Seeding Dr. Doug"
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


puts "Seeding Codes"
### Generate Diagnoses
diag1 = Diagnosis.create({code: "E1010", description: "Type 1 diabetes mellitus with ketoacidosis without coma"})
diag2 = Diagnosis.create({code: "E119", description: "Type 2 diabetes mellitus without complications"})
diag3 = Diagnosis.create({code: "R7309", description: "Other abnormal glucose"})
diag4 = Diagnosis.create({code: "E1011", description: "Type 1 diabetes mellitus with ketoacidosis with coma"})
diag5 = Diagnosis.create({code: "H268", description: "Other specified cataract"})
diag6 = Diagnosis.create({code: "E15", description: "Nondiabetic hypoglycemic coma"})
diag7 = Diagnosis.create({code: "Q794", description: "Prune belly syndrome"})
diag8 = Diagnosis.create({code: "K551", description: "Chronic vascular disorders of intestine"})
diag9 = Diagnosis.create({code: "G9382", description: "Brain death"})
diag10 = Diagnosis.create({code: "J45", description: "Asthma"})
diag11 = Diagnosis.create({code: "J459", description: "Other and unspecified asthma"})
diag12 = Diagnosis.create({code: "J440", description: "Chronic obstructive pulmonary disease with acute lower respiratory infection"})
diag13 = Diagnosis.create({code: "J441", description: "Chronic obstructive pulmonary disease with (acute) exacerbation"})

puts "Seeding Appt Types"
type1 = doug.appointment_types.build({name: "Diabetic Checkup", recurrence: true, occurence_frequency: 90})
type1.diagnoses = [diag1, diag2, diag3, diag4]
type2 = doug.appointment_types.build({name: "Asthma Checkup", recurrence: true, occurence_frequency: 365})
type2.diagnoses = [diag11, diag12, diag13, diag10]

doug.save

puts "Seeding Doug's Practice"

time = Time.now
new_month = (time.month + 3 > 12) ? time.month + 3 - 12 : time.month + 3
time = time.change(month: new_month)

20.times do |i|
  v = i+2

  puts "Seeding patient #{i+1}"
  user = User.new({
        email: Faker::Internet.safe_email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        phone: Faker::PhoneNumber.phone_number,
        password: "password"
      })

  puts "Seeding health for patient #{i+1}"
  user.health.build(height: 69)

  user.doctor = doug

  puts "Seeding Reminders for patient #{i+1}"
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
  
  puts "Seeding Patient Diagnoses for patient #{i+1}"
  user.diagnoses = [diag2,diag10]
  
  puts "Seeding Appointment for patient #{i+1}"
  
  if (time.month + 1 > 12)
    new_month = time.month + 1 - 12
    time = time.change(year: time.year + 1)
  else
    time.month + 1
  end

  time = time.change(month: new_month)
  appt = user.appointments.build({datetime: time, appointment_type_id: type1.id})
  appt.doctor = doug
  
  user.save
  
  Reminder.create_appt_reminder(appt)
end
# doug.generate_doctor_alerts


### OTHER PRACTICES

puts "Seeding Other Practices"
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


puts "Generating Alerts"
User.generate_all_alerts

