import 'package:flutter/foundation.dart' show kDebugMode; // +
import 'package:flutter/material.dart';
import 'package:meta/meta.dart'; // +

/// {@template promter}
/// Prompter widget
/// {@endtemplate}
class Prompter extends StatefulWidget {
  /// {@macro promter}
  const Prompter({
    required this.child,
    required this.actions,
    super.key,
  });

  final Widget child;
  final Map<String, VoidCallback> actions;

  @override
  State<Prompter> createState() => _PrompterState();
} // Prompter

class _PrompterState = State<Prompter>
    with _PrompterApiMixin, _PrompterBuilderMixin, _PrompterOverlayMixin;

mixin _PrompterApiMixin on State<Prompter> {
  @mustCallSuper
  @visibleForTesting
  @visibleForOverriding
  void show() {} // for further implementation

  @mustCallSuper
  @visibleForTesting
  @visibleForOverriding
  void hide() {} // for further implementation
}

mixin _PrompterBuilderMixin on _PrompterApiMixin {
  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return widget.child;
    return Stack(
      alignment: Alignment.bottomRight,
      fit: StackFit.loose,
      children: <Widget>[
        widget.child,
        Positioned(
          right: 2,
          bottom: 2,
          child: IconButton(
            icon: const Icon(Icons.arrow_drop_down_outlined),
            splashRadius: 12,
            alignment: Alignment.center,
            iconSize: 16,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tight(
              const Size.square(16),
            ),
            onPressed: widget.actions.isEmpty ? null : show,
          ),
        ),
      ],
    );
  }
}

mixin _PrompterOverlayMixin on _PrompterApiMixin {
  // TODO: not implemented
}
