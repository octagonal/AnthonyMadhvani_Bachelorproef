
# Abstract

"Structuring Android Applications" entails specifically the usage of architectural design patterns for the purposes of creating decoupled, well-structured, stable and extendible software for the Android platform.

## In short

An analysis is made of several architectural design patterns and how they are implemented on Android. Ultimately the conclusion is made that the recently developed "Flux" framework by Facebook is a suitable candidate for many common issues faced in developing for mobile devices. Despite its lack of community support it can readily be implemented using only a few basic libraries.

Besides this unlikely option, a point is made that MVVM can also be an excellent solution now that the Data Binding Library has had its first stable version released. Especially so for applications which share much common logic between views with only slightly differing layouts.

Lastly, after analysis the conclusion is made that MVP is best suited for larger teams who require very fine grained control of every specific part of an application.

## Thesis Outline

This thesis is divided into two major parts.

The first part is preparatory and describes several design patterns and how they are applied in Android. This part also dedicates a chapter to the importance of correct tooling and library usage.

* Chapter 1 (*Basic Design Pattern Knowledge*) describes several common design patterns that are involved in creating architectural patterns and application architecture in general.

* Chapter 2 (*Overview of Several Common Patterns*) gives the reader an introduction to architectural patterns and how they are applied in Android.

* Chapter 3 (*Tools, Testing and Libraries*) is a brief introduction into tools, testing and library usage.

* Chapter 4 (*The Example App*) lays out the reasoning behind the requirements of the example application and how quality measurement will be done.

Part two concerns itself with the implementation of the example application.

* Chapter 5 (*Building the Example App*) documents how the application is made and which considerations and problems arose while developing it.

* Chapter 6 (*Practical Analysis of Design Patterns*) will compare the various architectures that are implemented.
