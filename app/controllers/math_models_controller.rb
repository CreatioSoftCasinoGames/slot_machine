class MathModelsController < ApplicationController
  before_action :set_math_model, only: [:show, :edit, :update, :destroy]

  # GET /math_models
  # GET /math_models.json
  def index
    @math_models = MathModel.all
  end

  # GET /math_models/1
  # GET /math_models/1.json
  def show
  end

  # GET /math_models/new
  def new
    @math_model = MathModel.new
  end

  # GET /math_models/1/edit
  def edit
  end

  # POST /math_models
  # POST /math_models.json
  def create
    @math_model = MathModel.new(math_model_params)

    respond_to do |format|
      if @math_model.save
        format.html { redirect_to edit_math_model_path(@math_model), notice: 'MathModel was successfully created.' }
        format.json { render :show, status: :created, location: @math_model }
      else
        format.html { render :new }
        format.json { render json: @math_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /math_models/1
  # PATCH/PUT /math_models/1.json
  def update
    respond_to do |format|
      if @math_model.update(math_model_params)
        format.html { redirect_to edit_math_model_path(@math_model), notice: 'MathModel was successfully updated.' }
        format.json { render :show, status: :ok, location: @math_model }
      else
        format.html { render :edit }
        format.json { render json: @math_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /math_models/1
  # DELETE /math_models/1.json
  def destroy
    @math_model.destroy
    respond_to do |format|
      format.html { redirect_to math_models_url, notice: 'MathModel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_math_model
      @math_model = MathModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def math_model_params
      params.require(:math_model).permit(:name, :description, :machine_id, :version, :active)
    end
end
