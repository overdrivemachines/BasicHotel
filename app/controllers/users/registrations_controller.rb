class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html
  # http://www.peoplecancode.com/tutorials/adding-custom-fields-to-devise

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # PATCH /users/dissociate_property
  def dissociate_property
    user = User.where(id: user_params[:id].to_i)
    
    if (user == nil)
      flash[:alert] = "User does not exist"
      if (current_user.property_id != nil)
        redirect_to current_user.property
      else
        redirect_to root_url
      end
      return
    end
    user = user[0]
    user.property_id = nil
    if user.save
      flash[:notice] = "Removed user"
    else
      flash[:alert] = "Could not dissociate property"
    end
    if (current_user.property_id != nil)
      redirect_to current_user.property
    else
      redirect_to root_url
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    added_attrs = [:firstname, :lastname]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    added_attrs = [:firstname, :lastname]
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def user_params
    params.require(:user).permit(:id)
  end
end
