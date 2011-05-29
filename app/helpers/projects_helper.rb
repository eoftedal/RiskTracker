module ProjectsHelper

    def total_risk
		risk_versions.each_with_index.map{|r, i| "[" + i.to_s + "," + r.count().to_s + "]"}.reduce{|i,j| i + ", " + j}
	end
    def accepted_risk
		risk_versions.each_with_index.map{|r, i| "[" + i.to_s + "," + r.map{|a| a.accepted }.count{|a| a}.to_s + "]"}.reduce{|i,j| i + ", " + j}	
	end
	
	def risk_versions 
		days = @project.days_since_creation 
		risk_at_date = []
		days.times do |i| 
			risk_at_date.push @project.risks_at(Date.today - (days - i)).select{|rr| rr != NIL}
		end
		risk_at_date.push @project.risks	
	end
end
