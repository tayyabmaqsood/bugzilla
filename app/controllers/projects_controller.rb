class ProjectsController < ApplicationController
  before_action :authenticate_user!
  def new
    @project = current_user.projects.build
    authorize @project
  end

  def create
    @project = current_user.projects.create(project_params)
    authorize @project
    if @project.save
      flash[:message] = 'New Project is created'
      redirect_to root_path_url
    else
      render new_project_path
    end
  end

  def show
    @project = Project.find(params[:id])
    @developers = valid_users_to_remove('developer')
    @qas = valid_users_to_remove('qa')
    authorize @project
  end

  # this view is only for developer
  def show_developer_project_details
    @project = Project.find(params[:id])
    @bugs = @project.bugs.where(bug_status: 'new')
    authorize @project
  end

  def index
    @projects = current_user.projects.all
    authorize @projects
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(params[:id])
    authorize @project
    if @project.update(project_params)
      flash[:message] = 'Changes Saved'
      redirect_to controller: 'welcome', action: :user_main_page
    else
      flash[:message] = 'Uable to save changes'
      render edit_project_url(@project)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project
    if @project.destroy
      flash[:message] = 'Record Successfuly Delete'
    else
      flash[:message] = 'Record not found'
    end
    redirect_to controller: 'welcome', action: :user_main_page
  end

  def remove_users_from_project
    @manage = Manage.find_by(user_id: params[:resourceid], project_id: params[:projectid])
    @resource_id = params[:resourceid]
    if !@manage.nil?
      @manage.destroy
      flash[:message] = 'Successfuly remove user from project'
    else
      flash[:message] = 'Uable to delete Please Dont change URL'
    end
  end

  def add_resources
    @project = current_user.projects.find(params[:id])
    authorize @project
    @developers = valid_users_to_add('developer')
    @qas = valid_users_to_add('qa')
  end

  def add_users_to_project
    user = User.find(params[:resource_id])
    @resource_id = params[:resource_id]
    if user_already_assigned?(user)
      @manage = Manage.new(user_id: user.id, project_id: params[:id])
      flash[:message] = 'Resourse Successfuly added to this project' if @manage.save
    else
      flash[:message] = 'This resourse already added to same project'
    end
  end

  private

  def project_params
    params.require(:project).permit(:projectname, :project_description)
  end

  def valid_users_to_add(user_type)
    user_list = []
    User.where(user_type: user_type.to_s).find_each do |user|
      user_list.append(user.id.to_i) if Manage.find_by(project_id: params[:id], user_id: user.id).nil?
    end
    User.where(id: user_list)
  end

  def valid_users_to_remove(user_type)
    user_list = []
    User.where(user_type: user_type.to_s).find_each do |user|
      user_list.append(user.id.to_i) unless Manage.find_by(project_id: params[:id], user_id: user.id).nil?
    end
    User.where(id: user_list)
  end

  def user_already_assigned?(user)
    @manage = Manage.where(user_id: user.id, project_id: params[:project_id])
    @manage.count.zero?
  end
end
