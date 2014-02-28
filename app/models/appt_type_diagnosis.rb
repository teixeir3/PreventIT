# == Schema Information
#
# Table name: appt_type_diagnoses
#
#  id           :integer          not null, primary key
#  appt_type_id :integer          not null
#  diagnosis_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ApptTypeDiagnosis < ActiveRecord::Base
  attr_accessible :appt_type, :diagnosis

  belongs_to(
    :appt_type,
    class_name: "AppointmentType",
    foreign_key: :appt_type_id,
    primary_key: :id,
    inverse_of: :appt_type_diagnoses
  )

  belongs_to(
    :diagnosis,
    class_name: "Diagnosis",
    foreign_key: :diagnosis_id,
    primary_key: :id,
    inverse_of: :appt_type_diagnoses
  )
end
