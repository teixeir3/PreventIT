# == Schema Information
#
# Table name: reminder_events
#
#  id          :integer          not null, primary key
#  reminder_id :integer          not null
#  metric      :integer
#  note        :text
#  complete    :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ReminderEvent < ActiveRecord::Base
  attr_accessible :reminder, :reminder_id, :metric, :note, :complete

  validates :reminder, presence: true

  belongs_to(
    :reminder,
    class_name: "Reminder",
    foreign_key: :reminder_id,
    primary_key: :id
  )

  has_one :patient, through: :reminder, source: :patient
end
