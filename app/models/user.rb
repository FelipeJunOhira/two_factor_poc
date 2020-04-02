class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :database_authenticatable,
         :rememberable, :validatable,
         :two_factor_authenticatable,
         otp_secret_encryption_key: ENV['2FA_OTP_SECRET_ENCRYPTION_KEY']

  def otp_provisioning_full_url
    issuer = Rails.application.class.name

    otp_provisioning_uri("#{issuer}:#{email}", issuer: issuer)
  end
end
