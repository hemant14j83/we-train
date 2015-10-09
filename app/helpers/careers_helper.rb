module CareersHelper
	def setupcareer(career)
		career.function ||= Function.new
		career
	end
end
