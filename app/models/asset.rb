class Asset < ActiveRecord::Base

	belongs_to :game
	scope :active, -> { where(active: true) }

	has_attached_file :file,
  	SlotMachine::Configuration.paperclip_options[:assets][:file]

  def url
  	file.url
  end

  def as_json(options={})
    super({
      only: [:label, :version, :is_permanent, :file_file_size, :file_updated_at, :country, :bundle_type],
			methods: [:url]
    }.merge(options))
  end

end
