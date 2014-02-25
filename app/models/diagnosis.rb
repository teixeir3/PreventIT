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

  include PgSearch
  pg_search_scope :search_on_code_or_description,
                  against: [:code, :descrption], :using => {:trigram => {:threshold => 0.1}}


  has_many(
    :patient_diagnoses,
    class_name: "PatientDiagnosis",
    foreign_key: :diagnosis_id,
    primary_key: :id,
    inverse_of: :diagnosis,
    dependent: :destroy
  )

  has_many(
    :patients,
    through: :patient_diagnoses,
    source: :patient
  )

end
