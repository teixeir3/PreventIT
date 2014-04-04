# == Schema Information
#
# Table name: patient_medications
#
#  id                   :integer          not null, primary key
#  patient_id           :integer          not null
#  medication_id        :integer          not null
#  pt_diagnosis_id      :integer
#  start_date           :datetime
#  end_date             :datetime
#  refills              :integer          default(0), not null
#  count                :integer
#  dosage_num           :float
#  dosage_measurement   :string(255)
#  duration_num         :integer
#  duration_measurement :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  num_taken            :integer
#  num_type             :string(255)
#  schedule             :string(255)
#  note                 :text
#

require 'spec_helper'

describe PatientMedication do
  pending "add some examples to (or delete) #{__FILE__}"
end
