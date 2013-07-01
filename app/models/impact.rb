class Impact < ActiveRecord::Base
  belongs_to :risk_level
  belongs_to :risk_configuration
  has_paper_trail



  def self.to_change_string(version)
    if (version.event == "create") then
      c = Impact.find(version.item_id)
      s = "New impact for configuration #{c.risk_configuration.id}: <ul>" + 
        "<li>Name: <em>" + ERB::Util.html_escape(c.name) + "</em></li>" + 
        "<li>Acceptance level: <em>#{c.risk_level.name}</em></li>" +
        "<li>Hidden: <em>#{c.hidden}</em></li>" +
        "</ul>"
      s.html_safe
    else
      version.changeset_as_html
    end
  end

end
