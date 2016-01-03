class AdmpanelController < ApplicationController
	before_filter :authenticate_trainer!, only: [:index]
	before_filter do
		redirect_to "/" unless current_trainer && current_trainer.admin?
	end

	def index
		render template: "admpanel/index"
	end
end
