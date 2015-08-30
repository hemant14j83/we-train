class ExpertisesController < ApplicationController
 def create
	@trainer=Trainer.find(current_trainer.id)
	
	@expertise = @trainer.expertises.create(params[:expertise].permit(:expertise_in, :professional_expertise_info, :reference_name, :reference_number, :reference_email, :expertise_verified_status))

	redirect_to trainer_root_path
	#redirect_to edit_trainer_registration_path
 end
 def destroy
 	@expertise = Expertise.find(params[:id])
    @expertise.destroy

    redirect_to trainer_root_path
 end

 private
 	def set_expertise
      @expertise = Expertise.find(params[:id])
 end
end
