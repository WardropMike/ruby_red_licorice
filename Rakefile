require "rake"
require "rspec/core/rake_task"
require "dotenv"

Dotenv.load

# Default RSpec task
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"  # Run all spec files
end

# Run tests by tag (e.g., `rake spec:smoke`)
task :spec do
  system("rspec")
end

# Example: Run only @smoke tests
namespace :spec do
  desc "Run smoke tests"
  task :smoke do
    system("rspec --tag smoke")
  end

  desc "Run regression tests"
  task :regression do
    system("rspec --tag regression")
  end
end
