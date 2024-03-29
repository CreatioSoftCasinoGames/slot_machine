class ClientBugsController < ApplicationController

	def index
		@client_bugs = ClientBug.paginate(:page => params[:page], :per_page => 30).order("created_at desc")
	end

	def destroy
		@client_bug = ClientBug.find(params[:id])
		@client_bug.destroy
		respond_to do |format|
	      format.html { redirect_to client_bugs_url, notice: 'Bug successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end

	def show
		@client_bug = ClientBug.find(params[:id])
	end

end