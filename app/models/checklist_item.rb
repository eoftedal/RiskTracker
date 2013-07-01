class ChecklistItem < ActiveRecord::Base
  	belongs_to :checklist
	has_paper_trail :only => [:done]

  def self.to_change_string(version)
    if (version.event == "create") then
      c = ChecklistItem.find(version.item_id)
      s = "New checklist item for checklist <em>" + ERB::Util.html_escape(c.checklist.title) + "</em> on Risk #{c.checklist.risk.risk_id}: <em>" + ERB::Util.html_escape(c.title) + "</em>"
      s.html_safe
    else
      version.changeset_as_html
    end
  end	
end
