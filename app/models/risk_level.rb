class RiskLevel < ActiveRecord::Base
  belongs_to :risk_configuration
  has_paper_trail
  validates_inclusion_of :color, :in => [:blank, :ok, :warning, :fail, :other]

  def color
     read_attribute(:color) ? read_attribute(:color).to_sym : :blank
  end

  def color= (value)
    write_attribute(:color, value.to_s)
  end
  

  def above
  	risk_configuration.risk_levels.select{|r| r.weight > weight}.sort_by{|r| r.weight }[0]
  end
end
