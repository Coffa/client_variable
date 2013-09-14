require "fileutils"

namespace :assets do
  desc "Compile all the assets named in config.assets.precompile"
  task :precompile do
    Rake::Task["assets:clobber"].invoke
    Rake::Task["assets:precompile"].invoke
  end
end
