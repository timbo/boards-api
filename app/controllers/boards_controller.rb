class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]

  # GET /boards
  def index
    @boards = Board.all

    render json: @boards
  end

  # GET /boards/1
  def show
    render json: @board, include: {columns: {include: :tasks}}
  end

  # POST /boards
  def create
    @board = Board.new(board_params)

    if @board.save
      render json: @board, status: :created, location: @board
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /boards/1
  def update
    if @board.update(board_params)
      render json: @board
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # DELETE /boards/1
  def destroy
    Board.destroy(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.includes(columns: :tasks).where(:id => params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def board_params
      params.fetch(:board, {}).permit(:name, :columns => [])
    end
end
