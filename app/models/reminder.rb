# == Schema Information
#
# Table name: reminders
#
#  id              :integer          not null, primary key
#  datetime        :datetime         not null
#  title           :string(255)      not null
#  input           :integer
#  patient_id      :integer          not null
#  due             :boolean          default(FALSE), not null
#  note            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  checked         :boolean          default(FALSE), not null
#  complete        :boolean
#  sub_type        :string(255)
#  input_checked   :boolean          default(FALSE), not null
#  remindable_id   :integer
#  remindable_type :string(255)
#  parent_id       :integer          default(0), not null
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
      
  REMINDABLE_TYPES =
    ["Appointment",
      "Medication",
      "Treatment",
      "Input",
      "Symptom",
      "Other"]

  attr_accessible :datetime, :title, :remindable_type, :remindable, :patient_id, :note, :complete, :input, :sub_type, :input_checked, :patient, :parent

  validates :datetime, presence: true
  validates :remindable_type, presence: true, inclusion: { in: Reminder::REMINDABLE_TYPES, message: "Invalid type" }
  validates :title, :patient, presence: true

  before_validation :ensure_valid_remindable_type

  belongs_to(
    :remindable,
    polymorphic: true,
    foreign_key: :remindable_id,
    primary_key: :id,
    inverse_of: :reminders
  )

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :reminders
  )
  
  belongs_to(
    :parent,
    class_name: "Reminder",
    foreign_key: :parent_id,
    primary_key: :id,
    inverse_of: :children,
    dependent: :destroy
  )

  has_many(
    :children,
    class_name: "Reminder",
    foreign_key: :parent_id,
    primary_key: :id,
    inverse_of: :parent
  )
  
  
  ############ Class Methods #################
  ###############################################
  
  def self.day_strings
    self::DAY_STRINGS
  end
  
  def self.remindable_types
    self::REMINDABLE_TYPES
  end
  
  
  # marks all reminders due (if their time is past)
  def self.mark_all_due
    @all_not_due_reminders = self.all_not_due
    @all_not_due_reminders.each do |reminder|
      if reminder.is_due?
        reminder.mark_due!
        reminder.self_propagation! unless (reminder.remindable_type == "Appointment")
      end
    end

    nil
  end

  # returns all reminders marked as not due
  def self.all_not_due
    self.find_all_by_due(false)
  end
  
  # Factory method returning a reminder given an associated appointment
  def self.create_appt_reminder(appt)
    reminder = appt.reminders.create({
            datetime: appt.datetime,
            title: "#{appt.appointment_type.name} appointment w/ #{appt.doctor.doctor_full_name}",
            patient_id: appt.patient_id,
            sub_type: appt.appointment_type.name
          })
    
  end

  # Returns true if the reminder's time is passed in the current day
  # AND generates and new reminder if it's due for the 1st time
  # def mark_due
 #    if is_due?
 #      self.reminder_self_propogation
 #    end
 #  end

  
 ############ Instance Methods #################
 ###############################################
 
 def ensure_valid_remindable_type
   self.remindable_type = "Other" unless Reminder::REMINDABLE_TYPES.include?(self.remindable_type)
   self.remindable_id = nil if self.remindable_type == "Other"
 end
 
 # Returns true / false if the reminder is due
  def is_due?
    self.datetime.past?
  end

  # def should_check_for_alert
#     self.is_due? &&
#   end


  ## OLD WAY
  # generates a new reminder with the same parameters 1 yr in the future
  # def self_propagation!
 # 
 #    # if (!self.due && self.datetime.past?)
 # #      self.add_new_reminder_year!
 # #    end
 # 
 #    patient_user = self.patient
 #    new_attributes = self.attributes.except("id",
 #      "complete",
 #      "input",
 #      "due",
 #      "created_at",
 #      "updated_at"
 #      )
 # 
 #    new_rem = patient_user.reminders.build(new_attributes)
 #    new_rem.datetime = new_rem.datetime.advance(days: 7*12)
 # 
 #    patient_user.save
 # 
 #    self.mark_due!
 #  end

 # generates a new reminder with the same parameters 1 yr in the future
  def self_propagation!
    new_rem = self.self_propagation
    new_rem.save

    new_rem
  end
  
  def self_propagation
    remindable = self.remindable
    new_attributes = self.attributes.except("id",
      "complete",
      "input",
      "due",
      "created_at",
      "updated_at",
      "remindable_id",
      "checked",
      "parent_id"
    )

    new_rem = remindable.reminders.build(new_attributes)
    new_rem.parent = self
    new_rem.datetime = new_rem.datetime.advance(weeks: 12)
    
    new_rem
  end

  # Returns the day of the week in which the reminder is due corrected for the patient's timezone.
  def day_str(timezone = patient.timezone)
    parsed_time(timezone).strftime("%A")
  end
  
  # Returns the day of the week in which the reminder is due in UTC
  def utc_day_str
    self.datetime.strftime("%A")
  end

  # marks the reminder as due and saves. Returns true / false if it saved
  def mark_due!
    self.due = true
    self.save
  end

  # returns a string of the reduced amount the reminder is overdue by
  def overdue_by_str
    "#{self.overdue_by} #{@overdue_str}"
  end

  # returns the lowest denomination of how much it's overdue
  def overdue_by
    @overdue_str = "minutes"
    
    overdue = (((self.is_due?) ? (Time.zone.now - self.datetime) : (self.datetime - Time.zone.now)) / 60).to_i 

    if overdue > 60
      overdue /=  60
      @overdue_str = "hours"
      if overdue > 24
        overdue /= 24
        @overdue_str = "days"
        if overdue > 7
          overdue /= 7
          @overdue_str = "weeks"
          if overdue > 4
            overdue /= 4
            @overdue_str = "months"
          end
        end
      end
    end
    
    @overdue_str = @overdue_str[0..-2] if overdue == 1
    
    overdue
  end
  
  
  
  # returns the datetime converted in the provided timezone or patient's timezone by default.
  def parsed_time(timezone = patient.timezone)
    self.datetime.in_time_zone(timezone)
  end


  # def mark_complete(is_complete)
#     self.complete = is_complete
#     self.add_new_reminder_year!
#   end

end
