class Risk < ActiveRecord::Base
  belongs_to :project
  belongs_to :risk_level
  belongs_to :risk_consequence
  belongs_to :risk_probability
  belongs_to :category
  has_paper_trail :only => [:risk_consequence_id, :risk_probability_id, :category_id, :risk_level_id]
  acts_as_taggable
  acts_as_commentable
	
  def accepted
	 risk_level.weight <= category.risk_level.weight || accepted_override
  end

  def feed
    comments_feed = root_comments.map { |c| 
                {:user => c.user, :description => ["\"" + c.body + "\""], :created_at => c.created_at, :type => "comment" }
              }
    changes_feed = versions.select { |v| 
                v.changeset != NIL && v.changeset.empty? == false
              }.map { |v| 
                {:user => to_user(v), :description => to_action(v), :created_at => v.created_at, :type => "change" }
              }
    (comments_feed | changes_feed).sort_by{ |f1| f1[:created_at] }.reverse
  end

  def to_user(version)
    User.find(version.originator || version.whodunnit)
  end
  
  def to_action(version) 
    result = []
    version.changeset.keys.each{|k| 
      s = "Changed "
      if (k == "risk_level_id") then
        s += " risk level from \"" + RiskLevel.find(version.changeset[k][0]).name + "\" to \"" +RiskLevel.find(version.changeset[k][1]).name + "\". "
      elsif (k == "risk_probability_id") then
        s += " risk probability from \"" + RiskProbability.find(version.changeset[k][0]).name + "\" to \"" + RiskProbability.find(version.changeset[k][1]).name + "\". "
      elsif (k == "risk_consequence_id") then
        s += " risk consequence from \"" + RiskConsequence.find(version.changeset[k][0]).name + "\" to \"" + RiskConsequence.find(version.changeset[k][1]).name + "\". "
      elsif (k == "category_id") then
        s += " category from \"" + Category.find(version.changeset[k][0]).name + "\" to \"" + Category.find(version.changeset[k][1]).name + "\". "
      else
        s += k + ". "
      end
      result.push(s)
    }
    result
  end

end
