# Layer link

[WORKSHOP](https://dartpad.dev/workshops.html?webserver=https://raw.githubusercontent.com/PlugFox/layer_link/master/public)

Let's imagine you need to attach an overlay to a particular widget.  
The problem of drawing overlay entries at a specific coordinate doesn't look too hard. But it does. A particular layout can handle scrolling, transformation, repositioning, and other layout mutation.

In other words, you should get an overlay entry following the widget and link two layers.

And here, two widgets in Flutter come to our aid. They are helping to connect the main view with overlay: [CompositedTransformTarget](https://api.flutter.dev/flutter/widgets/CompositedTransformTarget-class.html) and [CompositedTransformFollower](https://api.flutter.dev/flutter/widgets/CompositedTransformFollower-class.html).

In this article, I will demonstrate their use by creating a widget wrapper to help self-test your code and automate some actions when the application runs in debug mode.
