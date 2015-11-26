class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  before_filter :configure_r_permitted_parameters, if: :devise_controller?

  def after_inactive_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Trainer)
      new_trainer_session_path
    elsif resource_or_scope.is_a?(Recruiter)
      new_recruiter_session_path
    else
      super
    end
  end
  #def after_inactive_sign_in_path_for(resource_or_scope)
  #  if resource_or_scope.is_a?(Trainer)
  #    new_trainer_session_path
  #  elsif resource_or_scope.is_a?(Recruiter)
  #    new_recruiter_session_path
  #  else
  #    super
  #  end
  #end

  def stored_location_for(resource)
  	if current_trainer
  		if (current_trainer.full_name.blank? || current_trainer.primary_number.blank? || current_trainer.city.blank? || current_trainer.state.blank?)
  			set_flash_message :notice, :incomplete#"Either of these is missing : Full Name, Primary Number, City or State."
  			return edit_trainer_registration_path #'/trainers/'+current_trainer.id.to_s+'/edit'
  		end	
  	end
  	super(resource)
  end

  protected
    def configure_r_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |t|
      t.permit(:firm_name,:email, :password, :password_confirmation, :current_password, :firm_type, :firm_number, :firm_address, :address,:city,:state, :country, :pincode, :account_status,:subscribed_plan, :contact_person_name, :contact_person_email, :contact_person_number,:full_name,:email, :password, :password_confirmation, :current_password, :primary_number, :birth_date,:gender,:address,:city,:state, :country, :profile_status,:subscribed_plan, :busy_from, :busy_till, :image, :last_name)      
    end

    devise_parameter_sanitizer.for(:sign_up) do |t|
      t.permit(:email, :password, :password_confirmation,:full_name,:last_name,:firm_type,:firm_name)
    end
    devise_parameter_sanitizer.for(:sign_in) do |t|
      t.permit(:email, :password)
    end
  end
    
  

  private
    def record_not_found
      render 'shared/404'
    end    
end
