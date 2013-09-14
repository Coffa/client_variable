require 'sprockets/engines'
require 'tilt/template'

module Client
	class Engine < Rails::Engine
		initializer "sprockets.mquy", :after => "sprockets.environment", :group => :all do |app|
			app.assets.register_engine('.mquy', TiltHandlebars)
		end
	end

	class TiltHandlebars < Tilt::Template
		def self.default_mime_type
			'application/javascript'
		end

		def initialize_engine; end

		def prepare; end

    # Generates Javascript code from a HandlebarsJS template.
    # The SC template name is derived from the lowercase logical asset path
    # by replacing non-alphanum characheters by underscores.
    def evaluate(scope, locals, &block)
    	binding.pry
    	template = data.dup
    	template.gsub!(/"/, '\\"')
      template.gsub!(/\r?\n/, '\\n')
      template.gsub!(/\t/, '\\t')
    	return 'console.log(1223);'
    end
  end
end

Tilt.register 'mquy',               Client::TiltHandlebars
Sprockets.register_engine '.mquy',  Client::TiltHandlebars
