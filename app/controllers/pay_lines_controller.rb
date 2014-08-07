class PayLinesController < ApplicationController
  before_action :set_pay_line, only: [:show, :edit, :update, :destroy]

  # GET /pay_lines
  # GET /pay_lines.json
  def index
    @pay_lines = PayLine.all
  end

  # GET /pay_lines/1
  # GET /pay_lines/1.json
  def show
  end

  # GET /pay_lines/new
  def new
    @pay_line = PayLine.new
  end

  # GET /pay_lines/1/edit
  def edit
  end

  # POST /pay_lines
  # POST /pay_lines.json
  def create
    @pay_line = PayLine.new(pay_line_params)

    respond_to do |format|
      if @pay_line.save
        format.html { redirect_to @pay_line, notice: 'Pay line was successfully created.' }
        format.json { render :show, status: :created, location: @pay_line }
      else
        format.html { render :new }
        format.json { render json: @pay_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_lines/1
  # PATCH/PUT /pay_lines/1.json
  def update
    respond_to do |format|
      if @pay_line.update(pay_line_params)
        format.html { redirect_to @pay_line, notice: 'Pay line was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_line }
      else
        format.html { render :edit }
        format.json { render json: @pay_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_lines/1
  # DELETE /pay_lines/1.json
  def destroy
    @pay_line.destroy
    respond_to do |format|
      format.html { redirect_to pay_lines_url, notice: 'Pay line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_line
      @pay_line = PayLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_line_params
      params.require(:pay_line).permit(:label, :x, :y, :slot_id)
    end
end
