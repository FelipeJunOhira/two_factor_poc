module PrivatePanel
  class OtpCheckForm
    include ActiveModel::Model

    attr_accessor :code, :user

    validates :code, presence: true
    validate :code_matches_user_otp

    private

    def code_matches_user_otp
      return if user.current_otp == code

      errors.add(:code, :invalid)
    end
  end
end
