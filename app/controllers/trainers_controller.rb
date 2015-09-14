class TrainersController < ApplicationController
before_filter :authenticate_trainer!  
 def index
 	@trainer=Trainer.all
 end
 
 def show
 	#@trainer = Trainer.find(params[:id])
 	@trainer=current_trainer
 end
end
