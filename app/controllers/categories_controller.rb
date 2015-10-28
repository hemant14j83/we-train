class CategoriesController < ApplicationController
	before_filter :authenticate_trainer!
	before_filter do
		redirect_to "/" unless current_trainer && current_trainer.admin?
	end
	before_filter :set_category, only: [:show, :edit, :update, :destroy]
	def index
		@category = Category.all
	end
	
	def show
	end

	def new
		@category = Category.new
		20.times{@category.expertlist.build}
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success]= "New Category #{@category.name} added successfully."
			redirect_to "/categories/new"
		else
			flash[:error]= @category.errors.full_messages.to_sentence
			redirect_to "/categories/new"
		end
		
	end

	def edit
	end
	
	def update
		if @category.update(category_params)
			flash[:success]= "Category updated to #{@category.name} successfully."
			redirect_to "/categories"	
		else
			flash[:error]= @category.errors.full_messages.to_sentence
			redirect_to "/categories"
		end
	end

	def destroy
		@category.destroy
	    respond_to do |format|
	      format.html { redirect_to '/categories', notice: "#{@category.name} removed successfully."  }
	      format.json { head :no_content }
	  	end
	end

	private
		def set_category
			@category=Category.find(params[:id])
		end

		def category_params
			params.require(:category).permit(:name)
		end
		def admin?
  			self.admin == true
		end
end