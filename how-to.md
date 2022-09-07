## How to run?
1. To update the app constants add alarm sound
    - add the alarm sound in `assets/sounds/` folder
    - find `alarmSoundNames` in `lib/src/constants/app_constants.dart` and, add/update the list

2. To update the app app identifier
    - find and replace the `np.com.sujangainju.pomotimer` with your desired identifier

3. To change the app icon,
    - replace the image `logo.png` in `assets/images/` 
    - run command `flutter pub run flutter_launcher_icons:main`

4. To change the default settings value
    - go to `lib/src/constants/app_constants.dart` and update the values of `settingModelInitial`

5. To run the app
    - make sure to have the Flutter v2.10.3 or more installed in the system
    - run command `flutter pub get`
    - run command `flutter run`
