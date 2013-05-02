module RiskConfigurationsHelper
    def find_level(config, probability, consequence)
        sum = probability.weight * consequence.weight
        level = config.risk_levels.select{ |l| l.weight >= sum }.sort_by{|l| l.weight }.first
        level || config.risk_levels.sort_by{|l| l.weight }.last
    end

end
