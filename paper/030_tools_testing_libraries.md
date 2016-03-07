
# Tools, Testing and Libraries

Before developing the application, a number of important tools and popular libraries will be reviewed.
Deciding if and when a certain library should be used can have a major impact on an application. [@Extensibility]
Not only does the developer have to depend on the library's maintainer to keep it up to date, without careful attention to implementation the risk of vendor lock-in becomes significant.

Android's great selection of profiling tools on the other hand, is often considered as something to use only as a last resort. Proof will be presented here that shows how invaluable they are.

## Tools

### The Performance Profiling Tools

#### GPU and Memory Performance

#### Layout Hierarchy Inspection

#### Testing Battery Usage

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
* Non UI code need not be tested on an emulator, which can tremendously speed up the test-code-test cycle.
* Add-ons are available which provide testing support for Google Play Services (among others).
* Activity creation can be mocked out and controlled via an `ActivityController`, with `Fragment` and `View` mocking functioning in a similar manner on an `ActivityController`.  

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

Following that a `Button` and a `TextView` are then instantiated from the Acitvity's associated XML.

Finally, a button click is performed wh

#### JUnit

JUnit is the standard testing framework for Java.

## Libraries

### Dagger

### RxJava

### Mortar
