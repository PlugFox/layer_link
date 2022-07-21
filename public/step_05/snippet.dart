import 'package:flutter/material.dart';

class _PromterLayout extends StatelessWidget {
  const _PromterLayout({
    required this.actions,
    required this.hide,
  });

  final Map<String, VoidCallback> actions;
  final VoidCallback hide;

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        child: Row(
          children: <Widget>[
            for (final action in actions.entries)
              Padding(
                padding: const EdgeInsets.all(2),
                child: ActionChip(
                  label: Text(action.key),
                  onPressed: action.value,
                ),
              ),
            const VerticalDivider(width: 4),
            IconButton(
              icon: const Icon(Icons.close),
              splashRadius: 12,
              alignment: Alignment.center,
              iconSize: 16,
              padding: const EdgeInsets.all(4),
              constraints: BoxConstraints.tight(
                const Size.square(24),
              ),
              onPressed: hide,
            ),
          ],
        ),
      );
}
