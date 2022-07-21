# Step 6 - Overlay and tracking logic

Looks good. But now we need to write down the implementation for our helper inside `_PrompterOverlayMixin`.

After all, we can show an [OverlayEntry](https://api.flutter.dev/flutter/widgets/OverlayEntry-class.html) with [CompositedTransformFollower](https://api.flutter.dev/flutter/widgets/CompositedTransformFollower-class.html) that will track and follow its target [CompositedTransformTarget](https://api.flutter.dev/flutter/widgets/CompositedTransformTarget-class.html) using a [LayerLink](https://api.flutter.dev/flutter/rendering/LayerLink-class.html).
