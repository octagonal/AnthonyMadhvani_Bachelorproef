
# The example app

In order to give a fair representation of each development method's benefits and downsides,
a single app will be built each time using a different design pattern. This will, among other things,
make it possible to give accurate assessments in terms of performance and development speed.

When choosing what kind of application will fit that purpose, common application usage is the
most important qualifier. Developing an application with a very uncommon or niche purpose would
only be useful as a theoretical exercise.

## What it should do

* Asynchronously load images

* Make multi-threaded network calls

* Consume an API

* Make adjustments to the system

* Use a service to give periodical updates to the user

* Implement and use a custom view

* Implicitly call other activities, both internal and external

With these requirements in mind, an example app has been chosen.

## The app: WikiaArt Image Downloader

WikiArt is a website which serves as a central repository for art throughout the ages.
Relevant to the app requirements, it has an API and contains high-resolution imagery.
Using their API, an app will be constructed that allows users to browse art and choose a new wallpaper.

### Flow

The following figure shows how the user will interact with the application and go from one activity to the next.

## What's out of scope

## Quality measurement

### Performance

Performance will be measured using Android Studio's built-in profiler. This has a number of benefits including that every pattern can be tested on a standard set of devices. This allows us to ignore device-specific Android versions, such as Samsung, which tend to have some differences from the standard OS [Link naar samsung bugs].

In order to provide examples that are both usable in the real world and easy to demonstrate, only the latest version of Android will be tested on. Currently this is 6.0.

### Development speed

This is more difficult to measure but certainly useful.

### Verbosity of code

Due to Java's age, a lot of "ceremony" is sometimes required to achieve what a modern language can do more easily. [MEER UITLEG] While certain projects want to remove Java from the picture entirely, such as Kotlin, there is no evidence to support that Google will move away from Java anytime soon. So improving on the efficiency and speed of Android development using standard Java is a top priority. This becomes all the more important when deciding how a whole application should be structured.

If a certain design pattern look promising but proves difficult to implement it simply might not be worth the extra effort, since the big motivator for developing in a structured way is keeping duplication to a minimum and increasing development speed. A point could also be made that the amount of boilerplate a developer must write in order to create something usable has a direct correlation with the amount of bugs that creep up in a project.
