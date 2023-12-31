# Pull the Ruby 3.2.0 image from Docker Hub
FROM ruby:3.2.0

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /myapp
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build speeds when your gems do not change.
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$INSTALL_PATH/public"]
