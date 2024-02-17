class TasksController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_task, only: %i[ edit update destroy completed ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Current.user.tasks.reverse
    @task = Task.new
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Current.user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('tasks', partial: @task) }
        format.html { redirect_to tasks_path }
        format.json { render :index, status: :created, location: @task }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path }
        format.json { render :index, status: :ok, location: @task }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def completed
        respond_to do |format|
      if @task.update(completed: true)
        format.html { redirect_to tasks_path }
        format.json { render :index, status: :ok, location: @task }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@task) }
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:body, :completed)
    end
end
