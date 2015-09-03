class RecruitersController < ApplicationController
def index
 	@recruiter=Recruiter.all
 end
 
 def show
 	#@trainer = Trainer.find(params[:id])
 	@recruiter=current_recruiter
 end
end
