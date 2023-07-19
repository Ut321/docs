import 'package:flutter/material.dart';
import 'package:gooledocs/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooledocs/repository/auth_repository.dart';
import 'package:gooledocs/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final eMessanger = ScaffoldMessenger.of(context);

    final navigator = Routemaster.of(context);

    final errorModel =
        await ref.read(authRepositoryProvider).signInWithGoogle();
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);

      navigator.replace('/');
    } else {
      eMessanger.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authRepositoryProvider).signInWithGoogle();
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => signInWithGoogle(ref, context),
          icon: Image.asset(
            'assets/images/g-logo-2.png',
            height: 20,
          ),
          label: const Text(
            "Sign in with Google",
            style: TextStyle(
              color: kBlackColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kWhiteColor,
            maximumSize: const Size(180, 50),
          ),
        ),
      ),
    );
  }
}
