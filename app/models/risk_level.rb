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

  def self.to_change_string(version)
    if (version.event == "create") then
      c = RiskLevel.find(version.item_id)
      s = "New level for configuration #{c.risk_configuration.id}: <ul>" + 
        "<li>Name: <em>" + ERB::Util.html_escape(c.name) + "</em></li>" + 
        "<li>Weight: <em>#{c.weight}</em></li>" +
        "<li>Description: <em>" + ERB::Util.html_escape(c.description) + "</em></li>" +
        "<li>Color: <em>#{c.color}</em></li>" +
        "</ul>"
      s.html_safe
    else
      version.changeset_as_html
    end
  end



end
