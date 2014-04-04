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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :patient_medication do
  end
end
