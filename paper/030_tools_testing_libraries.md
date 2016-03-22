
# Tools, Testing and Libraries

Before developing the application, a number of important tools and popular libraries will be reviewed.
Deciding if and when a certain library should be used can have a major impact on an application. [@Extensibility]
Not only does the developer have to depend on the library's maintainer to keep it up to date, without careful attention to implementation the risk of vendor lock-in becomes significant.

Android's great selection of profiling tools on the other hand, is often considered as something to use only as a last resort. Proof will be presented here that shows how invaluable they are.

## Tools

### The Performance Profiling Tools

Android Studio's profiling tools are spread out over several packages and inside the Developer Options menu on a phone itself.

#### GPU

GPU performance can be profiled in two distinct ways: on the device itself using the *GPU Overdraw* and the *GPU Rendering* tools, and using a desktop application called the *Hierarchy Viewer*.[@_performance_profiling_tools_]

##### On-Device tools

The GPU overdraw tool simply displays how many times a specific part of a layout has been drawn over i.e. the amount of elements underneath a certain spot.

The level of overdraw is visualized in colors, using this scale:

![GPU Overdraw, image property of Google](http://developer.android.com/images/tools/performance/debug-gpu-overdraw/gettingstarted_image03.png)

* True color: No overdraw
* Blue: Overdrawn once
* Green: Overdrawn twice
* Pink: Overdrawn three times
* Red: Overdrawn four or more times

While having no overdraw at all would be exceedingly difficult, Google generally recommends having an overdraw of at most one (blue).[@_performance_profiling_tools_]

##### Layout Hierarchy Inspection

Every added level of GUI abstraction comes attached with added overhead. This can mean anything from choppy animations to an view taking an unacceptably long time to load.

While it might be possible to make a somewhat accurate mental visualization of a view's hierarchy, specialty tools are needed if any kind of accurate profiling is required. This is what the Hierarchy Viewer provides.[@_performance_profiling_tools_]

The Hierarchy Viewer is divided into three main parts:

* A device list, which makes it possible to select the device that needs to be inspected.
* A console which provides device information.
* The layout and tree views, which respectively visualize the view's hierarchy and its layout in the shape of a wireframe.

![Easily inspecting the Settings App using Hierarchy Viewer](http://i.imgur.com/Jw18sjq.png?1)

#### Memory Performance using Memory Monitor

Enabling the monitor takes a few steps:

* Make sure ADB integration is enabled by checking "Tools > Android > Enable ADB Integration"
* Open the memory tab at the bottom of the IDE window (in Android Monitor)

The monitor view should now be visible and outputting information.

![Memory Monitor, image copyright Google](http://developer.android.com/images/tools/performance/memory-monitor/gettingstarted_image003.png)

In order to get a good overview of how much memory an application is currently consuming, the Memory Monitor tool is excellent.

In an easy to parse graph it displays the current amount of memory and the amount of free memory.[@_performance_profiling_tools_]

#### Testing Battery Usage

![A common Battery Historian view](http://41.media.tumblr.com/b762b0f39b2984ac7b7190634f4a058c/tumblr_np7q6t0HV51uvcr50o1_1280.png)

How much battery life an application consumes should be one of the most important concerns of any mobile developer. Not only will consumers be more likely to use an application if they don't notice any considerable decrease in battery life by using it[@ferreira_understanding_2011]: battery life can also give clues into how many resources every single component of an application needs.

This is tied into several other profiling tools such as the Hierarchy Viewer and the Memory Tracers, since more resources means less battery life.

Battery life is best tested using Battery Historian, an open source program published by Google. Unlike most other profiling tools, battery historian is a simple Python script and it not embedded into the Android Studio IDE.[@_performance_profiling_tools_] This does not mean Battery Historian is difficult to work with however, as it only requires a few steps:


First, download Battery Historian from [http://github.com/google/battery-historian](github.com/google/battery-historian).

Using the command line, kill the current Android Device Bridge Server:

    > adb kill-server

Make sure the target device is connected:

    > adb devices

Restart the battery data gathering process:

    > adb shell dumpsys batterystats --reset

Next, disconnect the phone and use the app until enough data has been gathered.
Disconnecting the device is crucial since otherwise it will charge its battery via USB.

Then, reconnect the device and check if it has successfully connected to ADB:

    > adb devices

Dump the battery statistics to a text file:

    > adb shell dumpsys batterystats > batterystats.txt

Navigate to the directory in which Battery Historian was downloaded, an issue this command:

    > python historian.py batterystats.txt > batterystats.html

### Network Traffic Capturing

Traffic capturing is currently not very well supported by Google.

With a little hacking however, it is definitely possible.

Requirements:

* A rooted phone
* Shark for Root, an app which wraps tcpdump and can record network trafic
* Shark Reader, for viewing captures

Using this configuration it's possible to capture traffic directly on a device and view it at a later time. There are a lot of "ifs and buts" however: most phones are not rooted and the interface is qute sluggish.

![SharkReader: most likely not the greatest interface ever. Image copyright lanrat.com](http://lh4.ggpht.com/_55LVV0RexIc/TLuZsrqOIpI/AAAAAAAABaQ/mPA2_oqZrKs/s400/snap20101017_174413.png)

Luckily a better alternative exists: using a computer as a wireless hotspot.

Requirements:

* A computer which can serve as a hotspot
* Wireshark/tshark

Once the device is connected to the hotspot, enter `ip.src == *Device IP*` in Wireshark's filter bar. This will show every package orginating from the phone in question.

![Viewing TCP conversations and a TCP flow graph of a connected device](http://i.imgur.com/D3ppotK.png)

By using the `tshark` command in the console, it's also quite easy to directly view GET requests.

![Viewing GET requests using tshark](http://i.imgur.com/v5aHwsR.png?1)

It should also be noted that tshark has deep knowledge of a very large amount of TCP protocols and not just HTTP, like for example database-specific MongoDB TCP calls.[@evans_tcpdump]

This technology stack should provide sufficient tooling for almost all situations.

### Testing

This chapter will briefly detail the testing frameworks that will be utilized in testing the functionality of the example application. Proficiency in testing is already assumed on the reader's part as an introduction to testing itself it out of the scope of this thesis.

Several great resources are available that serve as an excellent introduction to testing and test driven development, such as *Test Driven Development: By Example* and *Pragmatic Unit Testing in Java 8 with JUnit*.

#### Robolectric

> Robolectric is a unit test framework that de-fangs the Android SDK jar so you can test-drive the development of your Android app.

Robolectric forms the glue between unit testing and the Android SDK. This library makes it possible to efficiently test an application's UI code in isolation from its business logic. Separating UI and business logic is achieved primarily by way of *mocking* out (also known as *faking*) most other code.[@_robolectric_]

This thesis's source code, for example, was tested using Robolectric because it has several major benefits over Espresso:

* Nearly the whole Android SDK can be faked, while providing features those libraries normally would not have such as internal inspection and reflection.
* Excellent support for multi-threaded classes such as AsyncTasks and Handlers. This works wonderfully for testing the return value of functions off the main thread and inspecting them.
* Non-UI code does not need to be tested on an emulator, which can tremendously speed up the test-develop-test cycle.
* Add-ons are available which provide testing support for Google Play Services (among others).
* Activity creation can be mocked out and controlled via an `ActivityController`, with `Fragment` and `View` mocking functioning in a similar manner on an `ActivityController` as well.

[@_robolectric_stackoverflow]

The basic workings of Robolectric are explained no better than by the authors themselves:

    @RunWith(RobolectricTestRunner.class)
    public class MyActivityTest {

    @Test
    public void clickingButton_shouldChangeResultsViewText() throws Exception {
            MyActivity activity = Robolectric.setupActivity(MyActivity.class);

            Button button = (Button) activity.findViewById(R.id.button);
            TextView results = (TextView) activity.findViewById(R.id.results);

            button.performClick();
            assertThat(results.getText().toString()).isEqualTo("Robolectric Rocks!");
        }
    }

First, through a Testrunner annotation, it is declared that this test should be performed using Robolectric. Using this identifier tells the compiler that this is an actual Robolectric test and so it is required.

Next, a new activity is instantiated (and its XML inflated) using *setupActivity* by providing that method with a class deriving from *Activity*.

Following that a `Button` and a `TextView` are instantiated from the Activity's associated XML.

Finally, a button click is performed which the test expects to make `results` text say "Robolectric Rocks!"

Besides a single Robolectric-specific Activity instantiation and an assertion at the end, this unit test is exactly the same as any regular Android code. The unity between test code and actual code makes writing Robolectric tests fairly straightforward (which is exactly what the authors intended).

## Libraries

### Dagger2

Dagger2 is considered the standard dependency injection (inversion of control) library for Android. Dagger was originally developed by Square and subsequently forked by Google.

Dagger was created to get all the benefits of dependency injection without the boilerplate.[@dagger_github]

Reasons for using a dependency injection framework on Android:

* Easily swap out dependencies with fakes
* Make different configurations by simply changing how a dependency is resolved
* It's declaratice: there is no logic involved in setting up the dependencies
* Error reports and graph composition at compile time
* No reflection overhead
* Sane debugging with few stack frames and human-friendly generated class names

Dagger is essentially made up out of several annotations which tell it how dependencies should be resolved:

* `@Inject`
* `@Module`
* `@Provides`

\@Inject is used to annotate classes which Dagger should be allowed to instantiate. It may also be used on fields in order to tell Dagger how if those should be resolved as well.

    //Code taken verbatim from http://google.github.io/dagger/users-guide
    class Thermosiphon implements Pump {
      private final Heater heater;
      @Inject Pump pump;

      @Inject
      Thermosiphon(Heater heater) {
        this.heater = heater;
      }
    }

 In this class, `heater` and `pump` never need to be instantiated as it will be resolved by Dagger.

 Sometimes a simple inject does not suffice, for example when using a third-party library or when code needs to be configured. That's where \@Provides comes in.

    //Code taken verbatim from http://google.github.io/dagger/users-guide
    @Module
    class DripCoffeeModule {
      @Provides static Heater provideHeater() {
        return new ElectricHeater();
      }

      @Provides static Pump providePump(Thermosiphon pump) {
        return pump;
      }
    }

Here, it is declared that a `Heater` should resolve to `ElectricHeater` and a `Pump` to a `Thermosiphon`. Note that providePump itself also has a dependency.

    //Code taken verbatim from http://google.github.io/dagger/users-guide
    @Component(modules = DripCoffeeModule.class)
    interface CoffeeShop {
      CoffeeMaker maker();
    }

    CoffeeShop coffeeShop = DaggerCoffeeShop.builder()
        .dripCoffeeModule(new DripCoffeeModule())
        .build()

Having built up the dependency graph, the dependency injection can be instantiated by using Dagger's generated code (which it made by examining the `CoffeeShop` interface).[@google_developers_dagger_2014]

### RxJava

RxJava and RxAndroid are the standard libraries for making *Reactive Extensions* available to Android. What it essentially does is make it far easier to write asynchronous code that using event-based observables.

Reactive Extensions exist out of two basic building blocks: *Observers* and *Observables*. Observables emit a value which an Observer can receive by subscribing to an Observer.[@dupree_rxjava]

Here is what typical RxJava code looks like, in order to display weather events from a fictitious forecasting service:

    Observable<List<Forecast>> weatherObservable = Observable.fromCallable(new Callable<List<Forecast>>() {
    //The network call needed to receive a weather forecast is placed in a Callable, which makes it non-blocking

        @Override
        public List<Forecast> call() {
        //call() will be called when an Observer subscribes
            return httpClient.getForecasts("today");
        }
    });

    weatherSubscriber = weatherObservable
        .subscribeOn(Schedulers.io()) //The Observable is set to run on a separate thread, so the main UI thread is never blocked
        .observeOn(AndroidSchedulers.mainThread()) //The Observer is set to receive events on the main UI thread
        .subscribe(new Observer<List<Forecast>>() {

            @Override
            public void onCompleted() { } //This event is fired when the Observable is done emitting events

            @Override
            public void onError(Throwable e) { } //If an error occurs, it will be thrown here

            @Override
            public void onNext(List<Forecast> weather){ //When a new value is received from the Observable's stream, it will be sent here
                displayWeather(weather);
            }
        });

Note that a different type of Observable called a Single also exists, which only emits two events: onCompleted and onNext.
In this use case it would be preferable since only one event is ever emitted.

The RxJava standard library is positively huge and almost every possible use case has been accounted for.[@reactivex]

Several other packages also exist which extend RxAndroid such as *RxLifecycles*, which helps with unsubscribing from observables to kill of any possible remaining threads.

### Mortar
>A simple library that makes it easy to pair thin views with dedicated controllers, isolated from most of the vagaries of the Activity life cycle.

* **Mortar will be used in the MVP version of the example app, so only a cursory view explaining the reasoning behind Mortar is provided here.**

Mortar was developed to make it easier to use a `View` as the basic unit of an Android application, as opposed to fragments. The reasoning behind this is that Fragments introduce a huge amount of complexity to the flow of an application without adding many benefits.

The functionality Mortar provides essentially simplifies access to an Activity's lifecycle events using its `BundleService`. Besides this, it also contains a `Presenter` class which builds upon this service, meant as an aid in developing applications in an MVP pattern.[@square/mortar]

#### Why forego Fragments?

In a well-known post on Square's Engineering Blog, a part-rant part-solution was provided for managing an app in a well-structured way.

In this blog, the combination of Fragments' and Activities' lifecycle was dubbed the "lolcycle". Besides being complex in usage, it also makes Android extremely hard to debug.

So an alternative was provided to the lolcycle: using custom views. Sharing the lifecycle of Activities with those views made it far easier to develop but an other problem became obvious: there was a need for decoupling UI from logic.

This eventually resulted in a combination of custom views needing access to lifecycle events and presenters controlling those customs views.

As a solution to this Mortar was developed.[@advocating]
