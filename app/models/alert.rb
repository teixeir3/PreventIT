# == Schema Information
#
# Table name: alerts
#
#  id                :integer          not null, primary key
#  patient_id        :integer          not null
#  alert_type        :string(255)      not null
#  complete          :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reminders_skipped :integer
#  reason            :string(255)
#

class Alert < ActiveRecord::Base
  attr_accessible :patient, :patient_id, :alert_type, :complete, :reminders_skipped, :reason

  validates :patient, presence: true
  validates :alert_type, presence: true, inclusion: { in: %w(appointment medication treatment input), message: "Invalid type" }

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :alerts
  )

  has_one(
    :doctor,
    through: :patient,
    source: :doctor
  )

  def complete_str
    (self.complete) ? "complete" : "incomplete"
  end
  
  def complete?
    self.complete
  end
end
