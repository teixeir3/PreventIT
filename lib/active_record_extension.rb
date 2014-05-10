module ActiveRecordExtension

  extend ActiveSupport::Concern

  module ClassMethods
    def generate_unique_token_for_field(field)
      begin
        token = SecureRandom.urlsafe_base64(16)
      end until !self.exists?(field => token)

      token
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)