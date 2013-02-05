source :rubygems
ruby '1.9.3'

gem 'rails', '3.2.11'
gem 'strong_parameters'

group :production do
  gem 'pg'
end

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'haml-rails', '~> 0.3'
  gem 'uglifier', '>= 1.0.3'
end

gem 'haml'

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'fabrication', '~> 2.5'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent', '~> 0.9.1'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'
