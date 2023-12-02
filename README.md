# Ibexa Docker Stack

## Pre-requisites (optional)

Install PHP with CURL extension (5.6+), [docker (1.17+)](https://docs.docker.com/engine/installation/), [docker-compose (1.16+)](https://docs.docker.com/compose/install/).

**[Linux only]** Make sure Docker is managable as a non-root user:
```bash
sudo groupadd docker
sudo usermod -aG docker $USER

+ logout and Login to the system again
```

#### Install [Symfony Launchpad](https://upwind-media.github.io/symfony-launchpad/) globally
```bash
curl -LSs https://upwind-media.github.io/symfony-launchpad/install.bash | bash
sudo mkdir -p /usr/local/bin
sudo mv ~/sf /usr/local/bin/sf
```

## Stack installation

* Clone this repository and enter directory:
```bash
git clone --recurse-submodules git@github.com:upwind-media/ibexa-docker.git
cd ibexa-docker/
```

* Run Symfony Launchpad docker stack installation process:
```
sf create
```

* [Optional] In the meantime, you can update your system hosts file if needed:
```
127.0.0.1	ibexa.local
```

* As soon as Symfony Launchpad is done, your environment should be ready at `http://localhost`.

## Running stack
Start environment:
```
sf up
```

Stop environment:
```
sf stop
```

Import database + storage:
```
sf importdata
```

Dump database + storage:
```
sf dumpdata
```

## Stack details
Available environments:
- DEV: http://localhost
- PROD (without Varnish): http://localhost:81
- PROD (with Varnish): http://localhost:82

Available tools:
- Adminer (PhpMyAdmin alternative): http://localhost:84
- SOLR Web UI: http://localhost:983
- Mailcatcher Web UI: http://localhost:180
- Redis Web UI: http://localhost:83

Full development architecture (where `XX` is `0`):

![Development Architecture - LEMP](https://ezsystems.github.io/launchpad/images/puml/LEMP_architecture.png)

## Symfony Launchpad available commands
```bash
$ ~/sf

Usage:
  command [options] [arguments]

Available commands:
  completion         Dump the shell completion script
  help               Display help for a command
  list               List commands
  self-update        Self Update
 docker
  docker:build       [build] Build all the services (or just one).
  docker:clean       [docker:down|clean|down] Clean all the services.
  docker:comprun     [comprun] Run Composer command in the symfony container.
  docker:create      [create] Create all the services.
  docker:dumpdata    [dumpdata] Dump Database and Storage.
  docker:enter       [enter|docker:exec|exec] Enter in a container.
  docker:importdata  [importdata] Import Database and Storage.
  docker:initialize  [docker:init|initialize|init] Initialize the project and all the services.
  docker:logs        [logs|log] Display the logs.
  docker:sfrun       [sfrun] Run a Symfony command in the symfony container.
  docker:start       [start] Start all the services (or just one).
  docker:status      [docker:ps|docker:info|ps|info] Obtaining the project information.
  docker:stop        [stop] Stop all the services (or just one).
  docker:up          [up] Up all the services (or just one).
  docker:update      Update to last images.
```