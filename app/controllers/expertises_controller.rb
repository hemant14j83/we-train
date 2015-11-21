class ExpertisesController < ApplicationController
 before_filter :authenticate_trainer!
 def create
	@trainer=Trainer.find(current_trainer.id)
	
	@expertise = @trainer.expertises.create(params[:expertise].permit(:expertise_in, :professional_expertise_info, :reference_name, :reference_number, :reference_email, :expertise_verified_status,:reference_name1, :reference_number1, :reference_email1,))
  if @expertise.save
    flash[:notice]='Expertise Added Successfully.'
    redirect_to '/trainers/profile#showexpert'
  else
    flash[:notice]='Something Went wrong, All fields are mandatory.'
	  redirect_to '/trainers/profile#showexpert'
  end
	#redirect_to edit_trainer_registration_path
 end

 def index 	
  @trainer=Trainer.find(current_trainer.id)
  if @trainer.role=='admin'
    @expertise = Expertise.all
  elsif @trainer.role=='trainer'
    @expertise = Expertise.find_by(trainer_id: params[:current_trainer_id])
    render 'trainerindex'
  end
 end

 def edit
  @expertise=Expertise.find(params[:id])
  @trainer=Trainer.find(current_trainer.id)
 end

 def update
  @trainer=Trainer.find(current_trainer.id)
  @expertise=Expertise.find(params[:id])
    if @expertise.expertise_verified_status=='UnVerified'
      respond_to do |format|
        if @expertise.update(params[:expertise].permit(:professional_expertise_info, :reference_name, :reference_number, :reference_email, :expertise_verified_status,:reference_name1, :reference_number1, :reference_email1))
          format.html { redirect_to '/trainers/profile#showexpert', notice: 'Details updated successfully.' }
          format.json { render :show, status: :ok, location: @expertise }
        else
          format.html { render :edit }
          format.json { render json: @expertise.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice]='Updating verified expertise is not allowed.'
    end
 end

 def approved

 end

 def destroy
 	@expertise = Expertise.find(params[:id])
    @expertise.destroy
    redirect_to '/trainers/profile#showexpert'
 end

 private
  def set_expertise
     @expertise = Expertise.find(params[:id])
  end
  def expertise_params
      params.require(:expertise).permit(:expertise_in, :professional_expertise_info, :reference_name, :reference_number, :reference_email, :expertise_verified_status,:comments)
  end
end
