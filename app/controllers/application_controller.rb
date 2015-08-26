class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

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
    def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |t|
      t.permit(:full_name,:email, :password, :password_confirmation, :current_password, :primary_number, :birth_date,:gender,:address,:city,:state, :country, :profile_status,:subscribed_plan, :busy_from, :busy_till)
    end

    devise_parameter_sanitizer.for(:sign_up) do |t|
      t.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:sign_in) do |t|
      t.permit(:email, :password)
    end
  end
end
