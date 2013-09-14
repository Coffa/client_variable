require 'action_view'
require 'action_controller'

module Client
  module Helpers
    module View
      extend ActionView::Helpers::JavaScriptHelper
      extend ActionView::Helpers::TagHelper

      def self.included base
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def include_variable
          render_data
        end

        private
        def render_data
          script  = "window.rails = {};"
          script << formatted_data
          script = javascript_tag(script)
          script.html_safe
        end

        def formatted_data
          script = ''
          values.each do |key, val|
            js_key = key.to_s.camelize(:lower)
            script << "rails.#{js_key}=#{normalize(val).to_json};"
          end
          script
        end

        def normalize(value, depth=0)
          return value if depth > 1000
          return value unless value.is_a? Hash

          Hash[value.map { |k, v|
            [ k.to_s.camelize(:lower), normalize(v, depth + 1) ]
          }]
        end

        def values
          Client.generate.merge([Global.values, Request.values].inject(:merge))
        end
      end
    end
  end
end

ActionView::Base.send :include, Client::Helpers::View
