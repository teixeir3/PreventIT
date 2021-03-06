# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      not null
#  password_digest        :string(255)      not null
#  session_token          :string(255)      not null
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  doctor_id              :integer
#  practice_id            :integer
#  is_doctor              :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  email_notifications    :boolean          default(TRUE), not null
#  uid                    :string(255)
#  access_token           :string(255)
#  provider               :string(255)
#  active                 :boolean          default(FALSE), not null
#  activation_token       :string(255)      default("INACTIVE"), not null
#  timezone               :string(255)      default("Eastern Time (US & Canada)"), not null
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

FactoryGirl.define do
  factory :user do |f|
    f.email Faker::Internet.email
    f.first_name Faker::Name.first_name
    f.last_name Faker::Name.last_name
    f.phone Faker::PhoneNumber.phone_number
    f.password "password"
    
    sequence :reminder do |n|
      Factorygirl.create(:reminder)
    end
  end
end
