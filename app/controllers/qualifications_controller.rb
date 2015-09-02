class QualificationsController < ApplicationController
before_filter :authenticate_trainer! 
 def create
	#@trainer = Trainer.find(params[:trainer.id])
	@trainer=Trainer.find(current_trainer.id)
	#@trainer = current.trainer
	
	@qualification = @trainer.qualifications.create(params[:qualification].permit(:course_name, :course_type, :course_description, :start_date, :end_date, :duration, :percentage, :grade, :completed_from))

	redirect_to trainer_root_path
	#redirect_to edit_trainer_registration_path
 end
 def destroy
 	@qualification = Qualification.find(params[:id])
    @qualification.destroy

    redirect_to trainer_root_path
 end

 private
 	def set_qualification
      @qualification = Qualification.find(params[:id])
    end

end
