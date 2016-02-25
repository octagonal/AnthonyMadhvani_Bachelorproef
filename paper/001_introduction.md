
# Introduction

Architectural patterns can oftentimes be difficult to grasp. They are clearly defined in numerous books, yet the knowledge and experience required to effectively apply them (and in the right places) can take many years to attain. A deep technical understanding of the software stack is required and at the same time the programmer must be able to visualize the code structure as a whole in order to predict and understand how it must be organized. 

The gap between how easy it is to explain them and how difficult it is to apply them is not easily bridged. 

This is especially true for new platforms such as Android. Yes, Android was first released seven years ago. Even though Android is not new in terms of how when it was first published, it could be considered very new indeed in terms of large codebases needing careful attention and maintenance -and most of all applications where rapid improvement and extension is the name of the game. Right now, innovation and a new sense of urgency is emerging about this in the Android development community. 

Databinding, functional reactive programming, stores and dispatchers: an Android developer could be forgiven for not immediately knowing what any of those terms mean simply because they are so new to the community. If design patterns try to describe a way to organize code in the small, architectural patterns define code structure in the large. Their purpose is contrasted by the scope of their application. Structuring Android Applications is only concerned with the latter (yet some attention has been given to basic design patterns).

Technically, this thesis is about figuring out how to implement architectural design patterns on the Android framework. But it's real purpose is being able to match the stringent requirements put upon development teams and their applications with the right set of tools and abstractions. 

## Thesis Outline

This thesis is divided into two major parts. 

The first part is preparatory and describes several design patterns and how they are applied in Android. This part also dedicates a chapter to the importance of correct tool and library usage.

* Chapter 1 (*Basic Design Pattern Knowledge*) describes several common design patterns that are involved in creating architectural patterns and application architecture in general.

* Chapter 2 (*Overview of Several Common Patterns*) gives the reader an introduction to architectural patterns and how they are applied in Android.

* Chapter 3 (*Tools, Testing and Libraries*) is a brief introduction into tools, testing and library usage.

* Chapter 4 (*The Example App*) lays out the reasoning behind the requirements of the example application and how quality measurement will be done.

Part two concerns itself with the implementation of the example application.

* Chapter 5 (*Building the Example App*) documents how the application was made and which considerations and problems arose while developing it.

* Chapter 6 (*Practical Analysis of Design Patterns*) will compare the various architectures that were implemented.
