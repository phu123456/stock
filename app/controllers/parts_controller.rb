class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /parts
  # GET /parts.json

  def index
    @parts = Part.search(params[:search]).order('quantity')
  end
    # @parts = Part.search((params[:q].present? ? params[:q] : '*')).records

  # GET /parts/1
  # GET /parts/1.json
  def show
  end

  # GET /parts/new
  def new
    @part = Part.new
  end

  # GET /parts/1/edit
  def edit
    @trucks = Truck.all
  end

  # POST /parts
  # POST /parts.json
  def create
    require 'date'
    d = DateTime.now
    @part = Part.new(part_params)

    # raise part_params[:name].to_json
    @history = History.new(name: part_params[:name], quantity: part_params[:quantity], update_date: d, discription: "เพิ่มเข้าสต๊อกครั้งแรก", updater: current_user.email)

    respond_to do |format|
      if @part.save && @history.save
        format.html { redirect_to parts_path, notice: 'Part was successfully created.' }
        format.json { render :show, status: :created, location: @part }
      else
        format.html { render :new }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    # save to history
    require 'date'
    d = DateTime.now
    # raise part_params[:name].to_json
    current = (@part.quantity.to_i + in_out_params[:add].to_i - in_out_params[:out].to_i).to_json
    @history = History.new(name: @part.name, quantity: in_out_params[:add].to_i - in_out_params[:out].to_i, update_date: d, plate: in_out_params[:plate], updater: current_user.email, previous: @part.quantity, current: current, discription:in_out_params[:discription])

    #update to part
    @part.quantity = (@part.quantity.to_i + in_out_params[:add].to_i - in_out_params[:out].to_i).to_json
    respond_to do |format|
      if @part.update(part_params) && @history.save
        format.html { redirect_to parts_path, notice: 'Part was successfully updated.' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part.destroy
    respond_to do |format|
      format.html { redirect_to parts_url, notice: 'Part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:name, :quantity, :search, :storage_id)
    end

    def in_out_params
      params.require(:part).permit(:add, :out, :plate, :discription)
    end
end
