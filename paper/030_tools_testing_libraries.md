
# Tools, Testing and Libraries

Before developing the application, a number of important tools and popular libraries will be reviewed.
Deciding if and when a certain library should be used can have a major impact on an application. [@Extensibility]
Not only does the developer have to depend on the library's maintainer to keep it up to date, without careful attention to implementation the risk of vendor lock-in becomes significant.

Android's great selection of profiling tools on the other hand, is often considered as something to use only as a last resort. Proof will be presented here that shows how invaluable they are.

## Tools

### The Performance Profiling Tools

Google's profiling tools are spread out over several ackages and inside the Developer Options menu on a phone itself.

#### GPU and Memory Performance

#### Layout Hierarchy Inspection

Every added level of GUI abstraction comes attached with added overhead. This can mean anything from choppy animations to an view taking an unacceptably long time to load.

While it might be possible to make a somewhat accurate mental visualization of a view's hierarchy, specialty tools are needed if any kind of accurate profiling is required. This is what the Hierarchy Viewer provides.

The Hierarchy Viewer is divided into three main parts:

* A device list, which makes it possible to select the device that needs to be inspected.
* A console which provides device information.
* The layout and tree views, which respectively visualize the view's hierarchy and its layout in the shape of a wireframe.

#### Testing Battery Usage

How much battery life an application consumes should be one of the most important concerns of any mobile developer. Not only will consumers be more likely to use an application if they don't notice any considerable decrease in battery life by using it: battery life can also give clues into how many resources every single component of an application needs.

This is tied into several other profiling tools such as the Hierarchy Viewer and the Memory Tracers, since more resources means less battery life.

### Bandwidth Efficiency Testing

### Testing

This chapter will briefly detail the testing frameworks that will be utilized in testing the functionality of the example application. Proficiency in testing is already assumed on the reader's part as an introduction to testing itself it out of the scope of this thesis.

Several great resources are available that serve as an excellent introduction to testing and test driven development, such as *Test Driven Development: By Example* and *Pragmatic Unit Testing in Java 8 with JUnit *.

#### Espresso

#### Robolectric

>Robolectric is a unit test framework that de-fangs the Android SDK jar so you can test-drive the development of your Android app.

Robolectric forms the glue between unit testing and the Android SDK. This library makes it possible to efficiently test an application's UI code in isolation from its business logic. Separating UI and business logic is achieved primarily by way of *mocking* out (also known as *faking*) most other code.

This thesis's source code will be tested using Robolectric because it has several major benefits over Espresso:

* Nearly the whole Android SDK can be faked, while providing features those libraries normally would not have such as internal inspection and reflection.
* Excellent support for multi-threaded classes such as AsyncTasks and Handlers. This works wonderfully for testing the return value of functions off the main thread and inspecting them.
* Non-UI code does not need to be tested on an emulator, which can tremendously speed up the test-develop-test cycle.
* Add-ons are available which provide testing support for Google Play Services (among others).
* Activity creation can be mocked out and controlled via an `ActivityController`, with `Fragment` and `View` mocking functioning in a similar manner on an `ActivityController` as well.  

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

Next, a new activity is instantiated (and it's XML inflated) using *setupActivity* and providing that method with a class deriving from *Activity*.

Following that a `Button` and a `TextView` are instantiated from the Activity's associated XML.

Finally, a button click is performed which the test expects to make `results` text say "Robolectric Rocks!"

Besides a single Robolectric-specific Activity instantiation and an assertion at the end, this unit test is exactly the same as any regular Android code.

#### JUnit

JUnit is the standard testing framework for Java.

## Libraries

### Dagger

### RxJava

### Mortar
