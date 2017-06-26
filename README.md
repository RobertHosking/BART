![BART logo](https://bytebucket.org/RobHossBoss/bart/raw/a2f4c1b1f940b2c8a9ebd17126b96be438289757/public/logo-full.png?token=9c50bbc3d27dc9793a7ee1adeedcb3da2180ac17) 

# Berea College Anaylitics and Reporting Tool

BART is being built for the Labor Department at Berea college to perform analytics on results form the Student Labor Evaluations (SLE) and the Learning Experience Evaluations (LEE). Although, as we’ll see later on, BART is designed to be used for any data source.

The SLE and LEE’s are created using SmartEvals which is a third party surveying company that is contracted by Berea College. The SLE and LEE results come to us in the form of a CSV. BART takes that CSV, stores it in the database and performs user defined calculations on it to produce charts, graphs and text to be used in the report.

Previously, the Labor Program has been generating these reports using a PHP script that creates a Microsoft word document based on a template. The department would then print hundreds of copies to distribute to labor supervisors across campus. Check the Bitbucket repo readme under “Resources” to see examples of previous reports.

[Previous Implementation in PHP](http://sushituesday.club/share/downloads/oldSLEgenerator.zip)

# Summer 2017 Training Videos (Created by Robert Hosking)

## Introduction
[![](http://img.youtube.com/vi/neczdQL9okk/0.jpg)](https://youtu.be/neczdQL9okk)

## Datasets
[![](http://img.youtube.com/vi/VMO_EflRWdM/0.jpg)](https://youtu.be/VMO_EflRWdM)

## Cards
[![](http://img.youtube.com/vi/ce0ddl6OcKQ/0.jpg)](https://youtu.be/ce0ddl6OcKQ)

## You can text Robert with questions at this phone number

![Robert's phone number](http://i.imgur.com/hZJpGra.jpg)

# Setting Up a Development Environment

## Step 1: Getting Started on Cloud9:

## Create a Workspace in Cloud9

a) You will want to make sure you choose to clone your repo from bitbucket. You do this by adding your git URL. Use https one.
Paste your BART repo url inside **'Clone from Git or Mercurial URL'** query. 
<br>Note: delete **git clone** from the url 
<br>This gives you an empty workspace. It doesn't actually clone the whole repo but it prevents Cloud9 from creating default **Ruby on Rails** application
in your workspace.

b) On **'Choose a template'** part, make sure you choose **'Ruby Rails'** for your workspace. Afterwards, **'Ruby on Rails'** framework will automatically be installed on your workspace.


## Step 2: Getting Your Development Environment Running

Open your workspace terminal. Make sure you're inside the **workspace** directory on the terminal.
1. Clone the BART repo in your workspace. You can do it by copying **'git clone url'** from your BART's bitbucket repo and paste it in the terminal. (e.g `git clone https://shersanginov@bitbucket.org/RobHossBoss/bart.git`)

2. `cd bart/`

3. `sudo mysql` 
   <br>If you get this error: can't connect socket '/var/run/mysqld/mysqld.sock, 
then you first need to type `sudo service mysql restart` and then `sudo mysql`. (now you are logged in inside your database as a root user)

    `> CREATE DATABASE BART_development;`

    `> grant all privileges on BART_development.* TO 'rails_user'@'localhost' IDENTIFIED BY 'pass';`

5. Ensure `rails_user` and `pass` is specified in `config/database.yml` (i.e. username: rails_user / password: pass)

6. `bundle install`

7. Run `rails db:migrate`

8. To run the application on Cloud9, click on **Run Project**. Once you click on it,
the **Ruby on Rails** terminal shows up. On a top-right corner of the terminal, click
on the **CWD** and then, select **bart** folder so 'bart' becomes the root directory when you run the application.
Once you do this, click on **Run** again.

You should get: **Your code is running at https://tes1-shers.c9users.io.** 
Click on this link. It loads a little bit and then it opens **Bart** in a new tab.

If you're not developing in Cloud9, you can run 'Bart' from the terminal with the below command:

`rails server`


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
## Models
BART has several models.

- Report - Composed of many Sections.

- Dataset - References a single CSV file’s data. The data from the file is categorized in in the database using multiple tables. (See “Design”)

- Section - Designed to organize reports. Composed of many Cards.

- Card - Can be charts, graphs, or rich text. Cards display the data from Datasets.

- User - (not implemented yet) - Admins, supervisors, or other. Admins can create and edit reports, Supervisors can view data that pertains to them or the campus as a whole. “Others” are special exceptions who have custom viewing access that needs to be defined. (e.x. The Dean of Labor = Admin, Scott Heggen = supervisor, President Roelofs = other)

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