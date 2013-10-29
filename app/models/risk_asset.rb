class RiskAsset < ActiveRecord::Base
  belongs_to :risk_asset_value
  belongs_to :project
  has_and_belongs_to_many :risks
  attr_accessible :description, :name, :risk_asset_value_id, :owner
  has_paper_trail

  def self.to_change_string(version)
    if (version.event == "create") then
      c = RiskAsset.find(version.item_id)
      s = "New risk asset for project #{c.project.id}: <ul>" + 
        "<li>Name: <em>" + ERB::Util.html_escape(c.name) + "</em></li>" + 
      	"<li>Value: <em>" + ERB::Util.html_escape(c.risk_asset_value.name) + "</em></li>" +
      	"<li>Description: <em>" + ERB::Util.html_escape(c.description) + "</em></li>" +
      	"</ul>"
      s.html_safe
    else
      version.changeset_as_html
    end
  end

end
