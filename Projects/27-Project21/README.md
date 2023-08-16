# Project 21 - Local Notifications

https://www.hackingwithswift.com/100/72

## Topics

Notifications, UNUserNotificationCenter, UNNotificationRequest

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/read/21/4/wrap-up):
>1. Update the code in didReceive so that it shows different instances of UIAlertController depending on which action identifier was passed in.
>2. For a harder challenge, add a second UNNotificationAction to the alarm category of project 21. Give it the title “Remind me later”, and make it call scheduleLocal() so that the same alert is shown in 24 hours. (For the purpose of these challenges, a time interval notification with 86400 seconds is good enough – that’s roughly how many seconds there are in a day, excluding summer time changes and leap seconds.)
>3. And for an even harder challenge, update [project 2](https://github.com/juliobraganca/100-days-of-swift/tree/main/Projects/02-Project02) so that it reminds players to come back and play every day. This means scheduling a week of notifications ahead of time, each of which launch the app. When the app is finally launched, make sure you call removeAllPendingNotificationRequests() to clear any un-shown alerts, then make new alerts for future days.

## Screenshots
![Screenshot 2023-08-16 at 13 30 29](https://github.com/juliobraganca/100-days-of-swift/assets/127988357/fb41145d-6fe1-45eb-b636-9f71a586fd68)
![Screenshot 2023-08-16 at 13 30 43](https://github.com/juliobraganca/100-days-of-swift/assets/127988357/3994855a-6bcf-4555-95e9-73b5376a7ad8)
![Screenshot 2023-08-16 at 13 30 53](https://github.com/juliobraganca/100-days-of-swift/assets/127988357/edae3b33-cbf9-4b85-a766-36320cc06164)
