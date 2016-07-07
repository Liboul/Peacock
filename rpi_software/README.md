### Setup instructions

Install the bundler for gem management
```bash
sudo apt-get install libssl-dev
sudo gem install bundler
bundle install
```

You need to install the gem management system for the root user as well.
This can be painful so be prepared.

Use some tricks like this one
```bash
/bin/bash --login
rvm use 2.3.0 --default

```

### Server run instruction

Launch the server. You need sudo access in order to manipulate the GPIO:

```bash
sudo su
/bin/bash --login && rackup
```
