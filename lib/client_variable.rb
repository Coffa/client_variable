require "client_variable/version"

module Client
	class Variable
		class << self
			def global
				Global
			end

			def get_variable(name)
				Request.values[name]
			end

			def set_variable(name, value)
				Request.values[name] = value
			end

			def values
				Request.values
			end

			def clear
				Request.clear
			end

			def method_missing(method, *args, &block)
				if ( method.to_s =~ /=$/ )
					if public_methods? method
						raise "You can't use Gon public methods for storing data"
					end
					set_variable(method.to_s.delete('='), args[0])
				else
					get_variable(method.to_s)
				end
			end
		end
	end

	def self.generate
		data = YAML.load(ERB.new(File.new("#{Rails.root}/config/client_variable.yml").read).result)[Rails.env]
		data.merge([Global.values, Request.values].inject(:merge)).to_json
	end

	class Engine < ::Rails::Engine; end

	require 'client_variable/request'
	require 'client_variable/global'
	require 'client_variable/helper/view'
	require 'client_variable/helper/controller'
end
