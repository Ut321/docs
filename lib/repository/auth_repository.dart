import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gooledocs/models/error_model.dart';
import 'package:gooledocs/models/user_model.dart';
import 'package:http/http.dart';
import 'package:riverpod/riverpod.dart';

import '../constants.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({
    required GoogleSignIn googleSignIn,
  })  : _googleSignIn = googleSignIn,
        _client = Client();

  Future<ErrorModel?> signInWithGoogle() async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occurred', data: null);
    try {
      final user = await _googleSignIn.signIn();

      if (user != null) {
        final userAcc = UserModel(
            email: user.email,
            name: user.displayName!,
            profilePic: user.photoUrl!,
            uid: '',
            token: '');

        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json ; Charset =UTF-8',
            });

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_ id'],
            );
            error = ErrorModel(error: null, data: newUser);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: error.toString(), data: null);
    }
    return error;
  }
}
