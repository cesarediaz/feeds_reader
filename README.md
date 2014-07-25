feeds_reader development configuration
============

Postgres Database
- Login in postgres console
  su - postgres

- Create Role
  create role rss_reader with createdb login password 'testings';

- Run setup migrations
  rake db:setup

