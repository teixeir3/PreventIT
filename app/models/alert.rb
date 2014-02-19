# == Schema Information
#
# Table name: alerts
#
#  id         :integer          not null, primary key
#  patient_id :integer          not null
#  alert_type :string(255)      not null
#  complete   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Alert < ActiveRecord::Base
  attr_accessible :patient, :patient_id, :alert_type, :complete
end
