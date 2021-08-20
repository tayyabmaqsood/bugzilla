class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def user_main_page
    @projects = current_user.projects.all
  end
end
