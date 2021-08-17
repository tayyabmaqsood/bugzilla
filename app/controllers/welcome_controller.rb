class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def user_main_page
    @users = current_user.projects.all
  end

  def index
    @users = current_user.projects.all
  end

end
