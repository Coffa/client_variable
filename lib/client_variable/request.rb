module Client
  class Request
    class << self
      def env
        @request_env if defined? @request_env
      end

      def env=(environment)
        @request_env = environment
        @request_env['client'] ||= {}
      end

      def id
        @request_id if defined? @request_id
      end

      def id=(request_id)
        @request_id = request_id
      end

      def values
        env.blank? ? {} : env['client']
      end

      def clear
        env && (env['client'] = {})
      end
    end
  end
end
