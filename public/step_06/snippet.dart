mixin _PrompterOverlayMixin on _PrompterApiMixin {
  /// Object connecting [CompositedTransformTarget]
  /// and [CompositedTransformFollower].
  final LayerLink _layerLink = LayerLink();

  /// Current overlay entry, if it exists.
  OverlayEntry? _overlayEntry;

  @override
  void show() {
    super.show();
    hide();
    // Show overlay and set new _overlayEntry
    Overlay.of(context)?.insert(
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          height: 48,
          // Wrap [CompositedTransformFollower] to allow our overlay
          // entry track and follow parent [CompositedTransformTarget]
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(-2, 4),
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            showWhenUnlinked: false,
            child: _PromterLayout(
              actions: widget.actions,
              hide: hide,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hide() {
    super.hide();
    if (_overlayEntry == null) return;
    // Remove current overlay entry if it exists.
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>

      /// Wrap your widget inside [CompositedTransformTarget]
      /// for tracking capabilities
      CompositedTransformTarget(
        link: _layerLink,
        child: super.build(context),
      );
}
