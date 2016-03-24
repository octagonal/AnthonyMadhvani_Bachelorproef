
# Overview of Several Common Patterns

This chapter will take a deep dive into various common architectural patterns and a high level view of their implementation in Android.

Throughout this chapter, it is important to keep in mind that design patterns are not rigorously defined frameworks. This is in contrast to what most students are taught, leading to misunderstandings where for example MVC is considered nothing more than a concrete ASP technology.

Rather, architectural patterns are a way of *structuring and organizing code*. This becomes all the more obvious when trying to convert those conventions into functioning code.

## Diagram conventions

![(Fig, 14.1) Conventions](http://i.imgur.com/RSznqSx.png)

a) A dependency indicates that one component *depends* on the other to provide it with data.

b) A component is an object or a set of objects that form a coherent whole. It is considered a black box with a simple input/output mechanism.

c) A leader message happens when one component can request changes to another component.

d) A peer message happens when two components are dependent on each other. A *unidirectional* flow of state is possible under this relationship.

* Sometimes a light background color will be used on a component to visualize how it is not equally important to the other components.

* I*Classname* signifies an interface.

## MVC

*Model, view controller.*

* **Will not be implemented due to extremely low traction**

### Theory

MVC is by far the most common architecture. It is used by nearly every web framework and was first developed in the 1970's for Smalltalk, an early object-oriented programming language. Even though MVC was originally developed for usage *in the small* (where every piece of a view would have a separate controller and model), it is currently used for controlling the structure of entire views.[@c._martin_confreaks_]

The general philosophy behind MVC is that the model (data), view (displaying) and the controller (routing between data and view) should be separated because they concern themselves with different responsibilities.

However under MVC components are quite linked. An interaction with the controller will make the model, providing data, communicate with the view. Because of this a requirement change for the view would require changes to the model as well. This becomes problematic when several views have to use the same model. While MVC was a big improvement on previous attempts, the coupling caused by it is quite severe.

That is not to say MVC is a useless abstraction model. It lends itself quite well to the web's model of communication for example or smaller applications where such coupling is not considered an issue. [@_techniques_fault_tolerance,]

![(Fig, 15.1) MVC](http://i.imgur.com/EDB1Vpo.png)

### Implementation in Android

As was previously explained, the entry point in MVC is the controller and not the view. One some platforms like the web this is excellent, since all HTTP requests are handled by the server (the controller) before being displayed in the browser (the view). The mapping from theory to implementation is less straightforward in Android however: the entry point is an Intent which points to an activity (the view).

This makes it necessary to create workarounds or not follow along with the pattern too closely or use a very loose interpretation of what consitutes MVC.

![(Fig, 16.1) MVC Implementation](http://i.imgur.com/A48s57B.png)

## MVP

*Model, view, presenter.*

* **Will be implemented**

### Theory

Invented in the early 1990's, when software companies were seeing a huge increase in the complexity and required responsiveness of views. Besides increasingly complex interfaces, views had to adapt much faster to business requirements as well. The invention of MVP was one that arose out of a need to further decouple a data source from the view even further.[@richards_software_]

MVP is essentially a variation on MVC using a different control flow. However, a big improvement on MVC is that under MVP the view has absolutely no knowledge of the model. This is what *presenter* takes care of: this component prepares data from the model for the view. While this seems like a small difference, the separation between view and model ensures that no dependencies can arise between them. This in itself is an important improvement that increases decoupling.

Unlike MVC, the entry point is the presenter. The view and the presenter have a one-on-one mapping which means they both share knowledge of each other. [@_mvp_2014]

![(Fig, 16.2) MVP](http://i.imgur.com/t1LFdlO.png)

### Implementation in Android

Using MVP, it is possible to strictly obey the pattern guidelines since user interaction originates with the view. It should also be noted that because views and presenters have a one-on-one mapping, using interfaces is not immediately required.

![(Fig, 17.1) MVP Implementation](http://i.imgur.com/PtXai2Z.png)

## MVVM

*Model, viewmodel, view.*

* **Will be implemented**

### Theory

MVVM was originally developed by Microsoft in order to benefit from WPF's event driven architecture. However, on the Android platform it is possible to work with events and *observers* as well. The viewmodel is often called a *value converter* because it prepares the data from the model for the view. By using an event-based system, the viewmodel can send changes to the view (which *observes* the viewmodel's properties). However, the viewmodel should have no knowledge of the view. This has a number of important ramifications, most of all that *databinding* becomes a necessity.

Databinding synchronizes an observer with a subject by sending evented commands. These events ensure that the view and the viewmodel have exactly the same state.

When using MVVM, the entry point is the view.

Model-view-viewmodel is perhaps the most careful in terms of component communication. Unlike MVP, the view is kept as *dumb* as possible, only displaying the information that the viewmodel provides.

What this means is that unlike MVP, a viewmodel could potentially be shared with many views. This strict separation allows for a very decoupled architecture. Contrast this with a view-presenter relationship where the view is still responsible for manipulating information and state.[@mvvm]

![(18.1) MVVM](http://i.imgur.com/xWkLIte.png)

### Implementation in Android

Similar to MVP, the MVVM patterns fits quite well into Android. Of interest is also that a databinding library was recently introduced to Android which makes it much easier to use MVVM. Another important fact to note is that the Activity itself becomes nothing more than a connector to the layout resource file and the object which holds on to the Android lifecycle.

![(Fig, 18.2) MVVM Implementation](http://i.imgur.com/fwVX3cm.png)

## Flux

*Action, dispatcher, store, view*

* **Will be implemented**

### Theory

Flux is without a doubt the newest kid on the block. It has been gaining a lot of steam as of late because it greatly simplifies how front-end code is developed in the browser. Even though Java and JavaScript can seem worlds apart, as Flux is simply a design pattern there is no valid reason not to test and validate it.

Unique to Flux, a *unidirectional* flow of data is maintained and strictly enforced not just between select components but for every component. According to the creators of Flux, this makes it far easier to reason about code structure and how data is passed around.

Flux was developed for a reason which might seem like heresy to some: any reasonably complex application built using traditional architectural patterns proved hard to maintain and extend. This problem became quite evident for Facebook when they wanted to create *instantly updated* and *highly reactive* interfaces.[@flux]

The pattern consist out of a few simple components:

* Dispatcher: Sends out messages when a new *action* has been received. Only one of these exists to manage a whole application

For all intents and purposes, a dispatcher is similar to a real life call dispatch: a place where customers' calls (actions) are answered, setting in motion a change that handles whatever must occur in order to handle those calls (a store).

* Stores: Manage a *domain* of state and logic

Whereas a traditional model might be responsible for a
a single data object, returning it to whatever requests it, a store is the owner of a spectrum of a collection of objects.

To give an example: a *CatModel* would have a *getCat(int id)* method returning a single `cat` and a *CatStore* would have a *CatsUpdatedCallback* method which returns those cats to whichever listener is *registered* to it.[@flux]

* Views: Render the current application state, which is handed down from the stores

* Actions: Views send out updates and request using Actions to the centrail dispatcher

![(Fig, 19.1) Flux](http://i.imgur.com/ET5qI3J.png)

#### Implementation in Android

Despite its apparent complexity, Flux can easily be implemented in Android.


* Activities and their respective XML UI can be considered a single view component, where the Activity is set to listen to store changes and the XML is responsible for reactively responding to changes in a local *store represenation*.
* An event bus can serve as a simple dispatcher
* Stores are pure Java classes which independently decide how to parse actions and change data caches accordingly
* Actions in this interpretation are simply new events dispatched to the store

![(Fig, 20.1) Flux Implementation](http://i.imgur.com/qWsAex6.png)

*Note: unlike other flowcharts in this chapter, some details such as interfaces have been left out for clarity.*
