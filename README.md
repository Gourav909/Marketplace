# Marketplace

## Table of contents
* Dependencies
* Set up
* Branches

## Dependencies
* Ruby '2.7.5'
* Rails '~>7.0.8'
* SQL Database: sqlite3

## Set up
* Clone the repo.
```
    git clone https://github.com/Gourav909/Marketplace.git
```
* Install dependencies
```
    cd marketplace
    bundle install
```
* Add database configuration and add your system user.
```
    database.yml
```
* Create database.
```
    bundle exec rails db:create
```
* Migrate database.
```
    bundle exec rails db:migrate
```
* Seed database.
```
    bundle exec rails db:seed
```
* Run rake task for scrapping data.
```
    bundle exec rake scrap_property_data:create
```
## Branches
* _main
