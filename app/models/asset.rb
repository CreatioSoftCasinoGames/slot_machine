class Asset < ActiveRecord::Base

	belongs_to :game

	has_attached_file :file,
  	SlotMachine::Configuration.paperclip_options[:assets][:file]

  Paperclip.interpolates :resource_type do |attachment, style|
  	attachment.instance.resource_type.downcase.pluralize
  end

  def url
  	file.url
  end

end
