## Installation
Install `rails-6.1.4.1` with ruby version `ruby-2.6.8`
Then run `bundle install`
And also PostgreSQL `database.yml` needs to be configured
 ```bash 
rails db:create
rails db:migrate
```

## Usage
To import products from csv file to db run following command:
 
 ```bash 
rake import:products
```
