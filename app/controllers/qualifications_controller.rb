class QualificationsController < ApplicationController
before_filter :authenticate_trainer! 
 def create
	#@trainer = Trainer.find(params[:trainer.id])
	@trainer=Trainer.find(current_trainer.id)
	#@trainer = current.trainer
	
	@qualification = @trainer.qualifications.create(params[:qualification].permit(:course_name, :course_type, :course_description, :start_date, :end_date, :duration, :percentage, :grade, :completed_from))

	redirect_to "/trainers/profile#showqual"
	#redirect_to edit_trainer_registration_path
 end
 
 def edit
  @qualification=Qualification.find(params[:id])
  @trainer=Trainer.find(current_trainer.id)
 end

 def index
  @trainer=Trainer.find(current_trainer.id)
  if @trainer.role=='admin'
    @expertise = Expertise.find_by(trainer_id: params[:current_trainer_id])
    render '404'
  end
 end

 def show
 	render '404'
 end

 def edit
 	render '404'
 end

 def update
  @trainer=Trainer.find(current_trainer.id)
  @qualification=Qualification.find(params[:id])    
  #params[:qualification][:duration]=duration.to_s
  respond_to do |format|
    if @qualification.update(params[:qualification].permit(:course_name, :course_type, :course_description, :start_date, :end_date, :duration, :percentage, :grade, :completed_from))
      format.html { redirect_to '/trainers/profile#showqual', notice: 'Qualification updated successfully.' }
      format.json { render :show, status: :ok, location: @qualification }
    else
      format.html { render :edit }
      format.json { render json: @qualification.errors, status: :unprocessable_entity }
    end
  end    
 end

 def destroy
 	@qualification = Qualification.find(params[:id])
    @qualification.destroy

    redirect_to "/trainers/profile#showqual"
 end

 private
 	def set_qualification
      @qualification = Qualification.find(params[:id])
    end

end
