class PayTablesController < ApplicationController
  before_action :set_pay_table, only: [:show, :edit, :update, :destroy]

  # GET /pay_tables
  # GET /pay_tables.json
  def index
    @pay_tables = PayTable.all
  end

  # GET /pay_tables/1
  # GET /pay_tables/1.json
  def show
  end

  # GET /pay_tables/new
  def new
    @pay_table = PayTable.new
  end

  # GET /pay_tables/1/edit
  def edit
  end

  # POST /pay_tables
  # POST /pay_tables.json
  def create
    @pay_table = PayTable.new(pay_table_params)

    respond_to do |format|
      if @pay_table.save
        format.html { redirect_to @pay_table, notice: 'Pay table was successfully created.' }
        format.json { render :show, status: :created, location: @pay_table }
      else
        format.html { render :new }
        format.json { render json: @pay_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_tables/1
  # PATCH/PUT /pay_tables/1.json
  def update
    respond_to do |format|
      if @pay_table.update(pay_table_params)
        format.html { redirect_to @pay_table, notice: 'Pay table was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_table }
      else
        format.html { render :edit }
        format.json { render json: @pay_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_tables/1
  # DELETE /pay_tables/1.json
  def destroy
    @pay_table.destroy
    respond_to do |format|
      format.html { redirect_to pay_tables_url, notice: 'Pay table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_table
      @pay_table = PayTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_table_params
      params.require(:pay_table).permit(:count, :stamp_id, :math_model_id, :points)
    end
end
