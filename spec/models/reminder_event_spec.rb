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

require 'spec_helper'

describe ReminderEvent do
  pending "add some examples to (or delete) #{__FILE__}"
end
