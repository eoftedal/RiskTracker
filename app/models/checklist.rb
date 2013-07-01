class Checklist < ActiveRecord::Base
  	belongs_to :risk
	has_paper_trail
	has_many :checklist_items



  def self.to_change_string(version)
    if (version.event == "create") then
      c = Checklist.find(version.item_id)
      s = "New checklist for Risk #{c.risk.risk_id}: <em>" + ERB::Util.html_escape(c.title) + "</em>"
      s.html_safe
    else
      result = []
      version.changeset.keys.each{|k| 
      	changeset = version.changeset[k]
      	result.push k + ":" + changeset[0] + " -> " + changeset[1] 
      }
      if (result.size > 1) then
        "* " + result.join("\n* ")
      else
        result[0]
      end
    end
  end

end
