# email-notifier

[![Build Status](https://travis-ci.org/umovme/email-notifier.svg?branch=master)](https://travis-ci.org/umovme/email-notifier)

Setup
-------------
* Install Ruby
* * http://rubyinstaller.org/

* Clone the repository below...
```
git clone https://github.com/umovme/email-notifier.git
```
* Access the repository folder
```
cd email-notifier
```
* Run setup.rb file to configure the application
```
ruby setup.rb
```

Configuration
-------------
* Put the CSV files within the folder ./files_to_process 
* Open the conf/email_rules.yml file and configure the email rules for running the application as shown below 

```
to: 
cc: 
subject:
body:
validation:
```

* Run the run.rb file to process the CSV files and send the e-mails
```
ruby run.rb
```

Result
-------------
Emails should be sent to the respective destination address
