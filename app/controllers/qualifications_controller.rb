class QualificationsController < ApplicationController
 
 def create
	#@trainer = Trainer.find(params[:trainer.id])
	@trainer=Trainer.find(current_trainer.id)
	#@trainer = current.trainer
	
	@qualification = @trainer.qualifications.create(params[:qualification].permit(:course_name, :course_type, :course_description, :start_date, :end_date, :duration, :percentage, :grade))

	#redirect_to edit_trainer_path(@trainer)
	redirect_to edit_trainer_registration_path
 end
end
