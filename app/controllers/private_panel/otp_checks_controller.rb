module PrivatePanel
  class OtpChecksController < ::PrivatePanel::BaseController
    layout 'application'

    skip_before_action :check_otp!

    def new
      @form = ::PrivatePanel::OtpCheckForm.new
    end

    def create
      @form = ::PrivatePanel::OtpCheckForm.new(
        permitted_params.merge(user: current_user)
      )

      if @form.valid?
        session[:otp_checked] = true
        redirect_to private_panel_root_path
      else
        flash[:alert] = 'Authenticator App code invalid, please try again'
        render :new
      end
    end

    private

    def permitted_params
      params.require(:form).permit(:code)
    end
  end
end
