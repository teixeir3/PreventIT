# == Schema Information
#
# Table name: reminders
#
#  id         :integer          not null, primary key
#  day        :string(255)      not null
#  time       :time             not null
#  title      :string(255)      not null
#  rem_type   :string(255)      not null
#  input      :integer
#  patient_id :integer          not null
#  complete   :boolean          default(FALSE), not null
#  note       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reminder < ActiveRecord::Base
  attr_accessible :day, :time, :title, :rem_type, :patient_id, :note

  validates :day, presence: true, inclusion: { in: 0...7, message: "%{value} is not a valid day" }
  validates :rem_type, inclusion: { in: %w(appointment medication treatment input), message: "Invalid type" }
  validates :time, :title, :patient_id, presence: true

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :reminders
  )

  def is_due?
    self.time = self.time.change(year: Time.now.year, month: Time.now.month, day: Time.now.day)
    ((Time.now.wday == self.day) && (Time.zone.now > self.time))
  end
end
