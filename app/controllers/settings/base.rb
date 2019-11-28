module Settings
  class Base < ApplicationController
    before_action :pass_only_logged_in_user

    protected

    def update_params(require, *permit_params)
      params.require(require).permit(permit_params)
    end
  end
end
