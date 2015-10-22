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
      if @recruiter.update_with_password(account_update_params)
        set_flash_message :notice, :updated
        sign_in @recruiter, :bypass=>true
        redirect_to recruiter_root_path
      else
        set_flash_message :notice, :password_missing
        redirect_to edit_recruiter_registration_path
      end
    else
      account_update_params.delete('password')
      account_update_params.delete('confirmation_password')
      account_update_params.delete('current_password')
      successfully_updated=@recruiter.update_attributes(account_update_params)
      if @recruiter.update_with_password(account_update_params)
        set_flash_message :notice, :updated
        sign_in @recruiter, :bypass=>true
        redirect_to recruiter_root_path
      else
        set_flash_message :notice, :password_missing
        redirect_to edit_recruiter_registration_path
      end
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
    @recruiter.email != params[:recruiter][:email] || params[:recruiter][:password].present?
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_inactive_sign_up_path_for(resource)
    redirect_to new_recruiter_registration_path
  end
end
