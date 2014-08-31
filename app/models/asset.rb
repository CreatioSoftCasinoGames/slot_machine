class Asset < ActiveRecord::Base

	belongs_to :game
	scope :active, -> { where(active: true) }

	has_attached_file :file,
  	SlotMachine::Configuration.paperclip_options[:assets][:file]

  def url
  	file.url
  end

end
