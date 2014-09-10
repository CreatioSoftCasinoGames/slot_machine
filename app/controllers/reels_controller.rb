class ReelsController < ApplicationController
  before_action :set_reel, only: [:show, :edit, :update, :destroy]

  # GET /reels
  # GET /reels.json
  def index
    @reels = Reel.all
  end

  # GET /reels/1
  # GET /reels/1.json
  def show
  end

  # GET /reels/new
  def new
    @math_model = MathModel.where(id: params[:math_model_id]).first
    @reel = Reel.new(math_model_id: @math_model.id)
  end

  # GET /reels/1/edit
  def edit
  end

  # POST /reels
  # POST /reels.json
  def create
    @reel = Reel.new(reel_params)

    respond_to do |format|
      if @reel.save
        format.html { redirect_to edit_reel_path(@reel), notice: 'Reel was successfully created.' }
        format.json { render :show, status: :created, location: @reel }
      else
        format.html { render :new }
        format.json { render json: @reel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reels/1
  # PATCH/PUT /reels/1.json
  def update
    respond_to do |format|
      if @reel.update(reel_params)
        format.html { redirect_to edit_reel_path(@reel), notice: 'Reel was successfully updated.' }
        format.json { render :show, status: :ok, location: @reel }
      else
        format.html { render :edit }
        format.json { render json: @reel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reels/1
  # DELETE /reels/1.json
  def destroy
    @reel.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Reel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reel
      @reel = Reel.find(params[:id])
      @math_model = @reel.math_model
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reel_params
      params.require(:reel).permit(:stamp_id, :size, :math_model_id, :label)
    end
end
