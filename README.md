# Flutter Firebase Starter project

**Made with :heartbeat: from Nepal**

A project you can clone to build your next project with Flutter with Firebase services. 


## What Firebase features are implemented?
1. Firebase Authentication
    - Email based sign up/in
    - Google Sign in
2. Cloud Firestore
3. Firebase Messaging
4. Firebase analytics
    - Properly track screen names
    - Ability to track custom events
    - Properly set userid and user properties
5. Firebase Crashlytics
6. Remote Config
7. Provider State management
8. Firebase Storage

## What other features are provided?
1. Localization ready
3. Flavors for Dev and Prod environment (can use different firebase projects based on flavor)
2. Google Fonts
3. Image picker
12. Image cropper
13. Device info (saved in user's profile)
14. Package info
15. Flutter Auth buttons
16. User's profile management
17. Android release signing config

## Getting Started

How to start your project based on this.

1. Clone this repository locally. The folder structure is somewhat based on clean code architecture
2. Delete `.git` folder to clear git history
3. Using `change_app_package_name` package change the package name to whatever you want your package name to be
4. For changing iOS package name use the text editors Find and Replace in whole project folder where you need to find `com.popupbits.firebasestarter` and with the package name you want
5. Using the same Find and replace in whole project folder search for `firebasestarter` (package name for dart/flutter project) and replace it with your own suitable name. (check the flutter package naming standards for acceptable format)
6. Using the same Find and replace in whole project folder search for `Firebase Starter` (display name, launcher name) and replace it with your own suitable name for your app
7. Copy `google-services.json` for dev firebase project in `android/app/src/dev/` and prod firebase project in `android/app/src/prod/`
8. Copy `GoogleService-Info.plist` for dev firebase project in `ios/Runner/firebase/dev/` and prod firebase project in `ios/Runner/firebase/prod`
9. For android signing, modify `android/key.properties` with your signing details and replace `keys/keystore.jks` with your own keystore or provide different location in `android/key.properties` for your keystore
10. For google sign in to work copy value of `REVERSED_CLIENT_ID` from appropriate (dev, prod) `GoogleService-Info.plist` and paste in Xcode->Target Runner->Build Settings tab -> GSI_CLIENT_ID user defined variable. Value for `Debug-dev` and `Release-dev` configuration should be the one from dev `GoogleService-Info.plist` and rest should be from prod `GoogleService-Info.plist`

11. **For push notifications** to work on iOS, you need to follow following two steps as described in [firebase_messaging](https://pub.dev/packages/firebase_messaging) iOS integration section
    - Generate the certificates required by Apple for receiving push notifications following [this guide](https://firebase.google.com/docs/cloud-messaging/ios/certs) in the Firebase docs. You can skip the section titled "Create the Provisioning Profile".
    - Follow the steps in the "[Upload your APNs certificate](https://firebase.google.com/docs/cloud-messaging/ios/client#upload_your_apns_certificate)" section of the Firebase docs.

## Adding new Locale
1. Install [localizely](https://localizely.com/) plugin for your IDE([VS Code](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl) or [Android Studio](https://plugins.jetbrains.com/plugin/13666-flutter-intl))
2. For VS code use the command `Flutter Intl: Add locale` to add new locale, 
3. For android studio, goto `Tools | Flutter Intl` menu and find `Add Locale` command.
4. This will generated the required arb file. You just need to update it with your key-value pairs
5. Also check the documentation of the respective tools


## Contribution
Contribution (suggestions, issues, feature request, pull requests) are highly welcome. Also looking for help in making it testable by adding unit, widget and integration tests.
