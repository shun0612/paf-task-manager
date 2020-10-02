class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_sort, {only: [:index]}

  def index
    @user = User.find_by(id: params[:id])
    @today = Time.now
    @user.tasks.each do |task|
      if task.deadline < @today
        if task.complete_flg == 0
          task.complete_flg = 1
          task.save
          flash[:notice] = "期限切れのタスクを完了済にしました"
        end
      end
    end
  end

  def show
    @task = Task.find_by(id: params[:id])
    if @task.deadline
      @deadline = @task.deadline.strftime("%Y/%m/%d %H:%M")
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)
    @task.complete_flg = 0
    @task.delete_flg = 0
    @task.user_id = @current_user.id
    if @task.save
      flash[:notice] = "タスクを登録しました"
      redirect_to("/tasks/#{@current_user.id}/index")
    else
      flash[:notice] = "タスク名を入力してください"
      render("tasks/new")
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(tasks_params)
      flash[:notice] = "タスク情報を編集しました"
      redirect_to("/tasks/#{@task.id}")
    else
      render("tasks/edit")
    end
  end

  def delete
    @task = Task.find_by(id: params[:id])
    @task.delete_flg = 1
    if @task.save
      flash[:notice] = "タスクを削除しました"
      redirect_to("/tasks/#{@current_user.id}/index")
    else
      render("tasks/#{@task.id}")
    end
  end

  def complete
    @task = Task.find_by(id: params[:id])
    @task.complete_flg = 1
    if @task.save
      flash[:notice] = "タスクを完了しました"
      redirect_to("/tasks/#{@current_user.id}/index")
    else
      render("tasks/#{@task.id}")
    end
  end

  def uncomplete
    @task = Task.find_by(id: params[:id])
    @task.complete_flg = 0
    if @task.save
      flash[:notice] = "タスクを未完了にしました"
      redirect_to("/tasks/#{@current_user.id}/index")
    else
      render("tasks/#{@task.id}")
    end
  end

  def sort_form
  end

  def set_sort
    if params[:sort]
      $sort = params[:sort]
    end
    if params[:search]
      $search = params[:search]
    end
  end

  def tasks_params
    params.require(:task).permit(:task_name,:subject_name,:deadline,:priority,:note)
  end

end
