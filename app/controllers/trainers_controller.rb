class TrainersController < ApplicationController
 
 def show
 	#@trainer = Trainer.find(params[:id])
 	@trainer=current_trainer
 end
end
