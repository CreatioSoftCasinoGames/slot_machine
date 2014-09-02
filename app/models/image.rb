class Image < ActiveRecord::Base

	has_attached_file :file,
  	SlotMachine::Configuration.paperclip_options[:images][:file]

  Paperclip.interpolates :resource_type do |attachment, style|
  	attachment.instance.resource_type.downcase.pluralize
  end

  

  def url
  	file.url
  end

end