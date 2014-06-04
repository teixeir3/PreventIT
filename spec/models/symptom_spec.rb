# == Schema Information
#
# Table name: symptoms
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  patient_id  :integer          not null
#  description :text
#  intensity   :integer
#  frequency   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Symptom do
  pending "add some examples to (or delete) #{__FILE__}"
end
