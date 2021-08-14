class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def user_main_page
    if current_user.user_type == 'qa'
      @users = Project.all
    else
      @users = current_user.projects.all
    end
  end
  
  def index
    if current_user.user_type == 'qa'
      @users = Project.all
    else
      @users = current_user.projects.all
    end
  end

end
