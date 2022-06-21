# Machine test Setup

This project spins up a docker Ubuntu container in your machine to conduct interviews for candidates. 

The candidates can login to the server using the SSH credentials while you will be able to see their live screen in your terminal.

## Start a test

Follow the below commands.

```sh
# Clone the repo
cd interview-machine-test

# Make sure that you have a working docker daemon
# Build the docker image for running tests
make build

# Make sure you have set up ngrok terminal -> https://ngrok.com/
# Run your container and port forward with ngrok
make start-session
```

Now, you will have a port mapping in your terminal. Provide these details as SSH login details to the interviewee.

## View live session

Once the interviewee logs in using SSH, you can see live logs using below command.

```sh
make view-session
```
