class PlayersPrizesController < ApplicationController
  before_action :set_players_prize, only: [:show, :edit, :update, :destroy]

  # GET /players_prizes
  # GET /players_prizes.json
  def index
    @players_prizes = PlayersPrize.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players_prizes }
    end
  end

  # GET /players_prizes/1
  # GET /players_prizes/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @players_prize }
    end
  end

  # GET /players_prizes/new
  def new
    @players_prize = PlayersPrize.new
  end

  # GET /players_prizes/1/edit
  def edit
  end

  # POST /players_prizes
  # POST /players_prizes.json
  def create
    @players_prize = PlayersPrize.new(players_prize_params)

    respond_to do |format|
      if @players_prize.save
        format.html { redirect_to @players_prize, notice: 'Players prize was successfully created.' }
        format.json { render json: @players_prize, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @players_prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players_prizes/1
  # PATCH/PUT /players_prizes/1.json
  def update
    respond_to do |format|
      if @players_prize.update(players_prize_params)
        format.html { redirect_to @players_prize, notice: 'Players prize was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @players_prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players_prizes/1
  # DELETE /players_prizes/1.json
  def destroy
    @players_prize.destroy
    respond_to do |format|
      format.html { redirect_to players_prizes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_players_prize
      @players_prize = PlayersPrize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def players_prize_params
      params.require(:players_prize).permit(:prize_pool_percent, :next_winner_difference, :user_score_percent, :player_one_percent, :player_two_percent, :player_three_percent)
    end
end
