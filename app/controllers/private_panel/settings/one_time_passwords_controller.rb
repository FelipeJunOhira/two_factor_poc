module PrivatePanel
  module Settings
    class OneTimePasswordsController < ::PrivatePanel::Settings::BaseController
      def intro
      end

      def new
        current_user.update(otp_required_for_login: User.generate_otp_secret)
        current_user.save!
      end

      def create
        if current_user.current_otp == params[:opt_check][:value]
          current_user.update(otp_required_for_login: true)

          flash[:notice] = 'OTP successfully registered!'
          redirect_to private_panel_settings_one_time_password_path
        else
          flash[:alert] = 'Something went wrong during OTP check, please try again or contact us!'
          render :new
        end
      end

      def show
      end

      def destroy
        current_user.update(otp_required_for_login: false)

        flash[:notice] = 'OTP successfully disabled!'

        redirect_to private_panel_settings_path
      end
    end
  end
end
