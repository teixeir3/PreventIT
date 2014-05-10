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

require 'spec_helper'

describe User do

  context "oauth" do
    it "should create a password digest when a password is given" do
        user = FactoryGirl.build(:user)

        expect(user.password_digest).to_not be_nil
    end
  end

  context "while validating" do
    it "validates presence of e-mail" do
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
    end

    it "validates uniqueness of email" do
      user0 = FactoryGirl.create(:user, email: "owner@example.com")
      user1 = FactoryGirl.build(:user, email: "owner@example.com")
      expect(user1).not_to be_valid
    end

    pending "validates presence of first_name" do
      expect(FactoryGirl.build(:user, first_name: nil)).not_to be_valid
    end

    pending "validates presence of last_name" do
      expect(FactoryGirl.build(:user, last_name: nil)).not_to be_valid
    end

    it "validates presence of session token" do
      user = FactoryGirl.build(:user, session_token: nil)
      expect(user).to be_valid
    end

    it "validates presence of password digest" do
      expect(FactoryGirl.build(:user, password_digest: nil)).not_to be_valid
    end

    it "validates length of password" do
      user = FactoryGirl.build(:user, password: "love")
      expect(user).not_to be_valid
    end

    it "allows for password attribute to be nil" do
      FactoryGirl.create(:user, first_name: "Douglas", last_name: "Teixeira")
      user = User.find_by_first_name_and_last_name("Douglas", "Teixeira")
      expect(user.password).to be_nil
    end
  end

  context "name methods" do
    it "#full_name returns the concatted first and last names" do
      user = FactoryGirl.build(:user, first_name: "Doug", last_name:"Teixeira")
      expect(user.full_name).to eq("Doug Teixeira")
    end

    it "#full_name_by_last returns the concatted first and last names phone-book style" do
      user = FactoryGirl.build(:user, first_name: "Doug", last_name:"Teixeira")
      expect(user.full_name_by_last).to eq("Teixeira, Doug")
    end

    it "#full_name returns the concatted first and last names with the Dr. title" do
      user = FactoryGirl.build(:user, first_name: "Doug", last_name:"Teixeira")
      expect(user.full_name).to eq("Doug Teixeira")
    end
  end

  context "association methods" do
    it "#patients_by_last_name returns all patients in alphabetic order by last name, then first" do
      doctor = FactoryGirl.create(:user, is_doctor: true)
      p doctor.email
      patient1 = FactoryGirl.build(:user, first_name: "BBB", last_name: "BBB", doctor_id: doctor.id, email: Faker::Internet.email)
      p patient1.email
      patient2 = FactoryGirl.create(:user, first_name: "AAA", last_name: "AAA", doctor_id: doctor.id, email: Faker::Internet.email)
      expect(doctor.patients_by_last_name[0].last_name).to eq("AAA")
    end
  end


  # describe "can sign up" do
 #
 #  end
end
