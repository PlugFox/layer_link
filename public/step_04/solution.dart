import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

/// Entry point
void main() => runZonedGuarded<void>(
      () => runApp(const App()),
      (error, stackTrace) => dev.log(
        'A error has occurred',
        stackTrace: stackTrace,
        error: error,
        name: 'main',
        level: 1000,
      ),
    );

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Promter',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Promter'),
          ),
          body: const SafeArea(
            child: SignUpForm(),
          ),
        ),
      );
} // App

/// {@template sign_up_form}
/// SignUpForm widget
/// {@endtemplate}
class SignUpForm extends StatefulWidget {
  /// {@macro sign_up_form}
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
} // SignUpForm

/// State for widget SignUpForm
class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @protected
  void clearAll() {
    _firstNameController.clear();
    _secondNameController.clear();
    _ageController.clear();
    _emailController.clear();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Prompter(
                actions: <String, VoidCallback>{
                  'License page': () => showLicensePage(context: context),
                  'Unfocus': () => FocusScope.of(context).unfocus(),
                  'Clear all': clearAll,
                },
                child: const FlutterLogo(size: 120),
              ),
            ),
          ),
          Transform.rotate(
            angle: math.pi / 32,
            child: SizedBox(
              height: 108,
              child: ListView(
                padding: const EdgeInsets.all(24),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: <Widget>[
                  SizedBox(
                    width: 180,
                    child: Prompter(
                      actions: <String, VoidCallback>{
                        'John': () => _firstNameController.text = 'John',
                      },
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'First name',
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _firstNameController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                  SizedBox(
                    width: 180,
                    child: Prompter(
                      actions: <String, VoidCallback>{
                        'Smith': () => _secondNameController.text = 'Smith',
                        'White': () => _secondNameController.text = 'White',
                      },
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Second name',
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _secondNameController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                  SizedBox(
                    width: 120,
                    child: Prompter(
                      actions: <String, VoidCallback>{
                        '24': () => _ageController.text = '24',
                        '32': () => _ageController.text = '32',
                        '75': () => _ageController.text = '75',
                      },
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          counterText: '',
                        ),
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLines: 1,
                        controller: _ageController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                  SizedBox(
                    width: 240,
                    child: Prompter(
                      actions: <String, VoidCallback>{
                        'a@a.a': () => _emailController.text = 'a@a.a',
                        'a@tld.dev': () => _emailController.text = 'a@tld.dev',
                      },
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'e-Mail',
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      );
} // _SignUpFormState

// --- Helper icon button with overlay implementation --- //

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
  void show() {}

  @mustCallSuper
  @visibleForTesting
  @visibleForOverriding
  void hide() {}
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
  // TODO: unimplemented
}
