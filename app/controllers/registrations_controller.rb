class RegistrationsController < Devise::RegistrationsController
  def new
    super    
 end 
 
 def create
    
 end 
 
 def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @trainer=Trainer.find(current_trainer.id)

    if needs_password?
      if @trainer.update_with_password(account_update_params)
        set_flash_message :notice, :updated
        sign_in @trainer, :bypass=>true
        redirect_to trainer_root_path
      else
        set_flash_message :notice, :password_missing
        redirect_to edit_trainer_registration_path
      end
    else
      account_update_params.delete('password')
      account_update_params.delete('confirmation_password')
      account_update_params.delete('current_password')
      successfully_updated=@trainer.update_attributes(account_update_params)
      if @trainer.update_with_password(account_update_params)
        set_flash_message :notice, :updated
        sign_in @trainer, :bypass=>true
        redirect_to trainer_root_path
      else
        set_flash_message :notice, :password_missing
        redirect_to edit_trainer_registration_path
      end
    end

    #if successfully_updated?
    #  set_flash_message :notice, :updated

      #sign_in @trainer, :bypass=>true
      #redirect_to trainer_root_path
      #redirect_to edit_trainer_registration_path
    #else
    #  render "edit"
    #end

 end

 def edit
   super  
 end 
 
 def cancel
    super
 end 

 def destroy
    super
 end

  private
  def needs_password?
    @trainer.email != params[:trainer][:email] || params[:trainer][:password].present?
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  #def after_inactive_sign_up_path_for(resource)
  #  redirect_to new_trainer_registration_path
  #end

end
