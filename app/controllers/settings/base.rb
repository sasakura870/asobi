class Settings::Base < ApplicationController
  before_action :filter_only_register

  protected

  def update_params(require, *permit_params)
    params.require(require).permit(permit_params)
  end
end