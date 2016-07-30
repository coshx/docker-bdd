# Behavior-Driven Docker Development
[![Circle CI](https://circleci.com/gh/coshx/docker-bdd.svg)](https://circleci.com/gh/coshx/docker-bdd)

This repository demonstrates how to use cucumber and behavior-driven
development to orchestrate docker containers into a running 3-tiered
application. It also can be used to quickly get a rails development
environment running for a specific project.

Once you have all the pre-requisites installed, starting up a rails
app is as simple as

    $ docker-compose up -d

or

    $ vagrant up --provision

And then you can visit `http://localhost:8080` or
`http://localhost:3000` on your host machine to access the website.


But the real power of this setup is that we can develop new docker
containers in a test-driven manner.


## Pre-Requisites - Docker & Docker-Compose

### Running Docker natively

This is the preferred approach, and supports Linux, Mac, and Windows machines.
Install [Docker](https://www.docker.com/) and
[Docker-Compose](http://docs.docker.com/compose/install/).

### Note on Vagrant

Previous versions supported using a docker-enabled virtual machine
through [Vagrant](https://www.vagrantup.com), but now that Docker runs
on Mac and Windows, it's no longer necessary and has been removed.

### Test Dependencies

In addition to installing docker and docker-compose, you'll need to have
[Cucumber](http://cukes.info/) installed in order to run the tests.

    $ sudo apt-get install cucumber

Or,

- install ruby (e.g. via [rvm](http://rvm.io/) or a system package)
- install cucumber

        $ gem install cucumber


## Running the Tests

The tests ensure that the docker-compose cluster is running, so running them is
as simple as running `cucumber`. You can also just run a specific
test:

    $ cucumber features/web.feature

If this is your first time running this, then grab a cup of coffee
and enjoy a nice 10-15 minute wait, as the base docker images are
downloaded, and then custom images are built and run. Subsequent
executions will be much faster.


## Starting the cluster

Running the tests also accomplishes this, but if you're too lazy to
run the tests:

    $ docker-compose run -d

## When you make a change and want to rebuild a docker container

Again, running the tests accomplishes this, but if you want to do it
manually:

    $ docker-compose build

## Using a rails-enabled dev environment

We've set up the `dev` service to also serve as a development
environment, where you can issue commands like `rails g
scaffold`. Since the files in this environment are the same files that
you have locally, you can edit in your native environment, and use
this environment for doing things like running tests, generating
files, testing out dependencies, etc.

    $ docker-compose run dev


## Viewing Logs

This is a really nice feature of docker-compose, providing a combined output from
all the running services.

    $ docker-compose logs -f

This will show logs as they come in. Use Ctrl+C to quit.

## Issues / Improvements

- `bash: cannot set terminal process group (-1): Inappropriate ioctl for device`
    - currently ignoring this message
- adding gems to the rails Gemfile is currently convoluted
    1. `docker-compose run dev`
    1. add the gem to Gemfile
    1. `bundle install`
    1. copy the new `Gemfile` and `Gemfile.lock` to `dockerfiles/rails/`
    1. re-build the `rails` container via `docker-compose up -d` or running `cucumber`
- the android tests take a long time downloading the gradle dependencies each time

## Troubleshooting

- `Couldn't connect to Docker daemon at http+unix://var/run/docker.sock - is it running?`
    - Either add your user to the `docker` group (preferred), or use
      `sudo docker-compose` and `sudo cucumber` for the commands.
- `vagrant up` hangs for me
    - Try launching the virtual machine via VirtualBox directly to see
      if there are any errors.
- I'm on a 32-bit system but the virtualbox/docker images are 64-bit
    - We tried getting this to work with a 32-bit vagrant image, but ran
      into `exec format error` issues. A 32-bit fork of this project
      would be nice.
- I see a bunch of errors in the output saying `stdin: is not a tty`
    - These can safely be ignored, but if you can resolve the issue,
      please submit a pull request
- I get failures when I run `cucumber`, but when I run the failing
  commands manually, they pass.
    - This may be due to the tests running before the server is fully
      started. Currently, there's a hack in
      [docker-compose_steps.rb](features/step_definitions/docker-compose_steps.rb) to just
      sleep for 10 seconds after running `docker-compose up`, but this may not be
      suitable for all environments.


## Thanks

- Thanks to the great work being done on Docker and Docker-Compose!
