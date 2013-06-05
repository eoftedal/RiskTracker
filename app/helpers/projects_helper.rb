module ProjectsHelper

    def total_risk(versions)
		versions.each_with_index.map{|r, i| [ i, r.total ] }
	end
    
    def accepted_risk(versions)
		versions.each_with_index.map{|r, i| [ i, r.accepted ]}
	end

	def month_ticks(versions)
		days = @project.days_since_creation 
		versions.each_with_index.map{|r, i|
			d = (Date.today - (days - i))
			if (d == (d.beginning_of_month + 15)) then
				{ :v => i, :label => d.strftime("%b") }
			else
				{}
			end
		}.reject{|d| d == {}}
	end
	def week_ticks(versions)
		days = @project.days_since_creation 
		versions.each_with_index.map{|r, i|
			d = (Date.today - (days - i))
			if (d == d.beginning_of_week) then
				{ :v => i, :label => d.strftime("%d.%m") }
			else
				{}
			end
		}.reject{|d| d == {}}
	end
	
	def risk_versions
		days = @project.days_since_creation 
		risk = risk_at_dates(days)
		current_risks = @project.risks.map{|r| { :accepted => r.accepted }}
		risk.push RiskAtDay.new({ 
			:date => Date.today, 
			:total => current_risks.count(), 
			:accepted => current_risks.map{|a| a[:accepted] }.count{|a| a } 
			})
		risk
	end

	def risk_at_dates(days)
		risk_at_date = RiskAtDay.where({:project_id => @project.id})
		days.times do |i| 
			date = Date.today - (days - i) + 1 
			if (!risk_at_date.any? { |r| r.date == date })
				ra = @project.risks_at(Date.today - (days - i) + 1).select{|rr| rr != NIL}.map{|r| { :accepted => r.accepted }}
				risks = RiskAtDay.new({ 
					:date => date, 
					:total => ra.count(), 
					:accepted => ra.map{|a| a[:accepted] }.count{|a| a },
					:project_id => @project.id
				})		
				risks.save
				risk_at_date.push risks
			end
		end
		risk_at_date
	end

end
