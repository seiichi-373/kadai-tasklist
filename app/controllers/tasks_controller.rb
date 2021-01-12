class TasksController < ApplicationController
  include TasksHelper
  
  def index
    if logged_in?
    @tasks = current_user.tasks
    else
    redirect_to login_path
    end
  end
  
  def show
    if logged_in?
    @task = Task.find(params[:id])
    else
    redirect_to login_path
    end
  end
  
  def new
    if logged_in?
    @task = Task.new
    else
    redirect_to login_path
    end
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
      
      
    end
  end
  
  def edit
    if logged_in?
    @task = Task.find(params[:id])
    else
    redirect_to login_path
    end
  end
  
  def update
    @task = Task.find(params[:id])
    
      if @task.update(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Task は更新されませんでした'
        render :edit
      end
  end
  
  def destroy
    if logged_in?
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
    else
    redirect_to login_path
    end
  end
  
  private
  
  # strong parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
