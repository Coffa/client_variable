module ClientVariable
  module Helpers
    module Instance
      def self.included base
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def client
          if new_request?
            Request.id = request.object_id
            Request.env = request.env
          end
          Variable
        end

        private
        def new_request?
          Request.env.blank? || Request.id != request.object_id
        end
      end
    end
  end
end

ActionController::Base.send :include, ClientVariable::Helpers::Instance
