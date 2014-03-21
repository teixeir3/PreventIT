# == Schema Information
#
# Table name: medications
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rxcui      :integer
#

class Medication < ActiveRecord::Base
  attr_accessible :name, :rxcui
  
  validates :name, presence: true
  
  include PgSearch
  pg_search_scope :search_on_name,
                  against: :name, :using => {:trigram => {:threshold => 0.05}}
  
  has_many(
    :patient_medications,
    class_name: "PatientMedication",
    foreign_key: :medication_id,
    primary_key: :id,
    inverse_of: :medication
  )
end
