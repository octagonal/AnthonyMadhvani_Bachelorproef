
# Conclusion

Choosing the correct architecture can be a daunting task. It's obvious that each individual architecture has its own strenghts and weaknesses by which a choice can be made. Applications that need to be highly reactive would benefit from Flux for example, and apps in which a lot of similar information is displayed throughout would be served well by an MVVM structure. Or perhaps when working in a larger team MVP would be the superior choice since it would allow for very fine-grained control of every individual layout.

Adding to this complexity are the respective adoption rates: MVP is becoming established as the go-to methodology for developing Android applications. This monoculture can be problematic when MVP is simply not a good fit.

Besides all this, the case still remains that *any* choice is better than ad-hoc, spaghetti code. Perhaps the most difficult part of these patterns are not their implementation but encouraging and convincing others of their usefulness. Hopefully this thesis will help with that.

However, that is not to say this form of programming doesn't have its rightful place: unstructured code is excellent for quickly making prototypes which need to serve as a proof of concept.

Profiling also proved essential to figuring out performance problems. It would be nearly impossible to find the source of bad performance when dealing with even moderately complex code without the profiling tools (a perfect example would be the data binding library's issues with instantiation).

It is also necessary to remember that architectural design patterns are not a magic bullet. And neither are they a one-size fits all solution to every app's specific problem domain. Dogmatically sticking to a certain methodology could turn out to be extremely harmful in the long term. Sometimes the overhead is just not worth it.

# Personal Conclusion

This was a very worthwhile project for me to finish because I had always been interested in how to deeply reason about the structure of code. It is my sincere hope that this thesis will not only serve as my final accomplishment at HoWest but a reference which others may consult every so often.

Although this thesis was not directly coupled to my internship (coupling is an antipattern, anyway...) I was still able to use this research into my daily tasks. This is because these pattern transcend specific programming environments and their knowledge is useful in a great variety of situations. This universality made it very rewarding to translate it directly into a specific framework.

The fact that Android is reasonably unexplored in this area was also a big motivator for me because my contribution will perhaps be able to shape how Android Development evolves in a small way.

Even if this turns out to be wishful thinking, I personally still learned a great deal about the internals of Android and computational models on mobile devices in general. Some tools which I had previously not considered, such as the memory tracer, have unexpectedly become personal favorites.

My one regret about this thesis is that due to time contraints I wasn't able to test these patterns in a more extensive case study.

However in conclusion I still believe that a lot of problem areas remain unexplored, such as how to handle fragmentation and the differences in performance it brings along.
