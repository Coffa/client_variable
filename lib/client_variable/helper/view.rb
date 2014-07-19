require 'action_view'
require 'action_controller'

module ClientVariable
  module Helpers
    module View
      extend ActionView::Helpers::JavaScriptHelper
      extend ActionView::Helpers::TagHelper

      def self.included base
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def include_variable(opts={})
          render_data(opts)
        end

        private
        def render_data(opts)
          camel_case = opts[:camel_case].nil? ? true : opts[:camel_case]

          script = "window.rails = {};"
          script << formatted_data(camel_case)
          script = javascript_tag(script)
          script.html_safe
        end

        def formatted_data(camel_case)
          script = ''
          values.each do |key, val|
            js_key = camel_case ? key.to_s.camelize(:lower) : key.to_s
            script << "rails.#{js_key}=#{normalize(val, camel_case).to_json};"
          end
          script
        end

        def normalize(value, camel_case, depth=0)
          return value if depth > 1000

          case value
            when Hash
              Hash[value.map { |k, v|
                [ camel_case ? k.to_s.camelize(:lower) : k.to_s, normalize(v, camel_case, depth + 1) ]
              }]
            when Enumerable
              value.map { |v| normalize(v, camel_case, depth) }
            else
              value
          end
        end

        def values
          ClientVariable.generate.merge([Global.values, Request.values].inject(:merge))
        end
      end
    end
  end
end

ActionView::Base.send :include, ClientVariable::Helpers::View
