class RegistrationsController < Devise::RegistrationsController
  def new
    super    
 end 
 
 def create
    super
 end 
 
 def update
    redirect_to trainer(@trainer)

 end
 def edit
    super
    #redirect_to @trainer
    #redirect_to trainer_path, notice: 'Profile Updated Successfully'
 end 
 
 def cancel
    super
 end 

 def destroy
    super
 end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
