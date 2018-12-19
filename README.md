
# Hearth and Home Inventory Sorter (HHIS)

## Background

The inspiration for this app came from a discussion regarding the usefulness of taking an inventory of one's home for insurance purposes. Of course, to be completely useful for that, this app would need to allow the user to upload images an videos. Although I learned how to do this and plan to add this feature, I decided not to do so for the time being.

This project is currently built on Sinatra. I build it for Flatiron's Learn Verified Full stack Web Developer program.

## Description

A limited list of features for the app include:

(1) Users can create an account (the passwords is created with a salted encryption, so there is no way to retrieve it).<br />
(2) A user's account is a closed system. That is, he/she cannot view any content from another user.<br />
(3) Each user can create categories, folders, and items from the navbar.<br />
(4) No two folders and no two categories can have the same name.<br />
(5) Several items can have the same name.<br />
(6) When creating an item, a user can choose existing categories or folders to add it to, and/or or create new ones to add it to.<br />
(7) When editing an item, a user can choose to add it to or remove it from existing categories/folders. The user can also choose to add it to a new category/folder.<br />
(8) When creating or editing a category/folder, the user can do the same thing with items as in 6 and 7.<br />
(9) The user can delete the item only from a category/folder.<br />
(10) The user can delete the item completely from the account and the entire account.<br />
(11) Deleting a category or folder automatically removes the items from it.<br />
(12) Each item's info page displays its name, cost, and description (entered by the user).<br />
(13) The item's info page also displays a dropdown list of folder and categories that item belongs to.<br />
(14) The user can add and edit info on the account page.<br />
(15) The user can delete the account.<br />
(16) The user can log out.<br />

## Plans

The app is not perfect and has issues with its design.<br />
I plan on improving the app's design and features in the future, once I graduate the program.<br />
I do, however, plan on deploying the app to Heroku within the next couple of weeks.<br />

## Installation

Add this line to your application's Gemfile:<br />

```ruby
gem 'hearth_and_home_inventory'
```
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hearth_and_home_inventory

## Usage

At present, until I upload this as a gem or until I deploy it to Heroku, you can run this app by doing the following:

(Note: If you already have ruby and sinatra installed on your machine, skip to (5))<br />

(1) Check if you have Ruby installed by typing 'ruby --version' into the terminal.<br />
(2) Install using RVM. In the terminal, type:<br />
' gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 '
' curl -sSL https://get.rvm.io | bash -s stable --ruby '<br />
(3) Install bundler by typing, ' gem install bundler ' into the terminal.<br />
(4) Install Sinatra by typing, ' gem sinatra ' into the terminal.<br />

(5) Download or clone this repository.<br />
(6) Navigate to the hearth_and_home_inventory directory on your machine using the terminal.<br />
(7) Next, type 'bundle install ' . This should install all of the gems it requires.<br />
(8) Type ' shotgun ' into the terminal.<br />
(9) This will provide you with a url you can follow to test out the website and its pages. (ctrl-C or control-C to exist.).<br />
(10) Alternatively, if you wish to experiment with the app locally, you can do so by typing ' tux ' into the terminal.<br />
(11) Another way you can experiment with the app is by typing ' rake console '.<br />
(12) The link to web-app on Heroku can be found [Here](https://hh-inventorysorter-sinatra.herokuapp.com/).<br />

## Development

//THIS SECTION IS A PLACEHOLDER UNTIL I HAVE THE TIME TO REPLACE IT
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AAM77/hearth_and_home_inventory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Hearth and Home inventory Sorter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/AAM77/hearth_and_home_inventory/blob/master/CODE_OF_CONDUCT.md).

## License
The Hearth and Home Inventory Sorter project has a MIT license. You may view the contents of the license at [license](https://github.com/AAM77/hearth_and_home_inventory/blob/master/LICENSE)

## Built With

* [Sinatra](http://sinatrarb.com/documentation.html) - The web framework used
* [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html) - For Handling Database communication and Model Associations.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/AAM77/hearth_and_home_inventory/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/AAM77/hearth_and_home_inventory/tags).

## Authors

* **Mohammad Adeel**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
