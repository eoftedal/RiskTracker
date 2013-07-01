class Version
	def as_string
		t = Kernel.const_get(item_type)
		if defined? t.to_change_string
			t.to_change_string(self)
		else
			changeset.to_json
		end
	end

	def changeset_as_html
	  result = []
      changeset.keys.each{|k| 
      	result.push escape_html(k) + ": <em>" + escape_html(changeset[k][0] || "null") + "</em> &rarr; <em>" + escape_html(changeset[k][1].to_s) + "</em>"
      }
      if (result.size > 1) then
        BlueCloth.new("* " + result.join("\n* ")).to_html.html_safe
      else
        BlueCloth.new(result[0]).to_html.html_safe
      end
	end

	def escape_html(val)
		ERB::Util.html_escape(val.to_s).gsub("_", "\\_")
	end
end