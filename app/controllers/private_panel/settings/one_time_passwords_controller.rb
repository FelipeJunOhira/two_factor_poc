module PrivatePanel
  module Settings
    class OneTimePasswordsController < ::PrivatePanel::Settings::BaseController
      def intro
      end

      def new
        current_user.update(otp_secret: User.generate_otp_secret)
        current_user.save!

        @form = PrivatePanel::Settings::OneTimePasswordForm.new
      end

      def create
        @form = PrivatePanel::Settings::OneTimePasswordForm.new(
          permitted_params.merge(user: current_user)
        )

        if @form.valid?
          current_user.update(otp_required_for_login: true)

          flash[:notice] = '2FA successfully configured! Next time you login we will required the 2FA code'
          session[:otp_checked] = true
          redirect_to private_panel_settings_path
        else
          flash[:alert] = 'Something went wrong during OTP check'
          render :new
        end
      end

      def destroy
        current_user.update(otp_required_for_login: false)

        flash[:notice] = 'OTP successfully disabled!'

        redirect_to private_panel_settings_path
      end

      private

      def permitted_params
        params.require(:form).permit([:code])
      end
    end
  end
end
