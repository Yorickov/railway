install:
	bundle install

start:
	ruby main.rb

test:
	bin/rspec

lint:
	bundle exec rubocop
