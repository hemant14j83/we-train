class RegistrationsController < Devise::RegistrationsController
  def new
    super    
 end 
 
 def create
    build_resource(sign_up_params)

    if resource.save
        yield resource if block_given?
        if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
            respond_with resource, location: '/trainers/sign_in'
        else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            respond_with resource, location: '/trainers/sign_up'
        end
    else
        clean_up_passwords resource
        resource.errors.full_messages.each {|x| flash[x] = x} # Rails 4 simple way
        redirect_to new_trainer_registration_path 
    end
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

end
