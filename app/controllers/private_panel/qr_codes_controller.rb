module PrivatePanel
  class QrCodesController < ::PrivatePanel::BaseController
    layout false

    def show
      respond_to do |format|
        format.svg  { render body: RQRCode::QRCode.new(current_user.otp_provisioning_full_url).as_svg }
      end
    end
  end
end
