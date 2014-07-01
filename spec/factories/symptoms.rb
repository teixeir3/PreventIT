# == Schema Information
#
# Table name: symptoms
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  patient_id  :integer          not null
#  description :text
#  intensity   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  datetime    :datetime         not null
#  frequency   :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :symptom do
  end
end
