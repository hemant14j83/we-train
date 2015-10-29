class JavascriptsController < ApplicationController
	def dynamic_expertise		
		@category=Category.all
		@expertlists=Expertlist.all
	end
end
