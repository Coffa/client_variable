module ClientVariable
	class Global < Variable
		class << self
			def values
				@datum ||= {}
			end

			def clear
				@datum = {}
			end

			def get_variable(name)
				values[name]
			end

			def set_variable(name, value)
				values[name] = value
			end
		end
	end
end
