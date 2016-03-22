
# Building the Example App

This chapter documents how the example application was developed using various architectures.
Besides a working implementation, experiences and conclusions are
documented so as to provide guidance to developers in choosing a general structure for their application.

Readers are encouraged to follow along and develop a simple application as well.

To reiterate, the application which will be built is a simple API client which:

* Must make a number of network calls (the model)
* Must convert that data into a format suitable for end-users (the controller/presenter/viewmodel/store)
* Must present that data to the user (the view)

On each implementation, a specific library will also be showcased which is both widely-used and vastly simplifies development. This to combat the common way of presenting a design pattern: without using any "helper" libraries, resulting in code that's quite contrived and hard to understand.

Unlike most projects classes were packaged in order to decrease inter-package coupling, an important consideration on its own.[@sandin_four_2016]  Contrast to packaging classes by *Kind*, e.g. placing all Activities in one package.

## MVP using Mortar

    ├── Repositories
    │   └── Blogs.java
    ├── PictureBrowser
    │   ├── PictureBrowserAdapter.java
    │   ├── PictureBrowserPresenter.java
    │   ├── PictureBrowserView.java
    │   └── PictureBrowserActivity.java
    ├── PictureDetail
    │   ├── PictureDetailActivity.java
    │   ├── WallpaperImageView.java
    │   └── PictureDetailPresenter.java

[@_mvp_2014]

### Project setup

First of all, add the Mortar dependency to the application's Gradle file:

    compile 'com.squareup.mortar:mortar:(latest version)'

### Development

**Tip: Read the Docs**. Mortar is a fully fledged library so quite some knowledge about its workings is required in order to use it efficiently.

#### Creating the MortarScope

The MortarScope is a singleton instance in a subclassed application:

    package thesis.madhvani.tk.artbrowser_mvvm

    import android.app.Application;
    import mortar.MortarScope;

    public class ArtApplication extends Application {
      private MortarScope rootScope;

      @Override public Object getSystemService(String name) {
        if (rootScope == null) rootScope = MortarScope.buildRootScope().build("Root");

        return rootScope.hasService(name) ? rootScope.getService(name) : super.getSystemService(name);
      }
    }

This exposes the *Scope service*: an object which can build child scopes. Among other things these objects make it possible to reference Presenters.

#### View and Activity

As previously mentioned, Mortar is based on extending views instead of using fragments as a method of organizing code.

It's important to remember that Mortar is not an absolute requirement for this, it just makes the process far easier.

In order to implement a Mortar compatible View class, some steps must be undertaken:

* Get a reference to the relevant presenter using the MortarScope
* Override some base lifecycle methods Views have, and detach/attach the presenter from it
* Create references to each field in the UI


    public class WallpaperImageView extends RelativeLayout {
      public PictureDetailView(Context context, AttributeSet attrs) {
        super(context, attrs);
        ObjectGraphService.inject(context, this);
      }
    }


Displayed here is the minimum amount of code required to have a working custom view. Unlike most of the Mortar framework, this type of subclassing does not require any external libraries. Even without using any specialized packages custom views are still an important method of encapsulating behavior. Mortar is worthy of using because it enables those custom views to integrate very well in the larger contect of an application and not the other way around.

#### Layout files

Since Mortar uses extends views, the layout becomes very declarative:

    <thesis.madhvani.tk.artbrowser_mvvm.WallpaperImageView
        xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:gravity="center"
        >

      <ImageView
          android:id="@+id/image"
          android:layout_width="match_parent"
          android:layout_height="match_parent"
          android:textSize="25sp"
          android:gravity="center"
          android:text="WTF!?"
          />
      <Button
          android:layout_width="match_parent"
          android:layout_height="match_parent"
          android:text="Rotate me and watch the update count increase."
          android:textSize="18sp"
          android:gravity="center"
          tools:ignore="HardcodedText"
          />
    </thesis.madhvani.tk.artbrowser_mvvm.WallpaperImageView>

The only noticeable difference is the usage of custom views, which will be explained shortly.

#### Presenter

    class PictureDetailPresenter extends ViewPresenter<WallpaperImageView> {
      private final DateFormat format = new SimpleDateFormat();
      private string url;

      public PictureDetailPresenter(String url){
        this.url = url;
      }

      @Override protected void onLoad(Bundle savedInstanceState) {
        getView().setImage(getImage(url));
      }

    }

This is a basic form of a Mortar "ViewPresenter", which for all intents and purposes is just a regular Presenter with a few bells and whistles.
What is very pleasing about using Mortar is that Presenters can be used very cleanly, i.e. without much programmer interaction needed in order to fetch and save state. But although the library's features allow for very smooth development, some overhead is still associated with using it. In some cases this can be safely ignored and in other, bigger applications, a custom MVP implementation might be needed. **Always consider the specific needs of every individual project.**

#### Saving state in the presenter

Without Mortar's wrappings, the question will come on how to save a presenter into an activity. A simple solution is presented here which can easily be modified.

Simply saving a presenter's state in a `Map<id, singleton>` will suffice in most cases. This makes it possible to fetch any existing presenter during the `onCreate` call. This is essentially also what Nucleus does, another helper library for using MVP on Android.

### Conclusion

## MVVM using the Data Binding library

    ├── Repositories
    │   └── Blogs.java
    ├── PictureBrowser
    │   ├── PictureBrowserAdapter.java
    │   ├── PictureBrowserViewModel.java
    │   └── PictureBrowserActivity.java
    ├── PictureDetail
    │   ├── PictureDetailActivity.java
    │   └── PictureDetailModel.java

### Project setup

As the Data Binding Library recently had its first stable version released, it can safely be used without having to worry about too many unexpected glitches.
Another thing to point out is that it's a support library, meaning all versions of Android after API level 7+ support it.

The only requirement on the developer's side is that a relatively recent version of Android Studio is needed (1.3+) in order to have syntax highlighting and an error catching.

First, enable the library by pasting the following code into an application's Gradle file:

    android {
        dataBinding {
            enabled = true
        }
    }

### Development: Understanding Data Binding

##### View

First, the view will be examined.  The Data Binding Library is best understood by looking at a real world example.

    <?xml version="1.0" encoding="utf-8"?>
    <layout xmlns:android="http://schemas.android.com/apk/res/android">
        <data>
          <variable name="image" type="thesis.madhvani.tk.artbrowser_mvvm.picture.PictureViewModel"/>
          <import type="android.view.View"/>
        </data>
        <RelativeLayout
            xmlns:android="http://schemas.android.com/apk/res/android"
            xmlns:tools="http://schemas.android.com/tools"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            tools:context="thesis.madhvani.tk.artbrowser_mvvm.PictureDetailActivity">

            <ProgressBar
              android:layout_width="match_parent"
              android:layout_height="match_parent"
              android:visibility="@{image.isLoaded ? View.GONE : View.VISIBLE}"/>

            <thesis.madhvani.tk.artbrowser_mvvm.TargetedImageView
                app:imageSource="@{image.url}"
                android:visibility="@{image.isLoaded ? View.VISIBLE : View.GONE}
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:layout_alignParentTop="true"
                android:layout_alignParentStart="true"
                android:layout_alignParentBottom="true"
                android:layout_alignParentEnd="true"/>

            <TextView android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="@{image.caption}"/>

        </RelativeLayout>
    </layout>

Without attention this XML file could be mistaken for any regular RelativeLayout. There are however some crucial differences:

First of all, the XMl is wrapped inside a `<layout>` tag and some metadata is present in the file:

* `Data`: this is a special XML tag in which models and imported classes need to be declared. In the example application, a `PictureViewModel` has been set as the main view model (more on the view model later). An import, namely `<import type="android.view.View"/>` is also declared. This makes it possible to easily reference classes inside the view.

The actual UI markup also has some special characteristics:

* `android:text="@{image.caption}"`: developers who have previous experience with templating languages such as Razor or Mustache will be instantly understand what this statement means. It simply sets the text value to a String fetched from the model.

* `app:imageSource="@{image.url}"`: this statement makes a references to a *BindingAdapter*, a custom method inside `PictureViewModel` code that essentially makes it possible to get a reference to the `View` widget that calls it. In this case, the "callback" is used to set a `BitmapImage` loaded from an API. Note that the custom `View` object `thesis.madhvani.tk.artbrowser_mvvm.TargetedImageView` is not necessary in order to use a `BindingAdapter`, this is related to image caching and can be ignored.

* `android:visibility="@{image.isLoaded ? View.VISIBLE : View.GONE}`: the library also has support for arbitrary expressions as shown here. Without any code-behind, a progress bar can be shown as the image is loading and removed as soon as it the image is available.

The best part about understanding Android's Data Binding Library and how it relates to views is that as a consequence the essence of a view in MVVM on Android also becomes clear: simple, easy to understand XML files which will eagerly accept and display any data handed to them.[@_data_binding]

![Despite little overdraw, a performance hit was noticeable](http://i.imgur.com/T6IvLyN.png)

##### ViewModel and Activity Initialization

On Android, delegating all responsibility to the ViewModel would be very impractical since an Activity object is responsible for holding on to state, the initial inflation of the interface and a number of other administrative tasks such as handling rotations.

    @Override
    protected void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       PictureDetailActivityBinding binding = DataBindingUtil.setContentView(this, R.layout.picture_detail_view);
       PictureViewModel picture = new PictureViewModel("http://i.imgur.com/wUuwrjy.jpg", "The cat of our vet...", "Saturnix, Reddit");
       binding.setImage(picture);
    }

Note that some code has been left out of this example (such as fetching a Picture object from an `Intent`) for clarity.

Possibly the most perplexing statement in this onCreate method is the one that defines the binding. `PictureDetailActivityBinding` is actually just the name of the Activity set in PascalCase and appended with "Binding". This class is automatically generated when an XML file that uses databinding is built.[@_data_binding]

Afterwards the `Image` variable declared in the View is simply instantiated.

    public final class PictureViewModel extends BaseObservable {

        private Image image;
         public ObservableBoolean isLoaded = new ObservableBoolean(false);

        public PictureViewModel(String url, String caption, String author) {
            this.image = new Image(url, caption, author)
        }

        public PictureViewModel(Image image) {
            this.image = image;
        }

        public String getUrl() {
          return image.getUrl();
        }

        public String getCaption() {
          return image.getAuthor() + ": " + image.getCaption();
        }

        @BindingAdapter({"bind:imageSource"})
        public static void loadImage(ImageView view, String url) {
            image.loadBitmapImage(url)
            //setImageBitmap would normally happen in a callback once loadBitmapImage is done
            view.setImageBitmap(image.getBitmapImage());
            isLoaded.set(true);
        }

    }

* `BaseObservable` is a *convenience* class that implements an Obverser pattern, allowing the viewmodel to notify the view of any changes.

* An Obversable boolean `isLoaded` is set to `true` when the bitmap is loaded. Upon the value changing, the view will be notified and turn off the Progress View.

* The `@BindingAdapter` annotation on `loadImage` tells Android that this method is responsible for answering any calls on a custom attribute (in this case, imageSource). The View is passed in and the image is set accordingly. Besides being an easy way to set values for which there is no XML equivalent, it also encapsulates view/viewmodel communication in a well defined space.

* Special attention should be paid to `getCaption()`: a field call from the model not available from the view is called (`getAuthor()`), decreasing the knowledge the view has which keeps it "dumb" as intended.

![Image caching logic is shared by using the same viewmodel, only the view is different here](http://i.imgur.com/qgpl725.png)

### Conclusion

Because of the Data Binding Library, implementing an MVVM system was quite easy. Its event driven nature fits in perfectly with the pattern.

Another important finding was that, even though the library is fairly new, in terms of stability there were no major issues. It can therefore be safely recommended.

One major advice is that performance sensitive UI should be inspected to make sure the performance decrease is still acceptable. Frame skipping was especially noticeable when loading a big collection-based view such as a `RecyclerView`.

This is despite Google's best efforst at ensuring smooth performance. As it is, the library uses no runtime reflection at all: every view reference is predetermined at compile time. Also, since there is certainty about which variables a view wants access to at compile time optimizations can be made that make data access less expensive.

Just as the pattern promises, the viewmodels proved to be quite easy to reuse in different environments. An excellent example of this is the PictureViewModel being used on its own in the `PictureDetailActivity` and as a single item of a larger collection in the `PictureBrowserActivity`.

Besides performance, MVVM turned out to have a high degree of *developer happiness*. The least amount of code possible is spent on tasks such as referencing views or patching viewmodels to make them compatible with multiple activities.[@_what_]

In conclusion, the MVVM pattern is easy to implement and fits the Android model of code very well. Its encapsulation of data in viewmodels and the high degree of decoupling between all components made rapidly creating an application a pleasant experience.

## Flux using EventBus

    ├── Actions
    │   ├── CurrentBlogChanged.java
    │   └── PictureStoreChangedEvent.java
    ├── PictureBrowser
    │   ├── PictureBrowserAdapter.java
    │   └── PictureBrowserView.java
    ├── PictureDetail
    │   └── PictureDetailView.java
    └── Stores
        └── PictureStore.java


### Project setup

Add EventBus and RxJava to the project's Gradle file:

    compile 'org.greenrobot:eventbus:3.0.0'

    compile 'io.reactivex:rxjava:recent-version'


### Development

#### Setting up stores

Stores are responsible for registering themselves with the dispatcher. Using events, an observer pattern will be used that automatically reacts to dispatched actions.

    public class PictureStoreChangedEvent { }

Stores must also be initialized of course. A choice was made to simply create a collection of singletons and initialize them in a subclassed Application. This is maintainable up to a point but as the amount of stores grows they should be created using a dependency injection library such as Dagger2.

How stores actually maintain and update information is highly dependent on application specifics. It would be entirely acceptable to update something in a file, fetch data from the internet and write to an SQL database in the exact same store. This is what Flux's creators mean by maintaining a *domain of information*. What the concrete data looks like doesn't matter.

Activities and Fragments then listen to stores changes by registering to a store event.

    @Subscribe
    public void onPictureStoreChanged(PictureStoreChangedEvent event){
        catPictures = pictureStore.getCatPictures();
        //The "view" decides on its own how it responds to changes
    }

Subscribers must also register themselves to the `EventBus`. As per the developers of EventBus, this should happen in the `onStart` and `onStop` events of Android lifecycle classes.

    @Override
    public void onStart() {
        super.onStart();
        EventBus.getDefault().register(this);
    }

    @Override
    public void onStop() {
       EventBus.getDefault().unregister(this);
        super.onStop();
    }

![Thinking in React: high level Store/View communication flow (dispatcher not pictures)](http://i.imgur.com/bx0nFRG.png)

#### Setting up actions

Actions are a collection of events that send new state and data to the central dispatcher.

    public class CurrentBlogChanged {

      public final String message;

      public CurrentBlogChanged(String message) {
          this.message = message;
      }
    }

This event is then dispatched to any store that is interested in this type.

    @Subscribe
    public void handleBlogChange(CurrentBlogChanged event){
        getPictures(event.message);
        // ... And it sends out a PictureStoreChangedEvent
        // when it has fetched to notify any listeners
        EventBus.getDefault().post(new PictureStoreChangedEvent());
    }

![Flux's flow in practice](http://i.imgur.com/n9d80Fe.png)

#### Deciding which type of view should be used

Flux expects view to be highly *reactive*. As a matter of fact, Flux was made with the JavaScript React.js framework in mind. How React.js functions will not be discussed here but suffice to say it should be thought of as databinding on steroids.[@_facebook_infoq]

A solid recommendation would therefore be to implement the Data Binding Library here as well, with `Observable<T>` fields used for maintaining state.

### Conclusion

Implementing Flux was relatively painless. Most friction came from the fact that it's a completely foreign and unexplored environment for the framework, so pre-existing information was close to zero.

Another point is that Flux did not really shine that much considering the application flow was quite simple and easy to handle. Whereas *one* store was used and only a few actions, Flux is intended to be used with *many* stores, actions and views.  However, what little state there was to maintain, Flux took care of without any issues.

The reactive nature of Flux and RxJava's flow control could potentially form a great combination. This is left as an exercise for the reader.

Consider an activity which contains many custom View elements, each having their own Flux View: each component would be responsible for its own state and communicating any requested changes. Thinking in Flux could then provide huge benefits as no coupling would exist between those solitary views. A possible follow-up project could be creating a more complex application to test Flux to its true limits.

Medium to large applications, which have lots of user interaction and state that needs to instantly update, could definitely benefit from using this pattern.
