desc "this task is caleld by the heroku scheduler add-on"
task :generat_alerts => :environment do
  puts "Checking Reminders for Alert generation..."
  new_alert_count = User.generate_all_alerts
  puts "Done. #{new_alert_count} Alerts Created"
end