# == Schema Information
#
# Table name: reminders
#
#  id            :integer          not null, primary key
#  datetime      :datetime         not null
#  title         :string(255)      not null
#  rem_type      :string(255)      not null
#  input         :integer
#  patient_id    :integer          not null
#  due           :boolean          default(FALSE), not null
#  note          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  checked       :boolean          default(FALSE), not null
#  complete      :boolean
#  sub_type      :string(255)
#  input_checked :boolean          default(FALSE), not null
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

  attr_accessible :datetime, :title, :rem_type, :patient_id, :note, :complete, :input, :sub_type, :input_checked

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


  # marks all reminders due (if their time is past)
  def self.mark_all_due
    @all_not_due_reminders = self.all_not_due
    @all_not_due_reminders.each do |reminder|
      if reminder.is_due?
        (reminder.type == "appointment") ? reminder.mark_due! : reminder.self_propagation!
      end
    end

    nil
  end

  # returns all reminders marked as not due
  def self.all_not_due
    self.find_all_by_due(false)
  end

  # Returns true if the reminder's time is passed in the current day
  # AND generates and new reminder if it's due for the 1st time
  # def mark_due
 #    if is_due?
 #      self.reminder_self_propogation
 #    end
 #  end

  def is_due?
    # self.time = self.time.change(year: Time.now.year, month: Time.now.month, day: Time.now.day)
#     ((Time.now.wday == self.day) && (Time.zone.now > self.time))


    self.datetime.past?
  end

  # def should_check_for_alert
#     self.is_due? &&
#   end


  # generates a new reminder with the same parameters 1 yr in the future
  def self_propagation!

    # if (!self.due && self.datetime.past?)
 #      self.add_new_reminder_year!
 #    end

    patient_user = self.patient
    new_attributes = self.attributes.except("id",
      "complete",
      "input",
      "due",
      "created_at",
      "updated_at"
      )

    new_rem = patient_user.reminders.build(new_attributes)
    new_rem.datetime = new_rem.datetime.advance(days: 7*12)

    patient_user.save

    self.mark_due!
  end

  def day_str
    DAY_STRINGS[self.day]
  end

  def mark_due!
    self.due = true
    self.save
  end

  def overdue_by_str
    "#{self.overdue_by} #{@overdue_str}"
  end

  def overdue_by
    overdue = (Time.now - self.datetime) / 60
    @overdue_str = "minutes"
    if overdue > 60
      overdue /=  60
      @overdue_str = "hours"
      if overdue > 24
        overdue /= 24
        @overdue_str = "days"
        if overdue > 7
          overdue /= 7
          @overdue_str = "weeks"
        end
      end
    end

    overdue.to_i
  end


  ## COME BACK HERE!!
  # def mark_complete(is_complete)
#     self.complete = is_complete
#     self.add_new_reminder_year!
#   end
end
