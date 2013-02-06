# Twitter

http://evening-tor-5846.herokuapp.com/

Twitter is an application that lets you publish short messages of 140
characters or less. Between you and me... I think this website could be huge!

### Setup the development environment

1. Get Ruby 1.9
2. `bundle install`

### Running tests and starting the server

To run tests, use bundler:

1. `bundle exec rake db:test:prepare`
2. `bundle exec rspec spec`

To run the development server:

1. `bundle exec rake db:migrate`
2. `bundle exec rails server`
