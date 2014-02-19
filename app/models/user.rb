# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  first_name      :string(255)
#  last_name       :string(255)
#  phone           :string(255)
#  doctor_id       :integer
#  practice_id     :integer
#  is_doctor       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :first_name, :last_name, :phone
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true, uniqueness: true

  before_validation :ensure_session_token

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

  #### Doctor Associations ####
  has_many(
    :patients,
    class_name: "User",
    foreign_key: :doctor_id,
    primary_key: :id
  )

  belongs_to(
    :practice,
    class_name: "Practice",
    foreign_key: :practice_id,
    primary_key: :id,
    inverse_of: :doctors
  )

  def due_reminders
    self.reminders.select
  end

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
