module RisksHelper

	def jsonformat
		{:include => 
			{:item => {
					:feed => {}
				}
			}
		}
	end

end
