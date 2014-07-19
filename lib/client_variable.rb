require 'client_variable/version'
require 'rails/engine'

module ClientVariable
  def self.❨╯°□°❩╯︵┻━┻
    puts "Calm down, bro"
  end

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

      def push(data = {})
        raise "Object must have each_pair method" unless data.respond_to? :each_pair

        data.each_pair do |name, value|
          set_variable(name.to_s, value)
        end
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
    path = "#{Rails.root}/config/client_variable.yml"
    if File.exist?(path)
      data = YAML.load(ERB.new(File.new(path).read).result)
      config = data[Rails.env]
    end
    config || {}
  end

  class Engine < Rails::Engine; end

  require 'client_variable/request'
  require 'client_variable/global'
  require 'client_variable/helper/view'
  require 'client_variable/helper/controller'
end
