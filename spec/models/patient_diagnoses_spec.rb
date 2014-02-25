# == Schema Information
#
# Table name: patient_diagnoses
#
#  id           :integer          not null, primary key
#  diagnosis_id :integer          not null
#  patient_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe PatientDiagnoses do
  pending "add some examples to (or delete) #{__FILE__}"
end
