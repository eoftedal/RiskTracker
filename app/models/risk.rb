
class Risk < ActiveRecord::Base
  belongs_to :project
  belongs_to :risk_level
  belongs_to :risk_consequence
  belongs_to :risk_probability
  belongs_to :impact
  has_paper_trail :only => [:risk_consequence_id, :risk_probability_id, :impact_id, :risk_level_id, :title, :description]
  acts_as_taggable
  acts_as_commentable
  has_many :checklists
  include RisksHelper
	
  def accepted
	 risk_level.weight <= impact.risk_level.weight || accepted_override
  end

  def feed
    comments_feed = root_comments.map { |c| 
                {:user => c.user, :description => c.body_html, :created_at => c.created_at, :type => "comment" }
              }
    changes_feed = versions.select { |v| 
                v.changeset != NIL && v.changeset.empty? == false
              }.map { |v| 
                {:user => to_user(v), :description => markdown_to_html(to_action(v)), :created_at => v.created_at, :type => "change" }
              }
    (comments_feed | changes_feed).sort_by{ |f1| f1[:created_at] }.reverse
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
  def description_html
    markdown_to_html(description)
  end



  def as_json(options={})
    super(:only => [:description, :title, :id, :risk_consequence_id], :methods => [:feed, :description_html, :tag_list])
  end

end
