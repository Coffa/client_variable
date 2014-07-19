require "action_controller/railtie"

module ClientVariable
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "client_variable/rails/task.rake"
    end
  end
end
