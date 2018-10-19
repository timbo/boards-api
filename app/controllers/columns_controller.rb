class ColumnsController < ApplicationController
  before_action :set_column, only: [:show, :update, :destroy]

  # GET /columns
  def index
    @columns = Column.all

    render json: @columns
  end

  # GET /columns/1
  def show
    render json: @column
  end

  # POST /columns
  def create
    @column = Column.new(column_params)

    if @column.save
      render json: @column, include: :tasks, status: :created, location: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /columns/1
  def update
    tasks_params.each do |task|
      Task.find(task[:id]).update(task)
    end

    if @column.update(column_params)
      render json: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # DELETE /columns/1
  def destroy
    @column.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    def tasks_params
      params.fetch(:tasks).map do |p|
        p.permit(
          :id,
          :column_id,
          :position,
          :name,
          :description
        )
      end
    end

    def column_params
      params.fetch(:column, {}).permit(:name, :board_id)
    end
end
