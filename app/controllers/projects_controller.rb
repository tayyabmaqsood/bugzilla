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
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @developers = User.all.where(user_type: 'developer')
    @qas = User.all.where(user_type: 'qa')
    authorize @project
  end

  # this view is only for developer
  def show_developer_project_details
    if current_user.user_type == 'developer'
      @project = Project.find(params[:id])
      @bugs = @project.bugs
    else
      flash[:message] = 'Oops you are not supposed to do this!'
      redirect_to controller: 'welcome', action: :user_main_page and return
    end
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
    if current_user.projects.ids.include? @project.id
      if @project.update(project_params)
        flash[:message] = 'Changes Saved'
        redirect_to controller: 'welcome', action: :user_main_page
      else
        flash[:message] = 'Uable to save changes'
        render 'projects#edit'
      end
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
    @manage = Manage.find(params[:mangeid])
    if ( @manage.user_id.to_i == params[:resourceid].to_i ) && ( @manage.project_id.to_i == params[:projectid].to_i )
      @manage.destroy
      @manage.save
      flash[:message] = 'Successfuly remove user from project'
    else
      flash[:message] = 'Uable to delete Please Dont change URL'
    end
    redirect_to project_url(params[:projectid]) and return
  end

  def add_resources
    condition = false
    @project= Project.find(params[:id])
    authorize @project
    current_user.projects.each do |project|
      if @project.id == project.id
        condition = true
      end
    end
    if condition
      @developers = User.all.where(user_type: 'developer')
      @qas = User.all.where(user_type: 'qa')
    else
      flash[:message] = 'Please dont change url'
      redirect_to controller: 'welcome', action: :user_main_page and return
    end
  end

  def add_users_to_project
    user = User.find(params[:resource_id])
    @manage = Manage.all.where(user_id: user.id, project_id: params[:project_id])
    if @manage.count.zero?
      # current_user.manages << Manage.new( user_id: user.id, project_id:  current_user.projects.ids)
      @manage = Manage.new( user_id: user.id, project_id:  params[:id])
      if @manage.save
        flash[:message] = 'Resourse Successfuly added to this project'
      else
        flash[:message] = 'Unable to assign resource to this project'
      end
    else
      flash[:message] = 'This resourse already added to same project'
    end
    redirect_to controller: 'projects', action: :add_resources and return
  end

  private

  def project_params
    params.require(:project).permit(:projectname)
  end

  def custom_authenticate_user!
    authenticate_user! if params[:user_type] == 'manager'
  end
end
