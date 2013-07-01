class Version
	def as_string
		t = Kernel.const_get(item_type)
		if defined? t.to_change_string
			t.to_change_string(self)
		else
			changeset.to_json
		end
	end
end