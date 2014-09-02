class MathModel < ActiveRecord::Base

  belongs_to :machine
	has_many :pay_lines
	has_many :pay_tables
	has_many :reels, -> { order("position ASC") }
	has_many :stamps
  scope :active, -> { where(active: true) }


	# def as_json(options={})
 #    super({
 #      only: [:name],
 #      methods: [:pay_line_coordinates, :reel_series],
 #      include: {
 #        pay_tables: {
 #          only: [:count, :points],
 #          methods: [:symbol]
 #        }
 #      } 
 #    }.merge(options))
 #  end

  def pay_line_coordinates
  	pay_lines.group_by(&:label).collect do |label, lines|
  		{label.to_sym => lines.collect {|l| [l.x, l.y] }}
  	end
  end

  def reel_series
    reels.group_by(&:label).collect do |label, reels|
      {label.to_sym => reels.collect {|r| r.symbol }}
    end
  end

end
