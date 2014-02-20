# == Schema Information
#
# Table name: healths
#
#  id         :integer          not null, primary key
#  patient_id :integer          not null
#  height     :float
#  weight     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Health < ActiveRecord::Base
  attr_accessible :height, :weight, :patient

  belongs_to(
    :patient,
    class_name: "User",
    foreign_key: :patient_id,
    primary_key: :id,
    inverse_of: :health
  )
end
