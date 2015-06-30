class Api::V1::ClientBugsController < Api::V1::ApplicationController

	def create
		bug_type  = "BINGO - " + params[:bug_type]
	  @client_bug = ClientBug.new(exception: params[:exception], bug_type: bug_type, test_mode: params[:test_mode])
		if @client_bug.save
			render json: {
				success: true
			}
		else
			render json: {
				success: false,
				errors: @client_bug.errors.full_messages.join(", ")
			}
		end
	end
	
end