# Pomodoro

The pomodoro technique is a time management framework that will improve your focus and productivity. It encourages you to work within the time you have, rather than struggle against it.

You will finish each day with a sense of accomplishment by doing nothing more than working in 25-minute blocks (called pomodoro sessions), followed by 5-minute breaks.

The pomodoro technique is popular with freelancers wanting to track time, students wishing to study more effectively and anyone looking to improve themselves at work or in their personal projects.

The pomodoro technique is simple, yet very effective.

## How to use the Pomodoro Timer?
1. Add tasks to work on today
2. Set estimate pomodoros (1 = 25min of work) for each tasks
3. Select a task to work on
4. Start timer and focus on the task for 25 minutes
5. Take a break for 5 minutes when the alarm ring
6. Iterate 3-5 until you finish the tasks
7. Change the times as per your need from the settings

## Features
- Multi-platform app; can run in android, iOS, web and desktop 
- Color transition to switch moods between work time and rest time
- Audio with push notification at the end of a timer period
- Customizable timer intervals as per your need


## How to run?
1. To update the app constants add alarm sound
    - add the alarm sound in `assets/sounds/` folder
    - find `alarmSoundNames` in `lib/src/constants/app_constants.dart` and, add/update the list

2. To update the app app identifier
    - find and replace the `com.app.pomodoro` with your desired identifier

3. To change the app icon,
    - replace the image `logo.png` in `assets/images/` 
    - run command `flutter pub run flutter_launcher_icons:main`

4. To change the default settings value
    - go to `lib/src/constants/app_constants.dart` and update the values of `settingModelInitial`

5. To run the app
    - make sure to have the Flutter v2.10.3 or more installed in the system
    - run command `flutter pub get`
    - run command `flutter run`


### Screenshots
Idle State            |  Timer Running State
:-------------------------:|:-------------------------:
![](./screenshots/1.png)  |  ![](./screenshots/2.png)

Tasks added            |  Settings
:-------------------------:|:-------------------------:
![](./screenshots/3.png)  |  ![](./screenshots/4.png)
