# Use a Perl base image (or the base image required for your app)
FROM perl:latest

# Set the working directory
WORKDIR /usr/src/app

# Copy the backend files to the container
COPY . .

# Install dependencies
RUN cpanm --installdeps .

# Expose the port your backend runs on
EXPOSE 80

# Run the application
CMD ["morbo", "app.pl", "-l", "http://*:80"]
