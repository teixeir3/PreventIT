# == Schema Information
#
# Table name: appointment_types
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  recurrence          :boolean          default(FALSE), not null
#  occurence_frequency :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  doctor_id           :integer          not null
#

class AppointmentType < ActiveRecord::Base
  attr_accessible :name, :recurrence, :occurence_frequency, :doctor

  validates :name, :doctor, presence: true

  belongs_to(
    :doctor,
    class_name: "User",
    foreign_key: :doctor_id,
    primary_key: :id,
    inverse_of: :appointment_types
  )

  has_many(
    :appointments,
    class_name: "Appointment",
    foreign_key: :appointment_type_id,
    primary_key: :id,
    inverse_of: :appointment_type
  )
  
  has_many(
    :scheduled_patients,
    through: :appointments,
    source: :patient
  )

  has_many(
    :appt_type_diagnoses,
    class_name: "ApptTypeDiagnosis",
    foreign_key: :appt_type_id,
    primary_key: :id,
    inverse_of: :appt_type,
    dependent: :destroy
  )

  has_many(:diagnoses, through: :appt_type_diagnoses, source: :diagnosis)
  
  # All the patients that are eligble to schedule this appt_type.
  has_many(:eligible_patients, through: :diagnoses, source: :patients)

end
