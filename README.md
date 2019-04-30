## How to run the application

* `bundle install`
* `bundle exec rake db:setup`
* `bundle exec rails s`
* Sample user to log in with email: `a@mail.com` and password: `password`
## Deployment task
* Set up a cron job to run the rake task at 00:00am midnight of every Monday to reset kudos for users.
* `bundle exec rake kudos:reset_kudos`

## How to run specs
* `bundle install`
* `bundle exec rake db:setup`
* `bundle exec rspec`

## TODO list for future improvements
* Add paginations for users list, kudos received list and kudos given list.
* Add yml files for all wordings in the app.
* Add searching feature to users list, kudos received list and kudos given list for better user experience.
* DRY JavaScript code with VUE components/To use React for more complex scenarios.
* Add JavaScript specs.
* Add more ruby specs for 100% specs coverage.
* Add many to many relationships to user and organization to allow a user belong to many organizations.




