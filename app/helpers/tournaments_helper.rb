module TournamentsHelper
	
	def machine_name
		Machine.all.collect{ |machine| [machine.name, machine.id] }
	end

end
