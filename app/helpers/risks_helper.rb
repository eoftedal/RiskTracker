require 'bluecloth'
module RisksHelper

	def markdown_to_html(markdown)
		BlueCloth.new(markdown, { :escape_html => true }).to_html
	end

end
