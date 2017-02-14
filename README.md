#Berea College Anaylitics and Reporting Tool (BART)

BART helps Berea College organize, anaylize, and present data.

# Version Log

### Version 0.01 - Fall 2016
- Allow admins to upload a spreadsheet as a dataset. [x]
- Perform CRUD on dataset. [x]
- Create "Views" for the end user. [x]
- Add graphs and stuff to these views. []
- Talk to Berea's databases. []
- Allow users to authenticate using Berea credintials. []
- Define user permission scopes. []

## Development Setup Instructions

1. Install [Ruby and Rails](http://railsapps.github.io/installrubyonrails-ubuntu.html)

2. 'git clone https://github.com/RobertHosking/BART.git`

3. `sudo mysql`

    `> CREATE DATABASE BART_development;`
    
    `> grant all privileges on BART_development.* TO 'rails_user'@'localhost' IDENTIFIED BY 'pass';`

4. Ensure `rails_user` and `pass` is specified in `config/database.yml`

5. Run `rails db:migrate`

6. `rails server`


## BART Uses:

- [roo](https://github.com/roo-rb/roo) for parsing spreadsheets.

- [Patternfly](http://www.patternfly.org/pattern-library/#_) for data visualization.

-
