# == Schema Information
#
# Table name: medications
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rxcui      :integer
#

require 'spec_helper'

describe Medication do
  pending "add some examples to (or delete) #{__FILE__}"
end
