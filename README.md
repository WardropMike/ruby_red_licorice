# ruby_red_licorice
Ruby Test Automation Framework ready for cloud and ci/cd

# Items to do:
  initialize bundler - Need to to setup a local ruby dev env or use other machine
gem install bundler

# Then initialize Bundler in your project:
bundle init

# Add Testing Framework to Gemfile
Edit the Gemfile and add the desired test framework. Example for RSpec:
source "https://rubygems.org"

gem "rspec"

# Save the file, then install dependencies:
bundle install

# Initialize the Test Framework
For RSpec:
rspec --init

# Create a Sample Test
Inside spec/, create example_spec.rb:
describe "Sample Test" do
  it "runs successfully" do
    expect(1 + 1).to eq(2)
  end
end

# Run Tests:
bundle exec rspec
