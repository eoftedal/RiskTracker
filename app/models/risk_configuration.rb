class RiskConfiguration < ActiveRecord::Base
	has_many :risk_levels
	has_many :risk_probabilities
	has_many :risk_consequences
	has_many :impacts
    has_many :risk_asset_values
	has_paper_trail

	def visible_impacts
		impacts.where("hidden IS NOT ?", true)
	end

    def find_level(probability, consequence)
        sum = probability.weight * consequence.weight
        level = risk_levels.select{ |l| l.weight >= sum }.sort_by{|l| l.weight }.first
        level || risk_levels.sort_by{|l| l.weight }.last
    end

end
