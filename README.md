
<img alt="Hadis ve Ayet" src="https://github.com/Ramazan713/Assets/blob/4b33e20a0a80bf3458edfb1f0e583789575efa50/images/app/hadiths/app_image_512.png">

<a href="https://play.google.com/store/apps/details?id=com.masterplus.hadiths" target="_blank">
  <img src="https://github.com/Ramazan713/Assets/blob/4b33e20a0a80bf3458edfb1f0e583789575efa50/images/shared/GetItOn.png" height="70" border="0" align="center"/>
</a>

Hadis ve Ayet
==================

'Hadis ve Ayet' application has been developed with Flutter. It has been developed to make hadiths and verses easier to access and its various features more useful.

The app is currently [available on the Play Store](https://play.google.com/store/apps/details?id=com.masterplus.hadiths).

# Features
- The Serlevha contains 1406 hadiths, and there are 5618 hadiths in the Kutub-i Sitte
- You can read hadiths and verses with more than 100 subtopics.
- To continue from where you left off, you can create multiple bookmarks in each section
- There is a fast search system available. If your search result is too long, you can create a bookmark and revisit it later
- You can share hadiths and verses in PDF format using lists
- You can share many pieces of information within the application in both visual and written formats
- You can listen to the verses in different recitations
- Esmaul Husna
- Dhikrmatik
- Verses about prayer in the Quran

## Screenshots
<img alt="Screenshots" src="https://github.com/Ramazan713/Assets/blob/4b33e20a0a80bf3458edfb1f0e583789575efa50/images/app/hadiths/v2.0.0/screenshotsHadiths.png" target="_blank">

# Used Technologies and Methods
- [Material 3](https://m3.material.io/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Bloc State Management](https://pub.dev/packages/flutter_bloc)
- [Firebase](https://firebase.google.com/)
- [Sqlite(Floor)](https://pub.dev/packages/floor)
- [Go Router](https://pub.dev/packages/go_router)

# About Database
A SQLite-based floor database has been used. Only a small portion of the database has been shared

# Run App
There are some steps to build and run demo app
1. Move Database <br>
   move from **assets/example_db/hadiths.db** to **assets/hadiths.db**

2. Create Secrets.dart <br>
   Create file at location **lib/core/constants/secrets.dart** and paste the code below
   ```
    class Secrets{
      static const interstitialAdId = "ca-app-pub-3940256099942544/1033173712";
      static const bannerAdId = "ca-app-pub-3940256099942544/6300978111";
    }
   ```


3. Create properties files <br>
- Create file at location **android/key.properties**, paste the code below and fill according to your need
   ```
    storePassword=
    keyPassword=
    keyAlias=
    storeFile= //keystore path
    
    profileStorePassword=
    profileKeyPassword=
    profileKeyAlias=
    profileStoreFile= //keystorePath
   ```
- Create file at location **android/local.properties**, paste the code below and fill according to your need
  ```
    sdk.dir= //Android SDK path
    flutter.sdk=  //Flutter SDK path
    flutter.versionName=2.0.0
    flutter.minSdkVersion=24
    ADMOB_APPLICATION_ID= //admob id for ads
    flutter.versionCode=15
  ```


4. Firebase Configuration <br>
    - Lastly, you need to configure firebase app with app package name. <br>
    - For this app, **com.masterplus.hadiths** and **com.masterplus.hadiths.debug** package names should be added. <br>
    - Then, **google-services.json** file should be located in **android/app/google-services.json**
   

