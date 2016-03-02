# JobOpeningCards
Final Practicum RoR at Talentum Empleo

# Configuration for development and test enviroments.

*Prerequisites: 
..*Git
..*Ruby 2.2.3 
..*Rails 4.2.6
..*Bundler 1.11  

*Main gems added to Gemfile: 
..*Devise
..*Paperclip
..*Bootstrap-sass
..*Font-awesome-sass
..*Simplecov
..*Capybara
..*launchy

*Optional aplications:
..*Web-console
..*SourceTree
..*Aptana Studio 3

Database used: sqlite 3.

#Execution and test

Clone git repository:
```sh
git clone https://github.com/manoloonline/JobOpeningCards.git
```

Install Gems:
```sh
bundle
```

Migrate database(optional, there are development and test databases in the repository):
```sh
rake db:create
```

Run the app locally:
```sh
rails s
```

Before run tests:
```sh
rake assets:precompile
```

Run the tests with:
```sh
rake test
```

# Contributions

Janire Paskua @janirepaskua

Andrea Vega @anvegaco

Antonio Hernando @anherro88

Carmen H. Ledesma @Carmelucky

Manuel Ibáñez 

