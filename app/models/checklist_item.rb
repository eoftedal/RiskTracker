class ChecklistItem < ActiveRecord::Base
  	belongs_to :checklist
	has_paper_trail :only => [:done]

  def self.to_change_string(version)
    if (version.event == "create") then
      c = ChecklistItem.find(version.item_id)
      s = "New checklist item for checklist <em>\"" + ERB::Util.html_escape(c.checklist.title) + "\"</em> on Risk #{c.checklist.risk.risk_id}: <br><em>" + ERB::Util.html_escape(c.title) + "</em>"
      s.html_safe
    else
      result = []
      version.changeset.keys.each{|k| 
      	puts "JUBIII " + k
      	c = version.changeset[k]
      	puts version.changeset[k]
      	result.push k + ": " + (c[0] || "null").to_s + " -> " + c[1].to_s 
      }
      result
    end
  end	
end
