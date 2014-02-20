# == Schema Information
#
# Table name: alert_settings
#
#  id                   :integer          not null, primary key
#  doctor_id            :integer          not null
#  skipped_meds         :integer          default(2), not null
#  skipped_appointments :integer          default(2), not null
#  bmi_min              :float            default(18.4), not null
#  bmi_max              :float            default(25.0), not null
#  a1c_min              :float            default(18.4), not null
#  a1c_max              :float            default(25.0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class AlertSetting < ActiveRecord::Base
  attr_accessible :doctor, :skipped_meds, :skipped_appointments, :bmi_min, :bmi_max, :a1c_min, :a1c_max

  validates :doctor, :skipped_meds, :skipped_appointments, :bmi_min, :bmi_max, :a1c_min, :a1c_max, presence: true

  belongs_to(
      :doctor,
      class_name: "User",
      foreign_key: :doctor_id,
      primary_key: :id,
      inverse_of: :alert_setting
    )


end
