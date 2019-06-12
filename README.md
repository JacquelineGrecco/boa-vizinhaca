# boa-vizinhaca

This README documents whatever steps are necessary to get the
application up and running.

Dependencies
-
 - Redis: 3.0.6
 - Rvm version: 1.29.3 
 - Ruby version: 2.5.1 
 - Bundler: 1.17.3
 - PostgreSQL: 10.3

Redis:

 1. sudo apt-get install redis-server
 
RVM:

 1. curl -sSL https://get.rvm.io | bash

Ruby & Bundler:

 1. rvm install 2.5.1
 2. rvm use 2.5.1
 3. gem install bundler
 
 Between commands 1 and 2, it is required to enable  to check the option "Run as login shell" in the Gnome terminal's settings(Profile settings > command). It is required to open new terminal after this setting the flag.

PostgreSQL:

 1. wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc  | sudo apt-key add - 
 2. sudo apt-get update 
 3. sudo apt-get install postgresql-10
 4. sudo apt-get install libpq-dev

Our application requires postgres user to be authenticated by MD5 instead of peer, so edit the file */etc/postgresql/10/main/pg_hba.conf* and change the line 
> local   all             postgres                                peer

To:
> local   all             postgres                                md5

After that, restart the postgresql service:
>sudo service postgresql restart

Go to the project root directory and run:


 > bundle install


This will install system dependencies. DO NOT run this as sudo.

Database creation
-

In order to create the database, run the following command:

> rake db:create


Database populate
-

The basic data needed to run the system is created by running this command:

> rake db:seed

Command to reset the database and populate in one go:

> rake db:reset

Running the application
-
In the project root, run:
>redis-server

>bundle exec sidekiq

>rails s

The application will be available at port 3000.
