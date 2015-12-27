class TrainersController < ApplicationController
before_filter :authenticate_trainer!  
 def index
 	@trainer=Trainer.all
 end
 
 def show
 	#@trainer = Trainer.find(params[:id])
 	@trainer=current_trainer
 end
 def approve
    @trainer=Trainer.find(params[:id])
    
    if @trainer.update_attributes(:profile_status=>'approved')
    	flash[:notice]='Trainer approved'
    	#sign_in @trainer, :bypass=>true
    	redirect_to trainers_path
    else
    	flash[:notice]= "Something went wrong. Contact Your Developer"
    	redirect_to trainers_path
    end
 end

 def reject
    @trainer=Trainer.find(params[:id])
    
    if @trainer.update_attributes(:profile_status=>'pending')
    	flash[:notice]='Rejected Record'
    	#sign_in @trainer, :bypass=>true
    	redirect_to trainers_path
    else
    	flash[:notice]= "Something went wrong. Contact Your Developer"
    	redirect_to trainers_path
    end
 end

 private
  def approve_params
      params.require(:trainer).permit(:profile_status)
  end
end
