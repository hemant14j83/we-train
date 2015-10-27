class ExpertlistsController < ApplicationController
before_filter :authenticate_trainer!
 def index
  @el = Expertlist.all
  @trainer=trainer.find(current_trainer.id)
 end

 def create
 	@category=Category.find(params[:category_id])
 	@el=@category.expertlist.create(el_params)
 	redirect_to category_path(@category)
 end
 private
  def set_function
     @el = Expertlist.find(params[:id])
  end
  def el_params
      params.require(:expertlist).permit(:name)
  end
end
