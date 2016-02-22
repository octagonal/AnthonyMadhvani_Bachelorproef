
# Basic Design Pattern Knowledge

## Building Blocks

Even though non-architectural design patterns are not the focus here, it is still nessecary to know a couple of basic patterns in order to be able to implement any architecture.
They will be briefly explained here in a practical way.

### The Observer Pattern

The observer pattern is at the basis of many common architectures. In fact, it is so common that many languages
have it included in their standard library (such as Java's Obverser class [@nystrom_design, chap. II.6] ).

It can be thought of as a way to connect objects that want to be informed about the state of another object in a modular way. It will usually consist of an `observer` and a `subject`. It has a one to many relationship, since a given `subject` can have many `observers`.

The `subject` will have a method available to notify its observers and the observers will have a method available to subscribe to the events that the `subject` publishes.

Say for example, an object called `Weather` exists that notifies anyone listening about changes in temperature. A `Weatherman` object would then subscribe to `Weather` in order to react to changes in weather.

[TODO: CODE VOORBEELD]

Communication in this way allows for a high degree of decoupling while still providing certainty about being notified.

### The Mediator Pattern
 
The mediator pattern is another pattern whose main benefit is increased decoupling of application components. Using this pattern, a level of indirection is created such that objects do not communicate directly with each other.

A `mediator` will have one or more `components` that need to be informed about changes to any other `component` whenever one `component` sends a message. Where the observer pattern will have a *one to many* relation, the mediator pattern will have a *one to one to many* relation. Another big difference between the two is that by using the observer pattern, direct communication between objects still exists. Using a mediator, the become unlinked.

[TODO: CODE VOORBEELD]

Also note that the usefulness of the observer pattern can already be demonstrated here: using an observer, a mediator could notify all of its components about an event from any other component using a standard and easy to implement interface. 

### The Command Pattern

The command pattern encapsulates methods using an object in order to provide a standard way to handle events and data. Implementation wise a `Command` class will have a method `execute`. 


    class ICommand
        void execute()

One of the biggest benefit is being able to queue a list of commands and letting another object execute them one by one. It would for example be possible to place a series of various network calls (loading images, loading HTML) in a list, and letting the object that receives those commands choose wether or not to request them one by one or in parallel.

    class Command extends ICommand
      public Command(Sum sum, int one, int two)
        
      void execute(){
        sum.add(one, two)    
      }
        

Since all commands are sent using the same type of class, it would be trivial to for example implement an `undo` method as well. 
  
    class Command extends ICommand
      public Command(int total, int one, int two)
        
      void execute(){
        previousValue = total
        total = one + two)    
      }
      
      void undo(){
        total = previousValue
      }

# Overview of several common patterns

## MVVM

### Theory

### Implementation in Android

## MVP

### Theory

### Implementation in Android

## MVC

### Theory

### Implementation in Android
