var search_data = {"index":{"searchIndex":["alert","alertsetting","alertscontroller","alertshelper","applicationcontroller","applicationhelper","appointment","appointmenttype","appointmenttypescontroller","appointmenttypeshelper","appointmentscontroller","appointmentshelper","appttypediagnosis","diagnosescontroller","diagnoseshelper","diagnosis","doctorscontroller","doctorshelper","health","pagescontroller","pageshelper","patientdiagnosis","practice","reminder","reminderscontroller","remindershelper","sessionscontroller","sessionshelper","user","userscontroller","usershelper","add_diagnosis()","all_not_due()","auth_token()","check_uid_by_provider()","complete_alerts()","complete_str?()","completed()","completed()","create()","create()","create()","create()","create()","day_str()","destroy()","destroy()","destroy()","due_reminders()","edit()","edit()","edit()","ensure_session_token()","find_by_credentials()","full_name()","full_name_by_last()","generate_all_alerts()","generate_doctor_alerts()","generate_missed_appointment_alerts()","generate_missed_input_alerts()","generate_missed_medication_alerts()","generate_missed_treatment_alerts()","generate_session_token()","generate_unhealthy_input_alerts()","incomplete_alerts()","incomplete_due_reminders()","index()","index()","index()","index()","index()","is_doctor?()","is_due?()","is_password?()","is_patient_doctor?()","mark_all_due()","mark_complete()","mark_due!()","new()","new()","new()","new()","new()","new()","new_doctor()","overdue_by()","overdue_by_str()","password=()","patients_by_last_name()","patients_input_complete_unchecked_reminders()","patients_reminders_by_type()","patients_with_reminders()","reset_session_token!()","search_diagnoses()","search_patients()","self_propagation!()","show()","show()","show()","show()","update()","update()","update()","readme_for_app"],"longSearchIndex":["alert","alertsetting","alertscontroller","alertshelper","applicationcontroller","applicationhelper","appointment","appointmenttype","appointmenttypescontroller","appointmenttypeshelper","appointmentscontroller","appointmentshelper","appttypediagnosis","diagnosescontroller","diagnoseshelper","diagnosis","doctorscontroller","doctorshelper","health","pagescontroller","pageshelper","patientdiagnosis","practice","reminder","reminderscontroller","remindershelper","sessionscontroller","sessionshelper","user","userscontroller","usershelper","diagnosescontroller#add_diagnosis()","reminder::all_not_due()","applicationhelper#auth_token()","user#check_uid_by_provider()","user#complete_alerts()","alert#complete_str?()","alertscontroller#completed()","reminderscontroller#completed()","appointmentscontroller#create()","doctorscontroller#create()","reminderscontroller#create()","sessionscontroller#create()","userscontroller#create()","reminder#day_str()","appointmentscontroller#destroy()","diagnosescontroller#destroy()","sessionscontroller#destroy()","user#due_reminders()","appointmentscontroller#edit()","reminderscontroller#edit()","userscontroller#edit()","user#ensure_session_token()","user::find_by_credentials()","user#full_name()","user#full_name_by_last()","user::generate_all_alerts()","user#generate_doctor_alerts()","user#generate_missed_appointment_alerts()","user#generate_missed_input_alerts()","user#generate_missed_medication_alerts()","user#generate_missed_treatment_alerts()","user::generate_session_token()","user#generate_unhealthy_input_alerts()","user#incomplete_alerts()","user#incomplete_due_reminders()","alertscontroller#index()","appointmenttypescontroller#index()","appointmentscontroller#index()","diagnosescontroller#index()","reminderscontroller#index()","applicationhelper#is_doctor?()","reminder#is_due?()","user#is_password?()","user#is_patient_doctor?()","reminder::mark_all_due()","alertscontroller#mark_complete()","reminder#mark_due!()","appointmenttypescontroller#new()","appointmentscontroller#new()","pagescontroller#new()","reminderscontroller#new()","sessionscontroller#new()","userscontroller#new()","doctorscontroller#new_doctor()","reminder#overdue_by()","reminder#overdue_by_str()","user#password=()","user#patients_by_last_name()","user#patients_input_complete_unchecked_reminders()","user#patients_reminders_by_type()","user#patients_with_reminders()","user#reset_session_token!()","pagescontroller#search_diagnoses()","pagescontroller#search_patients()","reminder#self_propagation!()","alertscontroller#show()","doctorscontroller#show()","reminderscontroller#show()","userscontroller#show()","appointmentscontroller#update()","reminderscontroller#update()","userscontroller#update()",""],"info":[["Alert","","Alert.html","","<p>Schema Information\n<p>Table name: alerts\n\n<pre>id                :integer          not null, primary key\npatient_id ...</pre>\n"],["AlertSetting","","AlertSetting.html","","<p>Schema Information\n<p>Table name: alert_settings\n\n<pre>id                   :integer          not null, primary ...</pre>\n"],["AlertsController","","AlertsController.html","",""],["AlertsHelper","","AlertsHelper.html","",""],["ApplicationController","","ApplicationController.html","",""],["ApplicationHelper","","ApplicationHelper.html","",""],["Appointment","","Appointment.html","","<p>Schema Information\n<p>Table name: appointments\n\n<pre>id                  :integer          not null, primary key ...</pre>\n"],["AppointmentType","","AppointmentType.html","","<p>Schema Information\n<p>Table name: appointment_types\n\n<pre>id                  :integer          not null, primary ...</pre>\n"],["AppointmentTypesController","","AppointmentTypesController.html","",""],["AppointmentTypesHelper","","AppointmentTypesHelper.html","",""],["AppointmentsController","","AppointmentsController.html","",""],["AppointmentsHelper","","AppointmentsHelper.html","",""],["ApptTypeDiagnosis","","ApptTypeDiagnosis.html","","<p>Schema Information\n<p>Table name: appt_type_diagnoses\n\n<pre>id           :integer          not null, primary key ...</pre>\n"],["DiagnosesController","","DiagnosesController.html","",""],["DiagnosesHelper","","DiagnosesHelper.html","",""],["Diagnosis","","Diagnosis.html","","<p>Schema Information\n<p>Table name: diagnoses\n\n<pre>id          :integer          not null, primary key\ncode      ...</pre>\n"],["DoctorsController","","DoctorsController.html","",""],["DoctorsHelper","","DoctorsHelper.html","",""],["Health","","Health.html","","<p>Schema Information\n<p>Table name: healths\n\n<pre>id         :integer          not null, primary key\npatient_id :integer ...</pre>\n"],["PagesController","","PagesController.html","",""],["PagesHelper","","PagesHelper.html","",""],["PatientDiagnosis","","PatientDiagnosis.html","","<p>Schema Information\n<p>Table name: patient_diagnoses\n\n<pre>id           :integer          not null, primary key\ndiagnosis_id ...</pre>\n"],["Practice","","Practice.html","","<p>Schema Information\n<p>Table name: practices\n\n<pre>id         :integer          not null, primary key\nspecialty  ...</pre>\n"],["Reminder","","Reminder.html","","<p>Schema Information\n<p>Table name: reminders\n\n<pre>id            :integer          not null, primary key\ndatetime ...</pre>\n"],["RemindersController","","RemindersController.html","",""],["RemindersHelper","","RemindersHelper.html","",""],["SessionsController","","SessionsController.html","",""],["SessionsHelper","","SessionsHelper.html","",""],["User","","User.html","","<p>Schema Information\n<p>Table name: users\n\n<pre>id                  :integer          not null, primary key\nemail ...</pre>\n"],["UsersController","","UsersController.html","",""],["UsersHelper","","UsersHelper.html","",""],["add_diagnosis","DiagnosesController","DiagnosesController.html#method-i-add_diagnosis","()",""],["all_not_due","Reminder","Reminder.html#method-c-all_not_due","()","<p>returns all reminders marked as not due\n"],["auth_token","ApplicationHelper","ApplicationHelper.html#method-i-auth_token","()",""],["check_uid_by_provider","User","User.html#method-i-check_uid_by_provider","()",""],["complete_alerts","User","User.html#method-i-complete_alerts","()",""],["complete_str?","Alert","Alert.html#method-i-complete_str-3F","()",""],["completed","AlertsController","AlertsController.html#method-i-completed","()",""],["completed","RemindersController","RemindersController.html#method-i-completed","()",""],["create","AppointmentsController","AppointmentsController.html#method-i-create","()",""],["create","DoctorsController","DoctorsController.html#method-i-create","()",""],["create","RemindersController","RemindersController.html#method-i-create","()",""],["create","SessionsController","SessionsController.html#method-i-create","()",""],["create","UsersController","UsersController.html#method-i-create","()",""],["day_str","Reminder","Reminder.html#method-i-day_str","()",""],["destroy","AppointmentsController","AppointmentsController.html#method-i-destroy","()",""],["destroy","DiagnosesController","DiagnosesController.html#method-i-destroy","()",""],["destroy","SessionsController","SessionsController.html#method-i-destroy","()",""],["due_reminders","User","User.html#method-i-due_reminders","()","<p>Reminder Methods ###\n"],["edit","AppointmentsController","AppointmentsController.html#method-i-edit","()",""],["edit","RemindersController","RemindersController.html#method-i-edit","()",""],["edit","UsersController","UsersController.html#method-i-edit","()",""],["ensure_session_token","User","User.html#method-i-ensure_session_token","()",""],["find_by_credentials","User","User.html#method-c-find_by_credentials","(email, password)","<p>Auth Methods ###\n"],["full_name","User","User.html#method-i-full_name","()",""],["full_name_by_last","User","User.html#method-i-full_name_by_last","()",""],["generate_all_alerts","User","User.html#method-c-generate_all_alerts","()","<p>Alert Methods (for doctor)###\n"],["generate_doctor_alerts","User","User.html#method-i-generate_doctor_alerts","()","<p>handle_asynchronously :generate_all_alerts\n"],["generate_missed_appointment_alerts","User","User.html#method-i-generate_missed_appointment_alerts","()",""],["generate_missed_input_alerts","User","User.html#method-i-generate_missed_input_alerts","()","<p>Tested\n"],["generate_missed_medication_alerts","User","User.html#method-i-generate_missed_medication_alerts","()","<p>TODO: Have TA check this on Monday // Make this run on all patients instead\nof patient’s by doctor TODO: …\n"],["generate_missed_treatment_alerts","User","User.html#method-i-generate_missed_treatment_alerts","()",""],["generate_session_token","User","User.html#method-c-generate_session_token","()",""],["generate_unhealthy_input_alerts","User","User.html#method-i-generate_unhealthy_input_alerts","()",""],["incomplete_alerts","User","User.html#method-i-incomplete_alerts","()",""],["incomplete_due_reminders","User","User.html#method-i-incomplete_due_reminders","()",""],["index","AlertsController","AlertsController.html#method-i-index","()",""],["index","AppointmentTypesController","AppointmentTypesController.html#method-i-index","()",""],["index","AppointmentsController","AppointmentsController.html#method-i-index","()",""],["index","DiagnosesController","DiagnosesController.html#method-i-index","()",""],["index","RemindersController","RemindersController.html#method-i-index","()",""],["is_doctor?","ApplicationHelper","ApplicationHelper.html#method-i-is_doctor-3F","(user)",""],["is_due?","Reminder","Reminder.html#method-i-is_due-3F","()","<p>Returns true if the reminder’s time is passed in the current day AND\ngenerates and new reminder if it’s …\n"],["is_password?","User","User.html#method-i-is_password-3F","(unencrypted_password)",""],["is_patient_doctor?","User","User.html#method-i-is_patient_doctor-3F","(patient_id)",""],["mark_all_due","Reminder","Reminder.html#method-c-mark_all_due","()","<p>marks all reminders due (if their time is past)\n"],["mark_complete","AlertsController","AlertsController.html#method-i-mark_complete","()",""],["mark_due!","Reminder","Reminder.html#method-i-mark_due-21","()",""],["new","AppointmentTypesController","AppointmentTypesController.html#method-i-new","()",""],["new","AppointmentsController","AppointmentsController.html#method-i-new","()",""],["new","PagesController","PagesController.html#method-i-new","()","<p>before_filter :require_doctor_authority!\n"],["new","RemindersController","RemindersController.html#method-i-new","()",""],["new","SessionsController","SessionsController.html#method-i-new","()",""],["new","UsersController","UsersController.html#method-i-new","()",""],["new_doctor","DoctorsController","DoctorsController.html#method-i-new_doctor","()",""],["overdue_by","Reminder","Reminder.html#method-i-overdue_by","()",""],["overdue_by_str","Reminder","Reminder.html#method-i-overdue_by_str","()",""],["password=","User","User.html#method-i-password-3D","(unencrypted_password)",""],["patients_by_last_name","User","User.html#method-i-patients_by_last_name","()",""],["patients_input_complete_unchecked_reminders","User","User.html#method-i-patients_input_complete_unchecked_reminders","()",""],["patients_reminders_by_type","User","User.html#method-i-patients_reminders_by_type","(type)",""],["patients_with_reminders","User","User.html#method-i-patients_with_reminders","()",""],["reset_session_token!","User","User.html#method-i-reset_session_token-21","()",""],["search_diagnoses","PagesController","PagesController.html#method-i-search_diagnoses","()",""],["search_patients","PagesController","PagesController.html#method-i-search_patients","()",""],["self_propagation!","Reminder","Reminder.html#method-i-self_propagation-21","()","<p>def should_check_for_alert\n\n<pre>  self.is_due? &amp;&amp;\nend</pre>\n<p>generates a new reminder with the same parameters 1 yr …\n"],["show","AlertsController","AlertsController.html#method-i-show","()",""],["show","DoctorsController","DoctorsController.html#method-i-show","()",""],["show","RemindersController","RemindersController.html#method-i-show","()",""],["show","UsersController","UsersController.html#method-i-show","()",""],["update","AppointmentsController","AppointmentsController.html#method-i-update","()",""],["update","RemindersController","RemindersController.html#method-i-update","()",""],["update","UsersController","UsersController.html#method-i-update","()",""],["README_FOR_APP","","doc/README_FOR_APP.html","","<p>Use this README file to introduce your application and point to useful\nplaces in the API for learning …\n"]]}}