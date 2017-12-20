class TasksController < ApplicationController
  def index
    @tasks=Task.all
  end

  def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(message_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def message_params
    params.require(:task).permit(:content)
  end

end
