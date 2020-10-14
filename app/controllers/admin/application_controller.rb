module Admin
  class ApplicationController < ActionController::Base
    before_action :authenticate_admin_user!

    layout 'admin/application'
  end
end

