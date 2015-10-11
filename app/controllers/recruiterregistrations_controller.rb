class RecruiterregistrationsController < Devise::RegistrationsController
layout 'recruiters'
  def new
    super    
 end 
 
 def create
    super
 end 
 
 def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @recruiter=Recruiter.find(current_recruiter.id)

    if needs_password?
      successfully_updated = @recruiter.update_with_password(account_update_params)
    else
      account_update_params.delete('password')
      account_update_params.delete('confirmation_password')
      account_update_params.delete('current_password')
      successfully_updated=@recruiter.update_attributes(account_update_params)
    end

    if successfully_updated?
      set_flash_message :notice, :updated

      sign_in @recruiter, :bypass=>true
      redirect_to trainer_root_path
      #redirect_to edit_trainer_registration_path
    else
      render "edit"
    end

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
