module PrivatePanel
  class BaseController < ::ApplicationController
    layout 'private_panel'

    before_action :authenticate_user!
  end
end
