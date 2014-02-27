# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  patient_id :integer          not null
#  doctor_id  :integer
#  datetime   :datetime         not null
#  reason     :string(255)      not null
#  note       :text
#  met        :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Appointment < ActiveRecord::Base
  attr_accessible :patient, :doctor, :datetime, :reason, :note, :met

  validates :patient, :datetime, :reason, :met, presence: true

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :appointments
  )
end
