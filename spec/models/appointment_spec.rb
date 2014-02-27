# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  patient_id :integer          not null
#  doctor_id  :integer
#  datetime   :datetime         not null
#  reason     :string(255)      not null
#  note       :text
#  met        :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Appointment do
  pending "add some examples to (or delete) #{__FILE__}"
end
