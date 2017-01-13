class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    if (current_user.property == nil)
      @properties = Property.all
    else
      redirect_to current_user.property
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @address = @property.address

    # For displaying all users
    @users = @property.users

    # For displaying all room types
    @room_types = @property.room_types
  end

  # GET /properties/new
  def new
    @address = Address.new
    @address.address1 = Faker::Address.street_address
    @address.city = Faker::Address.city
    @address.state = Faker::Address.state
    @address.zip = Faker::Address.zip
    @address.country = Faker::Address.country
    @address.phone = Faker::PhoneNumber.cell_phone
    
    @property = Property.new
    @property.name = Faker::Company.name
  end

  # GET /properties/1/edit
  def edit
    @address = @property.address
  end

  # POST /properties
  # POST /properties.json
  def create
    # Save the address
    @address = Address.new(address_params)
    if @address.save
      puts "Address Created by #{current_user}"
    else
      # Address couldn't be saved
      flash[:alert] = "Address couldn't be saved"
      redirect_to new_property_url
      return
    end

    # Save the property
    @property = Property.new(property_params)
    @property.access_code = SecureRandom.hex(3)
    @property.address = @address

    if @property.save
      # set the current user's property
      current_user.property_id = @property.id
      current_user.save
      redirect_to properties_url, notice: 'Property was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /properties/current_user_joins
  def current_user_joins
    # if current user already belongs to a property
    if (current_user.property != nil)
      redirect_to current_user.property
      return
    end
    
    # get property id from params
    pid = params[:user][:property_id].to_i

    # http://stackoverflow.com/questions/1017210/rails-flash-message-remains-for-two-page-loads
    
    # if property id is 0 or null
    if ((pid == nil) || (pid == 0))
      flash.now[:error] = "Property not selected or does not exist"
      render "index"
      return
    end

    # check access code
    if (Property.find(pid).access_code == params[:access_code])
      current_user.property_id = pid
    else
      flash.now[:error] = "Access Code does not match"
      render "index"
      return
    end

    # save current user
    if (current_user.save)
      redirect_to current_user.property, notice: "Joined property"
    else
      flash.now[:error] = "Could not join property"
      render "index"
      return
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :notes)
    end

    def address_params
      params.require(:address).permit(:address1, :address2, :city, :state, :zip, :country, :phone, :fax, :email)
    end
end
