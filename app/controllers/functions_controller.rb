class FunctionsController < ApplicationController
 before_filter :authenticate_trainer!  
 def index
  @function = Function.all
  @career=Career.find(current_trainer.id)
 end

 def create
 	@career=Career.find(params[:career_id])
 	@functions=@career.functions.create(function_params)
 	redirect_to career_path(@career)
 end
 private
  def set_function
     @expertise = Expertise.find(params[:id])
  end
  def function_params
      params.require(:function).permit(:responsibility)
  end
end
