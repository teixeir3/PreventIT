# == Schema Information
#
# Table name: reminders
#
#  id         :integer          not null, primary key
#  datetime   :datetime         not null
#  title      :string(255)      not null
#  rem_type   :string(255)      not null
#  input      :integer
#  patient_id :integer          not null
#  complete   :boolean          default(FALSE), not null
#  due        :boolean          default(TRUE), not null
#  note       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reminder < ActiveRecord::Base
  DAY_STRINGS =
    ["Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"]

  attr_accessible :datetime, :title, :rem_type, :patient_id, :note

  validates :datetime, presence: true
  validates :rem_type, inclusion: { in: %w(appointment medication treatment input), message: "Invalid type" }
  validates :title, :patient_id, presence: true

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :reminders
  )

  has_many(
    :reminder_events,
    class_name: "ReminderEvent",
    foreign_key: :reminder_id,
    primary_key: :id
  )


  # Returns true if the reminder's time is passed in the current day
  def is_due?
    # self.time = self.time.change(year: Time.now.year, month: Time.now.month, day: Time.now.day)
#     ((Time.now.wday == self.day) && (Time.zone.now > self.time))
    self.datetime.past?
  end


  def day_str
    DAY_STRINGS[self.day]
  end
end
