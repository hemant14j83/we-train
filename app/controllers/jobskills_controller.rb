class JobskillsController < ApplicationController
before_filter :authenticate_trainer!  
 def index
  @js = Jobskill.all
  @career=Career.find(current_trainer.id)
 end

 def create
 	@career=Career.find(params[:career_id])
 	@js=@career.jobskills.create(js_params)
 	redirect_to career_path(@career)
 end
 private
  def set_function
     @js = Jobskill.find(params[:id])
  end
  def js_params
      params.require(:jobskill).permit(:skill)
  end
end
