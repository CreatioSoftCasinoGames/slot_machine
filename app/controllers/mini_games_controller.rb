class MiniGamesController < ApplicationController

  before_action :set_mini_game, only: [:show, :edit, :update, :destroy]

  # GET /mini_games
  # GET /mini_games.json
  def index
    @mini_games = MiniGame.all
  end

  # GET /mini_games/1
  # GET /mini_games/1.json
  def show
  end

  # GET /mini_games/new
  def new
    @machine = Machine.where(id: params[:machine_id]).first
    @mini_game = MiniGame.new
  end

  # GET /mini_games/1/edit
  def edit
  end

  # POST /mini_games
  # POST /mini_games.json
  def create
    @mini_game = MiniGame.new(mini_game_params)

    respond_to do |format|
      if @mini_game.save
        format.html { redirect_to edit_mini_game_path(@mini_game), notice: 'Mini game was successfully created.' }
        format.json { render :show, status: :created, location: @mini_game }
      else
        format.html { render :new }
        format.json { render json: @mini_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mini_games/1
  # PATCH/PUT /mini_games/1.json
  def update
    respond_to do |format|
      if @mini_game.update(mini_game_params)
        format.html { redirect_to edit_mini_game_path(@mini_game), notice: 'Mini game was successfully updated.' }
        format.json { render :show, status: :ok, location: @mini_game }
      else
        format.html { render :edit }
        format.json { render json: @mini_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mini_games/1
  # DELETE /mini_games/1.json
  def destroy
    @mini_game.destroy
    respond_to do |format|
      format.html { redirect_to mini_games_url, notice: 'Mini game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mini_game
      @mini_game = MiniGame.find(params[:id])
      @machine = @mini_game.machine 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mini_game_params
      params.require(:mini_game).permit(:name, :description, :machine_id)
    end
end
