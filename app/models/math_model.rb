class MathModel < ActiveRecord::Base

  belongs_to :machine
	has_many :pay_lines
	has_many :pay_tables
	has_many :reels
  has_many :stamps
	has_many :symbols, class_name: "Stamp"
  scope :active, -> { where(active: true) }

  before_save :deactivate_others

  def pay_line_coordinates
  	pay_lines.group_by(&:label).collect do |label, lines|
  		{label.to_sym => lines.collect {|l| [l.x, l.y] }}
  	end
  end

  def reel_series
    reels.group_by(&:label).collect do |label, reels|
      {label.to_sym => reels.collect {|r| {symbol: r.symbol, size: r.size} }}
    end
  end

  private 

    def deactivate_others
      if self.changes.include?(:active) && self.active
        (self.machine.math_models - [self]).each do |mm|
          mm.update_attributes(active: false)
        end
      end
    end

end
