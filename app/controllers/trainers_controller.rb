class TrainersController < ApplicationController
 
 def index
 	@trainer=Trainer.all
 end
 
 def show
 	#@trainer = Trainer.find(params[:id])
 	@trainer=current_trainer
 end
end
