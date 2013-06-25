class Version
	def as_string
		t = Kernel.const_get(item_type)
		if defined? t.as_string
			t.as_string(self)
		else
			changeset.to_json
		end
	end
end