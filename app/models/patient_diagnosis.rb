# == Schema Information
#
# Table name: patient_diagnoses
#
#  id           :integer          not null, primary key
#  diagnosis_id :integer          not null
#  patient_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PatientDiagnosis < ActiveRecord::Base
  attr_accessible :diagnosis, :patient

  validates :patient, :diagnosis, presence: true
  validates :diagnosis_id, uniqueness: { scope: :patient_id, message: " already exists!" }

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient_diagnoses
  )

  belongs_to(
    :diagnosis,
    class_name: "Diagnosis",
    foreign_key: :diagnosis_id,
    primary_key: :id,
    inverse_of: :patient_diagnoses
  )

end
