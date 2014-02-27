# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)      not null
#  password_digest     :string(255)      not null
#  session_token       :string(255)      not null
#  first_name          :string(255)
#  last_name           :string(255)
#  phone               :string(255)
#  doctor_id           :integer
#  practice_id         :integer
#  is_doctor           :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  email_notifications :boolean          default(TRUE), not null
#  uid                 :string(255)
#  access_token        :string(255)
#  provider            :string(255)
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"

  # describe "can sign up" do
 #
 #  end
end
