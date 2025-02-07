# Use latest stable Ruby version
FROM ruby:3.3

# Set up dependencies
RUN apt-get update && apt-get install -y \
  libxi6 libnss3 libgconf-2-4 fonts-liberation \
  libappindicator3-1 libasound2 libatk-bridge2.0-0 \
  libatk1.0-0 libcups2 libgtk-3-0 libx11-xcb1 \
  libxss1 lsb-release xvfb xdg-utils libxcomposite1 \
  libgbm1 dbus-x11 unzip curl git wget libpq-dev

# Install Google Chrome
RUN curl -L -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome.deb && rm google-chrome.deb

# Install ChromeDriver (matching version)
RUN BROWSER_MAJOR=$(google-chrome --version | awk '{print $3}' | cut -d '.' -f 1) && \
    DRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${BROWSER_MAJOR}") && \
    wget -q "https://chromedriver.storage.googleapis.com/${DRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    rm chromedriver_linux64.zip

# Set the working directory
WORKDIR /app

# Copy dependency files and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy all project files
COPY . .

# Initialize RSpec (automatically creates the `spec/` folder)
RUN bundle exec rspec --init || true

# Default command (Run tests)
CMD ["bundle", "exec", "rspec", "--dry-run", "spec"]
