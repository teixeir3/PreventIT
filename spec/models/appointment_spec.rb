# == Schema Information
#
# Table name: appointments
#
#  id                  :integer          not null, primary key
#  patient_id          :integer          not null
#  doctor_id           :integer
#  datetime            :datetime         not null
#  note                :text
#  met                 :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  appointment_type_id :integer
#

require 'spec_helper'

describe Appointment do

end
