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
#  uid                 :string(255)
#  access_token        :string(255)
#  provider            :string(255)
#  active              :boolean          default(FALSE), not null
#  activation_token    :string(255)      default("INACTIVE"), not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :first_name, :last_name, :phone, :avatar, :email_notifications, :uid, :access_token, :provider
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :session_token, presence: true, uniqueness: true
  validates :uid, uniqueness: {scope: :provider, if: :check_uid_by_provider}

  paginates_per 10

  before_validation :ensure_session_token
  before_create :set_activation_token
  
  has_attached_file :avatar, :styles => {
         :big => "600x600>",
         :small => "100x100>"
       },
       :default_url => "/assets/small/missing.png"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  include PgSearch
  pg_search_scope :search_on_name,
                  against: [:first_name, :last_name],
                  using: {
                    :trigram => {
                      :threshold => 0.03
                    }
                  }


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

  has_many(
    :patient_diagnoses,
    class_name: "PatientDiagnosis",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient
  )

  has_many(
    :diagnoses,
    through: :patient_diagnoses,
    source: :diagnosis
  )

  has_many(
    :appointments,
    class_name: "Appointment",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient,
    dependent: :destroy
  )

  has_many(
    :appt_types,
    through: :diagnoses,
    source: :appt_types
  )
    
  has_many(
    :patient_medications,
    class_name: "PatientMedication",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient
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

   has_many(
      :appointment_types,
      class_name: "AppointmentType",
      foreign_key: :doctor_id,
      primary_key: :id,
      inverse_of: :doctor,
      dependent: :destroy
    )

  has_many(
    :doctor_appointments,
    class_name: "Appointment",
    foreign_key: :doctor_id,
    primary_key: :id,
    inverse_of: :doctor,
    dependent: :destroy
  )



  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  def doctor_full_name
    # Should create a 'title column'
    return "Dr. #{self.first_name} #{self.last_name}"
  end

  def full_name_by_last
    return "#{self.last_name}, #{self.first_name}"
  end

  def patients_by_last_name
    self.patients.order(:last_name, :first_name)
  end

  ### Reminder Methods ###


  def due_reminders
    self.reminders.select { |reminder| reminder.is_due? }
  end

  def incomplete_due_reminders
    self.reminders.select { |reminder| (reminder.is_due? && !reminder.complete && !reminder.checked) }
  end

  def patients_reminders_by_type(type)
    self.patients.joins(:reminders).where("reminders.remindable_type = ? AND reminders.checked = ?", type, false).includes(:reminders)
  end

  def patients_with_reminders
    self.patients.includes(:reminders)
  end

  def patients_input_complete_unchecked_reminders
    self.patients.joins(:reminders).where("reminders.remindable_type = ? AND reminders.complete = ? AND reminders.input_checked = ?", "Input", true, false).includes(:reminders)
  end

  def incomplete_alerts
    self.patient_alerts.where("alerts.complete = ?", false)
  end

  def complete_alerts
    self.patient_alerts.where("alerts.complete = ?", true)
  end


  ### Alert Methods (for doctor)###

  def self.generate_all_alerts
    new_alert_count = 0

    self.where(is_doctor: true).joins(:patients).includes(:patients).each do |doctor|
      new_alert_count += doctor.generate_doctor_alerts
    end

    new_alert_count
  end

  # handle_asynchronously :generate_all_alerts

  def generate_doctor_alerts
    new_alert_count = 0
    new_alert_count += self.generate_missed_medication_alerts
    new_alert_count += self.generate_missed_appointment_alerts
    new_alert_count += self.generate_missed_input_alerts
    new_alert_count += self.generate_missed_treatment_alerts
    new_alert_count += self.generate_unhealthy_input_alerts

    new_alert_count
  end

  # handle_asynchronously :generate_doctor_alerts

  # TODO: Have TA check this on Monday // Make this run on all patients instead of patient's by doctor
  # TODO: Could generate 'reason' dynamically with a single helper method
  def generate_missed_medication_alerts
    patient_population = self.patients_reminders_by_type("medication")
    new_alert_count = 0

    patient_population.each do |patient|
      skipped_med_count = 0
      allowed_skipped = self.alert_setting.first.skipped_meds
      reminder_ids = []

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_med_count += 1
          reminder_ids << reminder.id
        end

        if skipped_med_count > allowed_skipped
          allowed_skipped *= 2

          current_alert = patient.alerts.build({
            alert_type: "medication",
            reminders_skipped: skipped_med_count,
            reason: "Skipped #{skipped_med_count} Meds"
          })

          patient.reminders.find(reminder_ids).each do |checked_reminder|
            checked_reminder.checked = true
            checked_reminder.save
          end

          new_alert_count += 1 if current_alert.save
        end
      end
    end

    new_alert_count
  end

  def generate_missed_appointment_alerts
    patient_population = self.patients_reminders_by_type("appointment")
    new_alert_count = 0

    patient_population.each do |patient|
      skipped_appointment_count = 0
      allowed_skipped = self.alert_setting.first.skipped_appointments
      reminder_ids = []

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_appointment_count += 1
          reminder_ids << reminder.id
        end

        if skipped_appointment_count > allowed_skipped
          allowed_skipped *= 2

          current_alert = patient.alerts.build({
            alert_type: "appointment",
            reminders_skipped: skipped_appointment_count,
            reason: "Skipped #{skipped_appointment_count} Appointments"
          })

          patient.reminders.find(reminder_ids).each do |checked_reminder|
            checked_reminder.checked = true
            checked_reminder.save
          end

          new_alert_count += 1 if current_alert.save
        end
      end
    end

    new_alert_count
  end

  # Tested
  def generate_missed_input_alerts
    patient_population = self.patients_reminders_by_type("input")
    new_alert_count = 0

    patient_population.each do |patient|
      skipped_input_count = 0
      allowed_skipped = self.alert_setting.first.skipped_inputs
      reminder_ids = []

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_input_count += 1
          reminder_ids << reminder.id
        end

        if skipped_input_count > allowed_skipped
          allowed_skipped *= 2

          current_alert = patient.alerts.build({
            alert_type: "input",
            reminders_skipped: skipped_input_count,
            reason: "Skipped #{skipped_input_count} inputs"
          })

          patient.reminders.find(reminder_ids).each do |checked_reminder|
            checked_reminder.checked = true
            checked_reminder.save
          end

          new_alert_count += 1 if current_alert.save
        end
      end
    end

    new_alert_count
  end

  def generate_missed_treatment_alerts
    patient_population = self.patients_reminders_by_type("treatment")
    new_alert_count = 0

    patient_population.each do |patient|
      skipped_treatment_count = 0
      allowed_skipped = self.alert_setting.first.skipped_treatments
      reminder_ids = []

      patient.incomplete_due_reminders.each do |reminder|
        if ((Time.now - reminder.datetime) / 60 / 60) > 1
          skipped_treatment_count += 1
          reminder_ids << reminder.id
        end

        if skipped_treatment_count > allowed_skipped
          allowed_skipped *= 2

          current_alert = patient.alerts.build({
            alert_type: "treatment",
            reminders_skipped: skipped_treatment_count,
            reason: "Skipped #{skipped_treatment_count} Treatments"
          })

          patient.reminders.find(reminder_ids).each do |checked_reminder|
            checked_reminder.checked = true
            checked_reminder.save
          end

          new_alert_count += 1 if current_alert.save
        end
      end
    end

    new_alert_count
  end


  def generate_unhealthy_input_alerts
    patient_population = self.patients_input_complete_unchecked_reminders
    alert_setting = self.alert_setting
    new_alert_count = 0

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

          unless (bmi.between?(alert_setting[0].bmi_min, alert_setting[0].bmi_max))
            patient.alerts.create({
              alert_type: 'input',
              reason: "Unhealthy BMI: #{bmi} : #{reminder.id}"
            })

            new_alert_count
          end

          reminder.input_checked = true
          reminder.save
        end
      end
    end

    new_alert_count
  end


  ### Auth Methods ###
  
  # UNTESTED
  def activate!
    self.update_attribute(:active, true)
  end
  
  def set_activation_token
    self.activation_token = self.class.generate_unique_token_for_field(:activation_token)
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    user.try(:is_password?, password) ? user : nil
  end


  def self.generate_session_token
    self.generate_unique_token_for_field(:session_token)
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

  def check_uid_by_provider
    uid || provider
  end

end
