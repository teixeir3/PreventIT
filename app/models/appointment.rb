# == Schema Information
#
# Table name: appointments
#
#  id                  :integer          not null, primary key
#  patient_id          :integer          not null
#  doctor_id           :integer
#  datetime            :datetime         not null
#  note                :text
#  met                 :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  appointment_type_id :integer
#

class Appointment < ActiveRecord::Base
  attr_accessible :patient, :doctor, :datetime, :reason, :note, :met, :appointment_type

  validates :patient, :datetime, :reason, :met, presence: true

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :appointments
  )

  belongs_to(
    :appointment_type,
    class_name: "AppointmentType",
    foreign_key: :appointment_type_id,
    primary_key: :id,
    inverse_of: :appointments
  )
end
