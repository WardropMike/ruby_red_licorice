# Use the latest stable Ruby version
FROM ruby:3.3

# Set the application directory
ENV APP_HOME=/app
WORKDIR $APP_HOME

# Install dependencies and clean up to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    wget \
    unzip \
    xvfb \
    dbus-x11 \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
    libxi6 \
    libnss3 \
    libgconf-2-4 \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxss1 \
    lsb-release \
    xdg-utils \
    libxcomposite1 \
    libgbm1 \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome
RUN curl -sS -o /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i /tmp/google-chrome.deb || apt-get -fy install \
    && rm /tmp/google-chrome.deb

# Install Chromedriver with matching Chrome version
RUN BROWSER_MAJOR=$(google-chrome --version | awk '{print $3}' | cut -d. -f1) \
    && curl -sS -o /tmp/chrome_version "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${BROWSER_MAJOR}" \
    && curl -sS -O "https://chromedriver.storage.googleapis.com/$(cat /tmp/chrome_version)/chromedriver_linux64.zip" \
    && unzip chromedriver_linux64.zip -d /usr/local/bin/ \
    && rm chromedriver_linux64.zip /tmp/chrome_version

# Set Chrome to run without sandboxing (for container compatibility)
RUN sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox|g' /opt/google/chrome/google-chrome

# Copy and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy project files
COPY . .

# Run tests by default
CMD ["bundle", "exec", "rspec", "--dry-run", "spec"]
