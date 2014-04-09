# == Schema Information
#
# Table name: patient_medications
#
#  id              :integer          not null, primary key
#  patient_id      :integer          not null
#  medication_id   :integer          not null
#  pt_diagnosis_id :integer
#  start_date      :datetime
#  end_date        :datetime
#  refills         :integer          default(0), not null
#  count           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  num_taken       :integer
#  note            :text
#  description     :string(255)
#  frequency       :integer
#  time_period     :string(255)
#

require 'spec_helper'

describe PatientMedication do
  pending "add some examples to (or delete) #{__FILE__}"
end
