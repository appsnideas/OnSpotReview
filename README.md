# OnSpotReview Commit Descriptions
===================================

Initial "OnSpotReviewFramework" commit
This version has combined code of:
1. OnSpot Review code (Commented)
2. Blog posts exercise code (From Tree House)
3. Gimbal Frames works added.
4. No Main story board design. It is still basic master detail

Vamsi (01/09/2015 05:32 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview - v 1.0
This Version has:
1. been stripped off of all the test code from tree house from masterViewController.m (The main file)
2. Only the App code is present now.
3. If API or help is needed in terms of how to gather data from web, please refer MD-Test project.
4. Commented appropriately.
5. Tested.
6. Values are still hard coded.

Vamsi (01/09/2015 07:53 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview - v 1.1
Added New background to all screens.
Created an empty screen for questions.

_Vamsi (01/11/2015, 11:45 pm)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview - v 1.1
Detail View controller - viewDidLoad Method uncommented
"[self configureView];"
to show the label in the view.

_Vamsi (01/12/2015 1:40 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.2
Added the blog spot example code alson with the hard coded app code.
Created sections for example code and app code.
Non - Hard Cocded - Ecxample code.
Hardcoded - App code.
If you ant to execute the app code, comment all the "non-hardcoded" sections
and uncomment the "hardcoded" sections and vice versa.
The example code should be moified with OUR JSON URL to gather data.

_Vamsi (01/16/2015 9:45 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.3
All Hardcoded code is commented out and is not needed from this point on...Will clean this up later..
Added code to gather event data from URL from website.
Parsed the JSON and showing the event list.

Still have to work on populating rthe detail view lable with details.
Populate the review controller with review questions.
Gimball pop-up.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.4
Finished populating the detail label with correstpoding devent details from the master.

One issue with this is the links are not clickable. People recommend using UI text instead. When tried, the Image is getting messed up and the view itself is gettting messed up. Need to investigate why.
Still have to code on gimball pop up screen and 3rd view for review questions.

_Vamsi (01/20/2015 1:12 am)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.5
Have code to parse the JSON completely, though not all data has been parsed. Only needed parts have been parsed and stored in custom (EventList) class.
Also added gimbal code to enable Gimbal. (QLContext...)
Also added code in gimbal (didArrive method) to grab JSON data and searialization code and parsing code. This will be used especially for pop up of questions based on event. Note that the event Id will be included in this URL, that will be transmitted by the beacon.
Also removed all the default commented code from masterViewController.

_Vamsi (01/20/2012 11:00 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.6
Bought an apple developer account, added a device (Vamsi 4S), created a provisioining profile and added a signing authority to the code to sign and create a test build to check the code on iphone.
Created a .ipa and uploaded it to testflight.
Also was able to test this on Vamsi 4S, with phone connected to the mac when building the app in mac.
Also added text views to the review view to add questions. but no content there yet.

Connected the phone to the mac and tested the app on phone.
The app shows up, whatever functionality is presented is working. Gimball beacon recognizes the phone and adds a sighting.

Issues: 
1. The review view should pop up when beacon recognizes a device Or at the least pop up an alert when device is recognized asking ghe user to review the event.
2. All UI elements like, background images, fonts, button positions, labels, text views etc. are not scaled to different phone sizes. This needs fixing.

_Vamsi (01/22/2014, 11:04 am)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.7
All UI elements like, background images, fonts, button positions, labels, text views etc. are now programatically created.
All reviw question are being populated in text views in review View Controller.

Pending:
Adding Star rating to the questions.
Adding submit logic that creates a answers JSON
Adding this code to gimball pop up menu.

_Vamsi (Jan 25th 2015, 01:20 AM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.8
Implemented backgrounds from Srujana
Added questions and Review stars
Added new project DLStar Rating.

_Vamsi (Jan 26 2015 11:20 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.9
Added code to gather the rating data.

Pending:
Need to create a JSON for this rating data and send it back to server.
Detail screen data has to go in a table to be presentable
minor color changes.

_Vamsi (Jan 28th 2015 01:30 am)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 1.10
Completed populating the event details in a table.
Created a Web View in the detail view and populated the data in a table.

Pending:
Create JSON for the rating and post it to server.
Web View Text color change.
See if better colors are available for Review View.

_Vamsi (Jan 29th 2015 7:10 PM))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 2.0
Completed Creating jSON for the ratings data..
Completed posting to the server. Successfully tested that server is receiving the post.

- A Major release in the sense that app is submission ready 1.0

Pending:
Add a "Thank you alert" after user submits the review. If possible give the count of the number of reviews submitted so far (you can get this in the response of the post)
Check if the review view controller can be scrollable so that we can add more questions.
Web View Text color change.
See if better colors are available for Review View.

_Vamsi (Jan 30th 2015 12:15 pm)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 2.1

Added Alert to Thank the user for the feedback.

Pending:
The views are not auto scaling to the size of the iPhone. Though Auto layout is selected in the storyboard
Scroll feature for detail screen not working - Detail screen is UIWebView over a regular view.
Scroll feature for review screen not working - Review screen is UIText Views (One for question and one for star ratings) over a regular view.

_Vamsi (Jan 30th 8:40 pm)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview  (NR Branch)
_Narayanan (Jan 31st 2:00AM)

Fixed the ReviewController to put everything into a UIScrollView. All questions show up fine now and can be 
submitted with button at the bottom.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 2.2

Merged NR branch (Narayanan's changes) to the master.
Added scrollview to the detail view.
Sizes issues is also resolved. Now it works for all size phones.
Added code to come back to event list when review alert is dismissed.

_Vamsi (Jan 31st 3:00 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 3.0

One other major version.
Implemented the pop up review questions. When a phone is sighted, the review questions screen will pop up, user submits the review and it goes to the server.
The submission also has thank you alert and after alert dismiss the app 1st screen opens up.

Pending:
Need to check out if iBeacon is necessary. If not, make it a regular beacon and test it.
Test if the beacon detects the phone and pops up the querstions wihout connecting to mac. This needs a build to test flight. Vamsi to build it, upload it and share it.
Work on Icon.

_Vamsi (Feb 2nd 2:28 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v 3.1
Implemented Notification Actions, a major change from previous version.
Implemented all the test cases listed below
1. App will recognize the beacon and pop up a notification (action based) for review
    1. Even when the the phone is locked
    2. When locked, selecting a "review" action will ask user for passcode and will open review when unlocked.
    3. Even when the app is *not* running in the back ground.
2. App will recognize the beacon and pop up a notification (action based) for review.
    1. when is open and is in the back ground.
3. App is open and is in the foreground
    1. it will silently pop up the review.
Added "Pilot Version" in splash screen

Pending:
Add "Pilot" on the icon.
Claen up the code - remove unnecessary code, commented code, log messages etc..
Add icon to the app.
Add the 2 hr check to the "Later" action.

Vamsi (Feb 4th 5:35 PM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v3.5
There was a bug in previous build that when a becon is sighted/arrived for 2nd, then the app was failing to pop up the review though the beacon was departed form the first sighting/arrival. This bug was rwsolved by adding a pop up review view instead of using the regular eview view.
This has been tetd with connecting to mac. Needs to be tested with test flight build.
Also added icon to the app.

_Vamsi (Feb 5th 5:48 AM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OnSpotReview v4.0 (App Submission Version)
Bugs are resolved.
Configured for iBeacons.
Times times have been chnaged to production values.
Timer after did arrive is a configurable parameter via ibeacon "Major Version".
Submitting the app for publishing

_Vamsi (Feb 5th 9:15 am)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
