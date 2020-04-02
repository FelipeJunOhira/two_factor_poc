module PrivatePanel
  class BaseController < ::ApplicationController
    layout 'private_panel'

    before_action :authenticate_user!
    before_action :check_otp!

    private

    def check_otp!
      if current_user.otp_required_for_login? && !session[:otp_checked]
        redirect_to new_private_panel_otp_checks_path
      end
    end
  end
end
