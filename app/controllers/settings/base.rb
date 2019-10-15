class Settings::Base < ApplicationController
  before_action :filter_only_register
  # layout 'left_sidemenu'
end