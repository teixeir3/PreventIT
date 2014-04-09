# == Schema Information
#
# Table name: patient_medications
#
#  id              :integer          not null, primary key
#  patient_id      :integer          not null
#  medication_id   :integer          not null
#  pt_diagnosis_id :integer
#  start_date      :datetime
#  end_date        :datetime
#  refills         :integer          default(0), not null
#  count           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  num_taken       :integer
#  note            :text
#  description     :string(255)
#  frequency       :integer
#  time_period     :string(255)
#

class PatientMedication < ActiveRecord::Base
  attr_accessible :description, :patient, :patient_id, :medication, :pt_diagnosis, :diagnosis,
  :pt_diagnosis_id, :start_date, :end_date, :refills, :count, :num_taken, :frequency, :time_period, :note
   
  validates :patient, :medication, :description, presence: true
    
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
    foreign_key: :pt_diagnosis_id,
    primary_key: :id,
    inverse_of: :patient_medications
  )
  
  has_one(
    :diagnosis,
    through: :patient_diagnosis,
    source: :diagnosis
  )
  
  
end
