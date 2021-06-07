import 'package:flutter/material.dart';
import 'package:medi_vault/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;
}
