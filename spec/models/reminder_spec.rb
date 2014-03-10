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

require 'spec_helper'

describe Reminder do

end
