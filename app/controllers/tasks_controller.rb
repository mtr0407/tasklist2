class TasksController < ApplicationController
  before_action :require_user_logged_in, except: [:index]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def show
  end

  def new
    @task=Task.new
  end

  def create
    @task = current_user.tasks.build(tasks_params)
    
    if @task.save
      flash[:success]='Taskが正常に作成されました'
      redirect_to @task
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger]='Taskは作成されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    set_message

    if @task.update(tasks_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_message
    @task = Task.find(params[:id])
  end

  # Strong Parameter
  def tasks_params
    params.require(:task).permit(:content,:title,:status,:user)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end


end
