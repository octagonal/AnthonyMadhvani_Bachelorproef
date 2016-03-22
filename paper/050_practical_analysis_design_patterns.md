
# Concluding Analysis of Patterns

Having developed the application, the various architectures will now be examined one by one according to a number of quality indicators. In conclusion, advice will be handed out for deciding which architecture would best fit a project.

## Resource usage

### MVP

MVP performance was expectedly great, it has a lot of developer support from the community so most edge cases have a drop-in solution ready. As a result of this community backing, MVP would be a great choice when performance is an important issue.

### MVVM

MVVM performance tends to vary wildly between how it's applied. RecyclerViews took a small hit but other, more static views actually faired better.

### Flux

Flux's resource usage is mostly dependent on its use of an event bus and how that event bus interops with Android. In limited testing, performance was acceptable. The question remains wether this would still be the case in larger codebases.

## Android lifecycle management

### MVP and MVVM

Both patterns use a structure that require lifecycle classes to dispatch their events to an intermediary class, be it a viewmodel or presenter. This mismatch between the Android framework and the architectural pattern can be solved by way of some indirection (retrieving the object during `onCreate` by storing it in a `map` beforehand or using Mortar's BindingScope for example). So while the lifecycle can be managed, it requires extra work.

### Flux

Using the Flux architecture, Activities and Fragments still have full authority over how the lifecycle is manipulated. This one to one mapping with the standard way of development means the lifecycle can be managed very well in Flux.

## Testability and Debugging

### When using a well-defined architecture

Every architecture mentioned so far had testing in mind when it was developed. This means that UI, business logic and models can be tested independently from each other which results in pure tests that do not need to consider other components.

A possible edge case does exist for Flux: its high degree of decoupling might make it difficult to trace program execution for debugging.[@c._martin_confreaks_]

### When not

By not using a structure, a developer creates an environment in which testing will become messy fast.

This is better known as the "spaghetti code" antipattern.[@_design_spaghetti]

Take for example a Fragment that also includes a method for making API calls: it would be near impossible to test the network call in isolation since it will be coupled to the Fragment's context and lifecycle.

Because of this it is strongly discouraged to develop applications in an ad-hoc way or with strong coupling between separate functionality.

## Decoupling

### MVP

While MVP is a step up from MVC, view-presenter coupling is still quite severe since there should nominally be a one-on-one mapping between view and presenter. This is unfortunate in an environment such as Android where a view and its functionality might have to be reused many times over in slightly different contexts.[@richards_software_]

### MVVM

MVVM is quite a lot more decoupled from the View than its MVP counterpart. This is a result from the philosophy behind MVVM that says views should simply accept and display information. Because of this, MVVM feels like a more natural fit for Android than MVP. Although this might sound controversial considering the amount of traction behind MVP, MVVM deserves at least an equal amount of attention.

### Flux

Flux is entirely decoupled because all inter-component communication happens through an event-based system. A component does not have any knowledge about other components at all. The only coupling present is between a Store and a View: the view must know how to retrieve data from the store. By using a well thought-out interface this would be solved as well, however.

## Verbosity

As was expected, all patterns came attached with extraneous boilerplate code. This is mostly because of Android's old Java version and its shortcomings as a language. Luckily improvement is on the way: at the most recent Google Developer Conference an announcement was made that many Java 8 features would be ported to Android's Jack compiler, including but not limited to: lambdas, streams and functional interfaces.[@_marshmallow_]

## Overview

Architecture  | Performance | Lifecycle management | Testability | Decoupling | Verbosity
--|--|--|--|--|--
MVP Pattern  | Great | Acceptable | Acceptable | Quite poor | Quite poor
MVVM Pattern | Acceptable | Acceptable | Great | Great| Quite poor
Flux Pattern | Great | Great | Acceptable | Great| Quite poor
