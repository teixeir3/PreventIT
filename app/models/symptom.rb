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

class Symptom < ActiveRecord::Base
  # attr_accessible :title, :body
end
