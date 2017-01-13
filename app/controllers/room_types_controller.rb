class RoomTypesController < ApplicationController
  before_action :set_room_type, only: [:edit, :update, :destroy]

  # GET /properties/:property_id/room_types/new(.:format)
  def new
    @room_type = RoomType.new
    @property = Property.find(params[:property_id])

    # Fake Values
    @room_type.name = Faker::Beer.name
    @room_type.code = @room_type.name[0, 2] + SecureRandom.hex(1).to_s
    @room_type.description = Faker::Beer.style
  end

  # GET /room_types/1/edit
  def edit
  end

  # POST /properties/:property_id/room_types(.:format)
  # create.js.erb
  def create
    # TODO: Check if Property exists

    @room_type = RoomType.new(room_type_params)
    @room_type.property_id = params[:property_id].to_i
    @room_type.save

    # respond_to do |format|
    #   if @room_type.save
    #     format.html { redirect_to @room_type, notice: 'Room type was successfully created.' }
    #     format.json { render :show, status: :created, location: @room_type }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @room_type.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /room_types/1
  # PATCH/PUT /room_types/1.json
  def update
    respond_to do |format|
      if @room_type.update(room_type_params)
        format.html { redirect_to @room_type.property, notice: 'Room type was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /room_types/1
  # DELETE /room_types/1.json
  def destroy
    @room_type.destroy
    respond_to do |format|
      format.html { redirect_to @room_type.property, notice: 'Room type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_type
      @room_type = RoomType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_type_params
      params.require(:room_type).permit(:name, :code, :description)
    end
end
