# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)      not null
#  password_digest     :string(255)      not null
#  session_token       :string(255)      not null
#  first_name          :string(255)
#  last_name           :string(255)
#  phone               :string(255)
#  doctor_id           :integer
#  practice_id         :integer
#  is_doctor           :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  email_notifications :boolean          default(TRUE), not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :first_name, :last_name, :phone, :avatar, :email_notifications
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true, uniqueness: true

  before_validation :ensure_session_token

  has_attached_file :avatar, :styles => {
         :big => "600x600>",
         :small => "200x200>"
       }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  #### Patient Associations ####
  has_many(
    :health,
    class_name: "Health",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient,
    dependent: :destroy
  )

  belongs_to(
    :doctor,
    class_name: "User",
    foreign_key: :doctor_id,
    primary_key: :id
  )

  has_one(
    :practice,
    through: :doctor,
    source: :practice
  )

  has_many(
    :reminders,
    class_name: "Reminder",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient
  )

  has_many(
    :alerts,
    class_name: "Alert",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient,
    dependent: :destroy
  )

  #### Doctor Associations ####

  belongs_to(
    :practice,
    class_name: "Practice",
    foreign_key: :practice_id,
    primary_key: :id,
    inverse_of: :doctors
  )

  has_many(
    :patients,
    class_name: "User",
    foreign_key: :doctor_id,
    primary_key: :id
  )

  has_many(
    :patient_alerts,
    through: :patients,
    source: :alerts
  )

  has_many(
      :alert_setting,
      class_name: "AlertSetting",
      foreign_key: :doctor_id,
      primary_key: :id,
      inverse_of: :doctor,
      dependent: :destroy
    )



  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  ### Reminder Methods ###


  def due_reminders
    self.reminders.select { |reminder| reminder.is_due? }
  end

  def incomplete_due_reminders
    self.reminders.select { |reminder| (reminder.is_due? && !reminder.complete && !reminder.checked) }
  end

  def patients_reminders_by_type(type)
    self.patients.joins(:reminders).where("reminders.rem_type = ? AND reminders.checked = ?", type, false).includes(:reminders)
  end

  def patients_with_reminders
    self.patients.includes(:reminders)
  end

  def patients_input_complete_unchecked_reminders
    self.patients.joins(:reminders).where("reminders.rem_type = ? AND reminders.complete = ? AND reminders.input_checked = ?", "input", true, false).includes(:reminders)
  end


  ### Alert Methods (for doctor)###


  def generate_all_alerts
    self.generate_missed_medication_alerts
    self.generate_missed_appointment_alerts
    self.generate_missed_input_alerts
    self.generate_missed_treatment_alerts
    self.generate_unhealthy_input_alerts

    nil
  end

  def generate_missed_medication_alerts
    patient_population = self.patients_reminders_by_type("medication")
    allowed_skipped = self.alert_setting.first.skipped_meds

    patient_population.each do |patient|
      skipped_med_count = 0

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_med_count += 1
        end
      end

      if skipped_med_count > allowed_skipped
        current_alert = patient.alerts.build({
          alert_type: "medication",
          reminders_skipped: skipped_med_count,
          reason: "Skipped #{skipped_med_count} Meds"
        })

        reminder.checked = true
        reminder.save
        current_alert.save
      end
    end

    nil
  end

  def generate_missed_appointment_alerts
    patient_population = self.patients_reminders_by_type("appointment")
    allowed_skipped = self.alert_setting.first.skipped_appointments

    patient_population.each do |patient|
      skipped_appointment_count = 0

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_appointment_count += 1
        end
      end

      if skipped_appointment_count > allowed_skipped
        current_alert = patient.alerts.build({
          alert_type: "appointment",
          reminders_skipped: skipped_appointment_count,
          reason: "Skipped #{skipped_appointment_count} Appointments"
        })

        ##### BUG!!!! CANNOT SAVE REMINDER AFTER BLOCK
        reminder.checked = true
        reminder.save
        current_alert.save
      end
    end

    nil
  end

  # Tested
  def generate_missed_input_alerts
    patient_population = self.patients_reminders_by_type("input")
    allowed_skipped = self.alert_setting.first.skipped_inputs

    patient_population.each do |patient|
      skipped_input_count = 0

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_input_count += 1
        end
      end

      if skipped_input_count > allowed_skipped
        current_alert = patient.alerts.build({
          alert_type: "input",
          reminders_skipped: skipped_input_count,
          reason: "Skipped #{skipped_input_count} inputs"
        })

        reminder.checked = true
        reminder.save
        current_alert.save
      end
    end

    nil
  end

  def generate_missed_treatment_alerts
    patient_population = self.patients_reminders_by_type("treatment")
    allowed_skipped = self.alert_setting.first.skipped_treatments

    patient_population.each do |patient|
      skipped_treatment_count = 0

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_treatment_count += 1
        end
      end

      if skipped_treatment_count > allowed_skipped
        current_alert = patient.alerts.build({
          alert_type: "treatment",
          reminders_skipped: skipped_treatment_count,
          reason: "Skipped #{skipped_treatment_count} Treatments"
        })

        reminder.checked = true
        reminder.save
        current_alert.save
      end
    end

    nil
  end


  def generate_unhealthy_input_alerts
    patient_population = self.patients_input_complete_unchecked_reminders
    alert_setting = self.alert_setting

    patient_population.each do |patient|
      patient.reminders.each do |reminder|
        if (reminder.sub_type == 'a1c')
          unless (reminder.input.between?(alert_setting[0].a1c_min, alert_setting[0].a1c_max))
            patient.alerts.create({
              alert_type: 'input',
              reason: "Unhealthy A1C: #{reminder.input} : #{reminder.id}"
            })

          end

          reminder.input_checked = true
          reminder.save
        elsif (reminder.sub_type == 'weight')
          bmi = (reminder.input/(patient.health[0].height*patient.health[0].height).to_f) * 703
          puts "LOOK HERE YOU FUCKER!!!!!!! #{bmi}"
          puts "WEIGHT!!!!!! #{reminder.input}"
          puts "HEIGHT!!!!!! #{patient.health[0].height}"
          puts "THAT*THAT!!!!!! #{(reminder.input/(patient.health[0].height).to_f)}"
          unless (bmi.between?(alert_setting[0].bmi_min, alert_setting[0].bmi_max))
            patient.alerts.create({
              alert_type: 'input',
              reason: "Unhealthy BMI: #{bmi} : #{reminder.id}"
            })
          end

          reminder.input_checked = true
          reminder.save
        end
      end
    end

    nil
  end


  ### Auth Methods ###
  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16);
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!

    self.session_token
  end

  def is_patient_doctor?(patient_id)
    (self.is_doctor && self.patient_ids.include?(patient_id))
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
