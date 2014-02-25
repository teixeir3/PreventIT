# == Schema Information
#
# Table name: diagnoses
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :text             not null
#  code_type   :string(255)      default("ICD10"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Diagnosis < ActiveRecord::Base
  attr_accessible :code, :description, :code_type

  validates :code, :description, presence: true

  has_many(
    :patient_diagnoses,
    class_name: "PatientDiagnoses",
    foreign_key: :diagnosis_id,
    primary_key: :id,
    inverse_of: :diagnoses,
    dependent: :destroy
  )

  has_many(
    :patients,
    through: :patient_diagnoses,
    source: :patient
  )

end
