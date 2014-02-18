# == Schema Information
#
# Table name: reminders
#
#  id         :integer          not null, primary key
#  day        :integer          not null
#  time       :time             not null
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

require 'spec_helper'

describe Reminder do
  pending "add some examples to (or delete) #{__FILE__}"
end
