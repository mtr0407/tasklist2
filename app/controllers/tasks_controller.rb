class TasksController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks=Task.all
  end

  def show
  end

  def new
    @task=Task.new
  end

  def create
    @task = Task.new(message_params)
    
    if @task.save
      flash[:success]='Taskが正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger]='Taskは作成されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    set_message

    if @task.update(message_params)
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
  def message_params
    params.require(:task).permit(:content,:title)
  end

end
