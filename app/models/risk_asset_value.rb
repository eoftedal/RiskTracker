class RiskAssetValue < ActiveRecord::Base
  belongs_to :risk_configuration
  attr_accessible :name, :weight, :description
  has_paper_trail

  def self.to_change_string(version)
    if (version.event == "create") then
      c = RiskAssetValue.find(version.item_id)
      s = "New risk asset value for configuration #{c.risk_configuration.id}: <ul>" + 
        "<li>Name: <em>" + ERB::Util.html_escape(c.name) + "</em></li>" + 
      	"<li>Weight: <em>#{c.weight}</em></li>" +
      	"<li>Description: <em>" + ERB::Util.html_escape(c.description) + "</em></li>" +
      	"</ul>"
      s.html_safe
    else
      version.changeset_as_html
    end
  end
end
