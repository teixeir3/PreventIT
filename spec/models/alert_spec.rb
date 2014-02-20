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
#  reason            :string(255)      not null
#

require 'spec_helper'

describe Alert do
  pending "add some examples to (or delete) #{__FILE__}"
end
