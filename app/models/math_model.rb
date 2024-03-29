class MathModel < ActiveRecord::Base

  belongs_to :machine
	has_many :pay_lines
	has_many :pay_tables
	has_many :reels
  has_many :stamps
  before_save :deactivate_others

  private 

    def deactivate_others
      if self.changes.include?(:active) && self.active
        (self.machine.math_models - [self]).each do |mm|
          mm.update_attributes(active: false)
        end
      end
    end

end
