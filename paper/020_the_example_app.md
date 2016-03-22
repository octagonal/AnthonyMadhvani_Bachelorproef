
# The Example App

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

## The app: Tumblr Image Downloader

Tumblr is a website which on which users can host a blog.
Relevant to the app requirements, it has an API and contains high-resolution imagery.
Using their API, an app will be constructed that allows users to browse art and choose a new wallpaper.

### Flow

The following figure shows how the user will interact with the application and go from one activity to the next.

![Application flow](http://i.imgur.com/EEnvyqK.png)

## Quality measurement

This list of metrics was adapted from *Code Quality: The Open Source Perspective*, which won the 2007 Software Development Productivity Award. [@beizer_software_2003]

### Efficiency and resource utilization

Efficiency will be measured using Android Studio's built-in profiler, an extremely useful but underused set of tools. This has a number of benefits including that every pattern can be tested on a standard set of devices. This allows us to ignore device-specific Android versions, such as Samsung, which tend to have some differences from the standard OS [@android_samsung] [@samsung_hell].

In order to provide examples that are both usable in the real world and easy to demonstrate, only the latest version of Android will be tested on. Currently this is 6.0.

### Decoupling

> Decoupling is the process of separating components so that their functionality will be more self contained. -Anders Dahnielson

This is arguably the most important metric in code architecture quality. Without a decoupled architecture, code will quickly become entangled an extremely difficult to extend. It also has a number of important consequences for how easy it is to test code and avoid duplication.

A simple test can be performed to find out how decoupled the code is: attempt to cast it into a layered diagram.

Would it be possible to describe the general architecture with just a well defined components:

![Decoupled code](http://i.imgur.com/F4jKsG1.png)

Or would it take quite some effort:

![Entangled code](http://i.imgur.com/AXj0njX.png)

### Testability

> Testability is the degree of difficulty of testing a system.  This is determined by both aspects of the system under test and its development approach. -Robert .v Binder

In order to make it attractive to developers to test their code, the code itself should be easy to test.

This is heavily dependent on the pureness of classes and how many side effects might occur when invoking a function. The more global state is accessed in code, the more the correct functioning of that code depends on values it can't control itself.

The relation between testability and decoupling will be examined by using Dagger in the example application.

### Fault tolerance

> The assumption that the system has unavoidable and undetectable faults and aims to make provisions for the system to operate correctly even in the presence of faults. -Kishor Trivedi

Fault tolerance is not just simple error handling and exception catching -it is a conscious approach to taking care of a user's data and the availability of the services an application provides.

As an example, what happens when the application loses connectivity to the internet? How much time should pass before a new attempt at connection is made? How does it affect any background processes that might need a connection?

Tolerance to unexpected circumstances is thus something that should be embedded throughout the codebase and taken into consideration from the very start of a project.

### Extensibility

> Extensibility is the capacity to extend or stretch the functionality of the development environment — to add something to it that didn't exist there before. -MSDN, What is Extensibility?

While clearly related to the degree of decoupling, the extensibility of code is an important measurement on its own. Without a good system in place to extend existing code, it becomes increasingly difficult make additions that are clean, easy to test and not reliant on global state.

### Verbosity of code

> Good code should be easy to comprehend at a glance. This is easier if most of the characters directly serve the purpose of the code. -Nathan Long

Due to Java's age, a lot of "ceremony" is sometimes required to achieve what a modern language can do more easily. This is especially evident when using an older version of Java like Android does. While certain projects want to remove Java from the picture entirely, such as Kotlin, there is no evidence to support that Google will move away from Java anytime soon. So improving on the efficiency and speed of Android development using standard Java is a top priority. This becomes all the more important when deciding how a whole application should be structured.

### Complexity of implementation

If a certain design pattern look promising but proves difficult to implement it simply might not be worth the extra effort, since a big motivator for developing in a structured way is keeping duplication to a minimum and increasing development speed.

A point could also be made that the amount of boilerplate a developer must write in order to create something usable has a direct correlation with the amount of bugs that creep up in a project.
