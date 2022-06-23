# Machine Test Infrastructure Setup

This project spins up a docker Ubuntu container in your machine to conduct interviews/machine tests for candidates. 

The candidates can login to the server using the SSH credentials while you will be able to see their live screen in your terminal.

## Prerequisites 

Project uses docker to run a container for machine tests and ngrok to create a public domain name to access it.

* Install [Docker](https://docs.docker.com/engine/install/)
* Set up [ngrok](https://ngrok.com/) 

## Start a test

Follow the below commands.

```sh
# Clone the repo
git clone git@github.com:ashithwilson/machine-test-infra.git
cd machine-test-infra

# Make sure that you have a working docker daemon
# Build the docker image for running tests
make build

# Make sure you have set up ngrok terminal -> https://ngrok.com/
# below command runs a docker container and sets up port forwarding using ngrok
make run
```

Now, you will have a port mapping in your terminal. Provide the ngrok domain name as SSH host and TCP port as SSH Port. For example consider the below portmapping.

```sh
Forwarding            tcp://0.tcp.in.ngrok.io:18744 -> localhost:2222
```

Here, the SSH details are as follows.

```sh
Host: 0.tcp.in.ngrok.io
Port: 18744
```

The SSH login details are as follows.

```bash
Username: ubuntu
Password: cldr@999
```

Note: The username and password are hardcoded in [dockerfile](Dockerfile#L7)

Ask the interviewee to login with these SSH details. 

## View live session

Once the interviewee logs in using SSH, you can see live screen of interviewee using below command.

```sh
make view-session
```
