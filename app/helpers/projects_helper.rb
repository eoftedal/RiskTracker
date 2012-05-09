module ProjectsHelper

    def total_risk
		risk_versions.each_with_index.map{|r, i| "[" + i.to_s + "," + r.count().to_s + "]"}.reduce{|i,j| i + ", " + j}
	end
    def accepted_risk
		risk_versions.each_with_index.map{|r, i| "[" + i.to_s + "," + r.map{|a| a[:accepted] }.count{|a| a}.to_s + "]"}.reduce{|i,j| i + ", " + j}	
	end

	def x_ticks
		days = @project.days_since_creation 
		risk_versions.each_with_index.map{|r, i|
			d = (Date.today - (days - i))
			if (d == d.beginning_of_week) then
				"{v:" + i.to_s + ", label:'" + d.strftime("%d.%m") + "'}"
			else
				""
			end
		}.reject{|d| d == ""}.reduce{|i,j| i + ", " + j }
	end
	
	def risk_versions
		days = @project.days_since_creation 
		@risks_at_date = Rails.cache.fetch("risks_at_" + days.to_s()) do 
			risk_at_dates(days)
		end
		@risks_at_date.push @project.risks.map{|r| { :accepted => r.accepted }}
		@risks_at_date
	end
	def risk_at_dates(days)
			risk_at_date = []
			days.times do |i| 
				risk_at_date.push @project.risks_at(Date.today - (days - i) + 1).select{|rr| rr != NIL}.map{|r| { :accepted => r.accepted }}
			end
			risk_at_date
	end

end
