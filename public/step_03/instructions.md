# Step 3 - Placeholder for our Prompter

Now, when we have a few text input fields, it isn't fascinating to fill them every time. Creating a new widget to help us fill them with stub data is a good idea.

Our new helper widget-wrapper contains the following API and overlay button, which will display an overlay with hints.

Add a stateful widget and three mixins for the state.

- `_PrompterApiMixin` - our state API, with a `show` and `hide` methods
- `_PrompterBuilderMixin` - mixin contains the `build` method
- `_PrompterOverlayMixin` - mixin for logic, responsible for overlay and tracking with position synchronization between two layers.

Create widget, state, and implement first two mixins.
