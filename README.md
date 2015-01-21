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

