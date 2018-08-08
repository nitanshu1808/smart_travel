# Introduction

Dublin buses and Dublin bikes are the most usable transport medium and the biggest public trans- port provider in the Dublin area. The objective is to guide/acknowledge users about the nearest bus or bike station in order to make the travel experience easier. Not only will it provide the real time information about the transport provider but would also acknowledge user about the nearest transport station. This involves consuming web services of the following:
* Dublin bikes,
* Dublin buses,
* Geo-coding, 
* Geo-place.

 Furthermore, there are two ways how user can register on web application
 * Normal registration process which requires email, user_name and password.
 * Facebook using Omniauth.


# IMPLEMENTATION

This covers the necessary steps to get the application up and running.

1. Install Ruby Version Manager (RVM), consider the link provided below for installation if needed
   https://rvm.io/
2. On successfully installing rvm install ruby version greater or equal '2.4.1'

3. Take a clone from github

4. Install postgres pg as the database for Active Record, consider the link provided below for installation if needed
  https://www.postgresql.org/

5. On successfully installing pg, run the following commands
  * rake db:create  #This would create a database for the application
  * rake db:migrate #This would alter your database schema over time in a consistent and easy way.

6. Run bundle command within the repository inorder to install all the gems (packages).

7. In order to set up the configurations, consider the following steps
  1. Create a application on the developers facebook, Consider the url below if required
    https://developers.facebook.com/. 
  2. On successful app creation add the information details followed by adding Valid OAuth Redirect URIs for example https://localhost:3000/users/auth/facebook(Note: you can remove localhost and your own application url)
  3. Copy the App ID and App Sectret

8. Create a .env file and add
  FB_APP_ID: YOUR APP ID
  FB_APP_SECRET: YOUR APP SECRET

9. In-order consume dublin bikes webservices, you need to create account on the JCDecaux developer,
   consider the link below if required
   https://developer.jcdecaux.com/#/login

10. On successfully creating the account on the JCDecaux developer, copy the app secret, followed by adding them in the .env file.

11. DUBLIN_BIKES_KEY=Secret key

12. This would setup the application

13. In order to verify, run rspec with the repository. This would run all the tests.

14. Within the repository, run rails s and start working



# Deployment instructions

The following steps were involved in deploying the code to the server.

1. Install Heroku on the system (Install-Heroku)

2. heroku create
The command creates a new empty application on Heroku, along with an associated empty ’Git
repository’.

3. heroku git: remote -a app name
Git remote command confirms that a remote named heroku has been set for our application.

4. git push heroku master
Git push command pushes the code from our local repository’s master branch to the heroku
remote.

5. On successful deployment, the authors added all the necessary environment variables for the heroku repo.

6. heroku run rake db: migrate –app name
This command was used to create database with all the migrations.


