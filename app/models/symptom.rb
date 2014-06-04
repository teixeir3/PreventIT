# == Schema Information
#
# Table name: symptoms
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  patient_id  :integer          not null
#  description :text
#  intensity   :integer
#  frequency   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Symptom < ActiveRecord::Base
  attr_accessible :name, :patient, :description, :intensity, :frequency
  
  validates :name, :patient, :intensity, :frequency, presence: true
  
  belongs_to(
    :patient,
    class_name: "User",
    primary_key: :id,
    foreign_key: :patient_id,
    inverse_of: :symptoms
  )
end
