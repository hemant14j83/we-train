class ExpertisesController < ApplicationController
 before_filter :authenticate_trainer!
 def create
	@trainer=Trainer.find(current_trainer.id)
	
	@expertise = @trainer.expertises.create(params[:expertise].permit(:expertise_in, :professional_expertise_info, :reference_name, :reference_number, :reference_email, :expertise_verified_status,:reference_name1, :reference_number1, :reference_email1,))
  if @expertise.save
    flash[:notice]='Expertise Added Successfully.'
    redirect_to trainer_root_path
  else
    flash[:notice]='Something Went wrong, All fields are mandatory.'
	  redirect_to trainer_root_path
  end
	#redirect_to edit_trainer_registration_path
 end

 def index
 	@expertise = Expertise.all
  @trainer=Trainer.find(current_trainer.id)
 end

 def edit
  @expertise=Expertise.find(params[:id])
 end

 def update
  @expertise=Expertise.find(params[:id])
    respond_to do |format|
      if @expertise.update(expertise_params)
        format.html { redirect_to expertise_list_path, notice: 'Details updated successfully.' }
        format.json { render :show, status: :ok, location: @expertise }
      else
        format.html { render :edit }
        format.json { render json: @expertise.errors, status: :unprocessable_entity }
      end
    end
 end

 def approved

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
  def expertise_params
      params.require(:expertise).permit(:expertise_in, :professional_expertise_info, :reference_name, :reference_number, :reference_email, :expertise_verified_status,:comments)
  end
end
