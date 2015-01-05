# Behavior-Driven Docker Development
[![Circle CI](https://circleci.com/gh/coshx/docker-bdd.svg)](https://circleci.com/gh/coshx/docker-bdd)

This repository demonstrates how to use cucumber and behavior-driven
development to orchestrate docker containers into a running 3-tiered
application. It also can be used to quickly get a rails development
environment running for a specific project.

Once you have all the pre-requisites installed, starting up a rails
app is as simple as

    $ fig up -d

or

    $ vagrant up --provision

And then you can visit `http://localhost:8080` or
`http://localhost:3000` on your host machine to access the website.


But the real power of this setup is that we can develop new docker
containers in a test-driven manner.


## Pre-Requisites - Docker & Fig

### Running Docker natively
This is the preferred approach. If you're running linux natively then
just install [Docker](https://www.docker.com/) and
[Fig](http://www.fig.sh/) natively.

### Running Docker on Boot2Docker (OSX)
Follow the instructions to install
[Boot2Docker](https://docs.docker.com/installation/mac/) and then
install [Fig](http://www.fig.sh/install.html)

### Running via Vagrant and Virtualbox
If you're on Windows, or can't get docker installed on your platform,
we've provided a Vagrant setup that you can use. Install
[Virtualbox >= 4.3.20](https://www.virtualbox.org/wiki/Downloads) as
well as [Vagrant >= 1.6.5](https://www.vagrantup.com/downloads.html)
for your platform. Then get up and running:

    $ vagrant up
    $ vagrant provision

Once up and running, you'll run the fig commands from inside the vagrant image:

    $ vagrant ssh
    vagrant@vagrant:~$ cd docker-bdd
    vagrant@vagrant:~/docker-bdd$ fig build
    vagrant@vagrant:~/docker-bdd$ fig up -d
    vagrant@vagrant:~/docker-bdd$ cucumber

On subsequent runs, since there won't be huge downloads, you can just run:

    $ vagrant ssh
    vagrant@vagrant:~$ cd docker-bdd
    vagrant@vagrant:~/docker-bdd$ cucumber

### Testing Dependencies
In addition to installing docker and fig, you'll need to have
[Cucumber](http://cukes.info/) installed in order to run the tests.

    $ sudo apt-get install cucumber

Or,

- install ruby (e.g. via [rvm](http://rvm.io/) or a system package)
- install cucumber

        $ gem install cucumber


## Running the Tests
The tests ensure that the fig cluster is running, so running them is
as simple as running `cucumber`. You can also just run a specific
test:

    $ cucumber features/web.feature

If this is your first time running this, then grab a cup of coffeen
and enjoy a nice 10-15 minute wait, as the base docker images are
downloaded, and then custom images are built and run. Subsequent
executions will be much faster.


## Starting the cluster
Running the tests also accomplishes this, but if you're too lazy to
run the tests:

    $ fig run -d

## When you make a change and want to rebuild a docker container
Again, running the tests accomplishes this, but if you want to do it
manually:

    $ fig build

## Using a rails-enabled dev environment
We've set up the `dev` service to also serve as a development
environment, wher eyou can issue commands like `rails g
scaffold`. Since the files in this environment are the same files that
you have locally, you can edit in your native environment, and use
this environment for doing things like running tests, generating
files, testing out dependencies, etc.

    $ fig run dev


## Viewing Logs
This is a really nice feature of fig, providing a combined output from
all the running services.

    $ fig logs

This will show logs as they come in. Use Ctrl+C to quit.

## Troubleshooting

- `Couldn't connect to Docker daemon at http+unix://var/run/docker.sock - is it running?`
  - Either add your user to the `docker` group (preferred), or use
    `sudo fig` and `sudo cucumber` for the commands.
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
    [fig_steps.rb](features/step_definitions/fig_steps.rb) to just
    sleep for 10 seconds after running `fig up`, but this may not be
    suitable for all environments.


## Thanks
- Thanks to the great work being done on Docker and Fig!
