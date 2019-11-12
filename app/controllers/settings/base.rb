module Settings
  class Base < ApplicationController
    before_action :filter_only_logged_in_users

    protected

    def update_params(require, *permit_params)
      params.require(require).permit(permit_params)
    end
  end
end
