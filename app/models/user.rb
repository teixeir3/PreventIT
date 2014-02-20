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
    self.patients.joins(:reminders).where("reminders.rem_type = ?", type).includes(:reminders)
  end

  ### Alert Methods (for doctor)###
  def patients_with_reminders
    self.patients.includes(:reminders)
  end

  def generate_all_alerts
    self.generate_medication_alerts
  end

  # TODO: NOT TESTED: MAKING SEED FILE FIRST
  def generate_medication_alerts
    patient_population = self.patients_reminders_by_type("medication")
    allowed_skipped = self.alert_setting.first.skipped_meds
    skipped_med_count = 0

    patient_population.each do |patient|
      patient.incomplete_due_reminders.each do |reminder|
        skipped_med_count += 1 if ((Time.now - reminder.datetime) / 60 / 60) > 1
        puts ((reminder.datetime - Time.now) / 60 / 60)
        reminder.checked = true
      end

      if skipped_med_count > allowed_skipped
        current_alert = patient.alerts.build({
          alert_type: "medication",
          reminders_skipped: skipped_med_count
        })

        current_alert.save
      end
    end

    nil
  end

  def generate_appointment_alerts
    patient_population = self.patients_reminders_by_type("appointment")
    allowed_skipped = self.alert_setting.first.skipped_appointments
    skipped_appointment_count = 0

    patient_population.each do |patient|
      patient.incomplete_due_reminders.each do |reminder|
        skipped_appointment_count += 1 if ((Time.now - reminder.datetime) / 60 / 60) > 1
        puts ((reminder.datetime - Time.now) / 60 / 60)
        reminder.checked = true
      end

      if skipped_appointment_count > allowed_skipped
        current_alert = patient.alerts.build({
          alert_type: "medication",
          reminders_skipped: skipped_med_count
        })

        current_alert.save
      end
    end

    nil
  end

  def generate_BMI_alerts

  end

  def generate_A1C_alerts

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

  private

  def is_patient_doctor?(patient_id)
    (self.is_doctor && self.patient_ids.include?(patient_id))
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
