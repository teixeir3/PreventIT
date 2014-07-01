# == Schema Information
#
# Table name: symptoms
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  patient_id  :integer          not null
#  description :text
#  intensity   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  datetime    :datetime         not null
#  frequency   :string(255)
#

class Symptom < ActiveRecord::Base
  attr_accessible :name, :patient, :description, :intensity, :frequency, :datetime
  
  def self.frequencies
    ["Multiple times / day", "Once / day", "Occassionally", "Sometimes", "Once"]
  end
  
  validates :name, :patient, :intensity, :frequency, :datetime, presence: true
  validates :name, uniqueness: { scope: :datetime, message: ": Symptom already exists." }
  validates :frequency, inclusion: { in: self.frequencies, message: "%{value} is not a valid frequency" }
  
  belongs_to(
    :patient,
    class_name: "User",
    primary_key: :id,
    foreign_key: :patient_id,
    inverse_of: :symptoms
  )
  
end
