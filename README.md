![BART logo](https://bytebucket.org/RobHossBoss/bart/raw/a2f4c1b1f940b2c8a9ebd17126b96be438289757/public/logo-full.png?token=9c50bbc3d27dc9793a7ee1adeedcb3da2180ac17) 

# Berea College Anaylitics and Reporting Tool

BART helps Berea College organize, anaylize, and present data.
[Previous Implementation in PHP](http://sushituesday.club/share/downloads/oldSLEgenerator.zip)

# Summer 2017 Training Videos (Created by Robert Hosking)

## Introduction
[![](http://img.youtube.com/vi/neczdQL9okk/0.jpg)](https://youtu.be/neczdQL9okk)

## Datasets
[![](http://img.youtube.com/vi/VMO_EflRWdM/0.jpg)](https://youtu.be/VMO_EflRWdM)

## Cards
[![](http://img.youtube.com/vi/ce0ddl6OcKQ/0.jpg)](https://youtu.be/ce0ddl6OcKQ)

## You can text me with questions at this phone number

![Robert's phone number](http://i.imgur.com/hZJpGra.jpg)

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

- [Patternfly](http://www.patternfly.org/pattern-library/#_) for data visualization. Uses c3 library.

## Old Report Scans

[2014-2015](http://imgur.com/a/ITMrJ) 

[2012-2013](http://imgur.com/a/ClZNB) 

[2011](http://imgur.com/a/RG79r)



## Notes

The following are notes from several meetings with David Slinker

- Need to be able to compare a specific Department's data to the Division it belongs to and the College as a whole. This is so the supervisor can see how his/her department stacks against the rest. 

- However, privacy is important. A supervisor should not be able to figure out exactly what another department's scores are. Some divisions only have 2 departments so a supervisor would be able to glean how the other department is doing based on their own scores and the division score. Not good.

- Scott has a table that maps Departments to divisions. We'll need that table and make it editable from an admin interface in case of changes.

- We have scans of past reports [2014-2015](http://imgur.com/a/ITMrJ) [2012-2013](http://imgur.com/a/ClZNB) [2011](http://imgur.com/a/RG79r). Use these to get an idea of the kinds of caparisons we'll need. Of course, we want this application to be much more extensible and be able to make nearly every comparison possible from the given data.

### The following are some specific comparisons that were requested

    - the ability to judge a supervisor's time and effort put into the evaluation. Signs of Low effort include:

        1. Supervisor submitted multiple evaluations within a short period of time

        2. Few or short comments, low quality feedback

        3. If submitted multiple evaluations in short period, look for repetitive scoring.

    - Let the end user switch between bar charts and pie charts (version 2.0 feature)

    - Old reports used tables to display data. David seemed attached to those even though there may be better ways to display that kind of data. 
![BART Data Access Level Relations](http://i.imgur.com/FuHaBmH.jpg)
![BART Supervisor Data Access Permissions](http://i.imgur.com/Rf66826.jpg)