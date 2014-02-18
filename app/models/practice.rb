# == Schema Information
#
# Table name: practices
#
#  id         :integer          not null, primary key
#  specialty  :string(255)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Practice < ActiveRecord::Base
  attr_accessible :specialty, :name

  validates :specialty, :name, presence: true

  has_many(
    :doctors,
    class_name: "User",
    foreign_key: :practice_id,
    primary_key: :id,
    inverse_of: :practice
  )
end
