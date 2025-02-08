# Use latest stable Ruby version
FROM ruby:3.3

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl gnupg unzip xvfb libxi6 libgconf-2-4 libappindicator3-1 \
    libasound2 libatk-bridge2.0-0 libatk1.0-0 libcups2 libgtk-3-0 \
    libx11-xcb1 libxss1 lsb-release xdg-utils libxcomposite1 \
    libgbm1 dbus-x11 libpq-dev fonts-liberation

# Add Google Chrome repository
RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list

# Install the latest Google Chrome Stable
RUN apt-get update && apt-get install -y google-chrome-stable && \
    google-chrome --version

# Pin ChromeDriver version (update as needed)
ENV CHROMEDRIVER_VERSION=133.0.6943.53

# Install ChromeDriver (from official Google Chrome for Testing URL)
RUN wget -q "https://storage.googleapis.com/chrome-for-testing-public/${CHROMEDRIVER_VERSION}/linux64/chromedriver-linux64.zip" && \
    unzip chromedriver-linux64.zip && \
    mv chromedriver-linux64/chromedriver /usr/local/bin/ && \
    rm -rf chromedriver-linux64.zip chromedriver-linux64

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
