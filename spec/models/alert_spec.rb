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
#  reason            :string(255)
#

require 'spec_helper'

describe Alert do

end
