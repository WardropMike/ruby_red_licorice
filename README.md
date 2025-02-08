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

# Maintenance
# Steps to build and update the gemfile and gemfile.lock.
 - Make update to the Gemfile locally.
- docker build -t ruby-test-framework .
- docker run --rm -it ruby-test-framework sh # Not necessary if you are not looking at the updates.
- docker run --rm ruby-test-framework cat Gemfile.lock > Gemfile.lock
- Then commit changes and push a new branch.

# Occasionally ChromeDriver version will need to be updated:
- The latest versions can be looked up @
- https://googlechromelabs.github.io/chrome-for-testing/

# Syntax to run rake commands:  
- rake spec             # Runs all tests
- rake spec:smoke       # Runs only tests tagged with @smoke
- rake spec:regression  # Runs only tests tagged with @regression

# Tag Tests and Tasks like this:
- it "tests login", :smoke do
-  # test logic here
- end
