# == Schema Information
#
# Table name: diagnoses
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  description :text             not null
#  code_type   :string(255)      default("ICD10"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Diagnosis do
  pending "add some examples to (or delete) #{__FILE__}"
end
