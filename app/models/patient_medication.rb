# == Schema Information
#
# Table name: patient_medications
#
#  id                   :integer          not null, primary key
#  patient_id           :integer          not null
#  medication_id        :integer          not null
#  pt_diagnosis_id      :integer
#  start_date           :datetime
#  end_date             :datetime
#  refills              :integer          default(0), not null
#  count                :integer
#  dosage_num           :float
#  dosage_measurement   :string(255)
#  duration_num         :integer
#  duration_measurement :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class PatientMedication < ActiveRecord::Base
  attr_accessible :patient, :patient_id, :medication, :pt_diagnosis, :start_date, :end_date, :refills, :count,
    :dosage_num, :dosage_measurement, :duration_num, :duration_measurement
   
  validates :patient, :medication, presence: true
    
  belongs_to(
    :medication,
    class_name: "Medication",
    foreign_key: :medication_id,
    primary_key: :id,
    inverse_of: :patient_medications
  )
  
  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :patient_medications
  )
  
  belongs_to(
    :patient_diagnosis,
    class_name: "PatientDiagnosis",
    foreign_key: :pt_diagnosis,
    primary_key: :id,
    inverse_of: :patient_medication
  )
  
  has_one(
    :diagnosis,
    through: :patient_diagnosis,
    source: :diagnosis
  )
  
  
end
