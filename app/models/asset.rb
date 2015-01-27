class Asset < ActiveRecord::Base

  belongs_to :resource, polymorphic: true
  before_save :deactivate_others

	scope :active, -> { where(active: true) }

	has_attached_file :file,
  	SlotMachine::Configuration.paperclip_options[:assets][:file]

  Paperclip.interpolates :resource_type do |attachment, style|
  	attachment.instance.resource_type.downcase.pluralize
  end

  def siblings
    self.resource.assets.where(bundle_type: bundle_type)
  end

  def get_resource_version
    (siblings.count + 1)
  end 

  def url
  	file.url
  end

  private

  def deactivate_others
    if self.changes.include?(:active) && self.active
      (siblings - [self]).each do |a|
        a.update_attributes(active: false)
      end
    end
  end

end
