class BugsController < ApplicationController
  def index
    @user = current_user
    @project = Project.find(params[:project_id])
    @bugs = @project.bugs
  end

  def new
    @project = Project.find(params[:project_id])
    redirect_to controller: 'welcome', action: :user_main_page and return if @project.nil?

    @bug = @project.bugs.build
    authorize @bug
  end

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.create(bug_params)
    if @bug.save
      flash[:message] = "Bug successfully repoted against #{@project.projectname}"
      redirect_to controller: 'welcome', action: :user_main_page
    else
      flash[:message] = 'Unable to create bug please fill all fields and try again'
      redirect_to new_project_bug_url(@project.id)
    end
  end

  def assign_bug_to_developer
    assigned_user = Manage.find_by(user_id: current_user.id, project_id: params[:project_id])
    unless assigned_user.nil?
      @project = Project.find(params[:project_id])
      if @project.bugs.ids.include? params[:bug_id].to_i
        @report = Report.find_by(bug_id: params[:bug_id])
        @bug = Bug.find(params[:bug_id])
        authorize @bug
        if @report.nil?
          @report = Report.new(user_id: current_user.id, bug_id: params[:bug_id])
          @bug.bug_status = 'started'
          @bug.save
          if @report.save
            flash[:message] = "Bug Successfully assigned to #{@current_user.username}"
          else
            flash[:message] = 'Unable to assign bug'
          end
        else
          flash[:message] = 'This bug is already assigned to some user'
        end
        redirect_to developer_project_show_path(@project.id)
      else
        redirect_to controller: 'welcome', action: 'user_main_page'
      end
    end
  end

  def show
    @report = Report.find_by(bug_id: params[:bug_id])
    @bug = Bug.find(params[:bug_id])
    @project = Project.find(params[:project_id])
  end

  def mark_resolve
    @bug = Bug.find(params[:bug_id])
    @bug.bug_status = 'completed' if @bug.bug_type == 'feature'
    @bug.bug_status = 'resolved' if @bug.bug_type == 'bug'
    if @bug.save
      flash[:message] = 'Good work you have done your job'
      redirect_to root_path_url
    end
  end

  def destroy
    @bug = Bug.find(params[:id])
    @project = Project.find(params[:project_id])
    if @bug.destroy
      flash[:message] = 'Bug successfully deleted'
      flash[:message] = 'Bug not found'
    end
    redirect_to project_bugs_url
  end

  private

  def bug_params
    params.require(:bug).permit(:screenshot, :title, :deadline, :bug_type, :bug_status)
  end
end
