# ICLA Demo
This is a proof of concept for what an automatic ICLA process might look like.

## Installation
The easiest way to develop and deploy the app is to use Docker.

    docker build -t iclas .

# Run the application
To run a functioning instance:

    docker run -d -p 9292:9292 iclas
