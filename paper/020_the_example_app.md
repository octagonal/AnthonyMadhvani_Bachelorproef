
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

![http://i.imgur.com/EEnvyqK.png](http://i.imgur.com/EEnvyqK.png)

## Quality measurement

This list of metrics was adapted from *Code Quality: The Open Source Perspective*, which won the 2007 Software Development Productivity Award.

### Efficiency and resource utilization

Efficiency will be measured using Android Studio's built-in profiler, an extremely useful but underused set of tools. This has a number of benefits including that every pattern can be tested on a standard set of devices. This allows us to ignore device-specific Android versions, such as Samsung, which tend to have some differences from the standard OS [Link naar samsung bugs].

In order to provide examples that are both usable in the real world and easy to demonstrate, only the latest version of Android will be tested on. Currently this is 6.0.

### Decoupling

> Decoupling is the process of separating them so that their functionality will be more self contained.

[https://medium.com/@dahnielson/decoupling-2045aadf7729#.igbaix9oz]

### Testability

> Testability is the degree of difficulty of testing a system.  This is determined by both aspects of the system under test and its development approach.

[http://robertvbinder.com/software-testability-part-1-what-is-it/] [https://books.google.co.in/books?id=Ixf97h356zcC]

### Fault tolerance

> The assumption that the system has unavoidable and undetectable faults and aims to make provisions for the system to operate correctly even in the presence of faults. 

[http://srel.ee.duke.edu/sw_ft/node5.html]

### Extensibility

> Extensibility is the capacity to extend or stretch the functionality of the development environment — to add something to it that didn't exist there before. 

[https://msdn.microsoft.com/en-us/library/aa733737%28v=vs.60%29.aspx]

### Verbosity of code

> Good code should be easy to comprehend at a glance. This is easier if most of the characters directly serve the purpose of the code.

[http://programmers.stackexchange.com/a/141198]

Due to Java's age, a lot of "ceremony" is sometimes required to achieve what a modern language can do more easily. This is especially evident when using an older version of Java like Android does. While certain projects want to remove Java from the picture entirely, such as Kotlin, there is no evidence to support that Google will move away from Java anytime soon. So improving on the efficiency and speed of Android development using standard Java is a top priority. This becomes all the more important when deciding how a whole application should be structured.

### Complexity of implementation

If a certain design pattern look promising but proves difficult to implement it simply might not be worth the extra effort, since a big motivator for developing in a structured way is keeping duplication to a minimum and increasing development speed. 

A point could also be made that the amount of boilerplate a developer must write in order to create something usable has a direct correlation with the amount of bugs that creep up in a project.
