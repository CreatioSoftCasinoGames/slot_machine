class Asset < ActiveRecord::Base

	belongs_to :theme, polymorphic: true
  belongs_to :machine, polymorphic: true
  belongs_to :mini_game, polymorphic: true
  belongs_to :resource, polymorphic: true

	scope :active, -> { where(active: true) }

	has_attached_file :file,
  	SlotMachine::Configuration.paperclip_options[:assets][:file]

  Paperclip.interpolates :resource_type do |attachment, style|
  	attachment.instance.resource_type.downcase.pluralize
  end

  def get_resource_version
    (self.resource.assets.where(bundle_type: bundle_type).count + 1)
  end 

  def url
  	file.url
  end

end
