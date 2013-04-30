
class Risk < ActiveRecord::Base
  belongs_to :project
  belongs_to :risk_level
  belongs_to :risk_consequence
  belongs_to :risk_probability
  belongs_to :impact
  has_and_belongs_to_many :assets
  has_paper_trail :only => [:risk_consequence_id, :risk_probability_id, :impact_id, :risk_level_id, :title, :description, :mitigation]
  acts_as_taggable
  acts_as_commentable
  has_many :checklists
  has_many :attachment_links
  include RisksHelper


  def as_json(options={})
    super(:only => [:description, :mitigation, :title, :id, :risk_consequence_id], 
      :methods => [:feed, :description_html, :mitigation_html, :tag_list])
  end

  
  def description_html
    markdown_to_html(description)
  end
  def mitigation_html
    markdown_to_html(mitigation)
  end

  def accepted
	 risk_level.weight <= impact.risk_level.weight || accepted_override
  end



  def feed
    comments_feed = root_comments.select{|c| !c.deleted }.map { |c| 
                {:user => c.user, :description => c.body_html, :created_at => c.created_at, :type => "comment", :id => c.id }
              }
    changes_feed = versions.select { |v| 
                v.changeset != NIL && v.changeset.empty? == false
              }.map { |v| 
                {:user => to_user(v), :description => markdown_to_html(to_action(v)), :created_at => v.created_at, :type => "change" }
              }
    attachments_feed = attachment_links.map { |l| 
                {:user => l.user, :description => "Attachment uploaded: \"<a href=\"" + l.attachment.file.url() + "\">" + 
                  l.attachment.file_file_name + "\"" +
                  "<img src=\"" + l.attachment.file.url(:thumb) + "\"></a>", :created_at => l.created_at, :type => "attachment" }
              }
    (comments_feed | changes_feed | attachments_feed).sort_by{ |f1| f1[:created_at] }.reverse
  end

  def to_user(version)
    User.find(version.whodunnit || version.originator)
  end
  
  def to_action(version)
    result = []
    version.changeset.keys.each{|k| 
      changeset = version.changeset[k];
      s = "Changed "
      begin 
        if (k == "risk_level_id") then        
          s += " risk level from \"" + RiskLevel.find(changeset[0]).name + "\" to \"" +RiskLevel.find(changeset[1]).name + "\". "
        elsif (k == "risk_probability_id") then
          s += " risk probability from \"" + RiskProbability.find(changeset[0]).name + "\" to \"" + RiskProbability.find(changeset[1]).name + "\". "
        elsif (k == "risk_consequence_id") then
          s += " risk consequence from \"" + RiskConsequence.find(changeset[0]).name + "\" to \"" + RiskConsequence.find(changeset[1]).name + "\". "
        elsif (k == "impact_id" || k == "category_id") then
          s += " impact from \"" + Impact.find(changeset[0]).name + "\" to \"" + Impact.find(changeset[1]).name + "\". "
        else
          s += k + ". "
        end
      rescue
        
      end
      result.push(s)
    }
    if (result.size > 1) then
      "* " + result.join("\n* ")
    else
      result[0]
    end
  end


end
