# Berea College Anaylitics and Reporting Tool (BART)

BART helps Berea College organize, anaylize, and present data.

## Version Log

### Version 0.01 - Deadline: Spring 2017
- [x] Allow admins to upload a spreadsheet as a dataset.
- [x] Perform CRUD on dataset.
- [x] Create "Views" for the end user.
- [ ] Add graphs and stuff to these views.
- [ ] Talk to Berea's databases.
- [ ] Allow users to authenticate using Berea credintials.
- [ ] Define user permission scopes.

### Version 0.02
- [ ] Admin manually creates users and defines permissions
- [ ] Admin can redefine Division mapping
- [ ] ...

## Development Setup Instructions

1. Install [Ruby and Rails](http://railsapps.github.io/installrubyonrails-ubuntu.html) - BART uses MySQL

2. `git clone https://github.com/RobertHosking/BART.git`

3. `cd bart/`

4. `sudo mysql`

    `> CREATE DATABASE bart_development;`

    `> grant all privileges on BART_development.* TO 'rails_user'@'localhost' IDENTIFIED BY 'pass';`

5. Ensure `rails_user` and `pass` is specified in `config/database.yml`

6. `bundle install`

7. Run `rails db:migrate`

8. `rails server`

## Project Structure Overview
```
├── app
│   ├── assets              # Stylesheets and JavaScripts   
│   ├── controllers         # Controlers are activated by routes and produce output   
│   ├── jobs                # For creating automated or background tasks
│   ├── models              # Code for model methods         
│   └── views               # Frontend .html.erb
│       └── layouts         # Snippits to include througout the application
├── config                    
│   ├── environemnts        # Configuration variables for development, production and testing
│   ├── database.yml        # Database configuration
│   └── routes.rb           # Map URL routes to controler actions
├── db
│   ├── migrations          # All database changes happen in migration files
│   └── schema.rb           # Auto-generated overview of database schema            
├── public                  # File storage folder
│   └── datasets
|       ...
│       ├── 2017        
│       └── 2018
│           ├── spring        
│           └── fall
|               ...
│               ├── dataset       
│               └── other_dataset
│                   ├── versions
|                       ├── <timestamp>data.yml     # queries read from YAML        
│                       └── <timestamp>data.yml     # Previous versions      
│                   ├── [Active Copy]data.xls       # Live .XLS
│                   └── data.xls                    # Original .XLS   
|
└──
```
## Tools used:

- [roo gem](https://github.com/roo-rb/roo) for parsing spreadsheets.

- [Patternfly](http://www.patternfly.org/pattern-library/#_) for data visualization.


## Notes

The following are notes from several meetings with David Slinker

- Need to be able to compare a specific Department's data to the Division it belongs to and the College as a whole. This is so the supervisor can see how his/her department stacks against the rest. 

- However, privacy is important. A supervisor should not be able to figure out exactly what another department's scores are. Some divisions only have 2 departments so a supervisor would be able to glean how the other department is doing based on their own scores and the division score. Not good.

- Scott has a table that maps Departments to divisions. We'll need that table and make it editable from an admin interface in case of changes.

- Check [this Imgur album]() for past reports to get an idea of the kinds of comparisons that are likely to be made. Of course, we want this application to be much more extensible and be able to make nearly every comparison possible from the given data.

### The following are some specific comparisons that were requested

- the ability to judge a supervisor's time and effort put into the evaluation. This can be checked by: