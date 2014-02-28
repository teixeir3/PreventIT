# == Schema Information
#
# Table name: appointment_types
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  recurrence          :boolean          default(FALSE), not null
#  occurence_frequency :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  doctor_id           :integer          not null
#

require 'spec_helper'

describe AppointmentType do
  pending "add some examples to (or delete) #{__FILE__}"
end
