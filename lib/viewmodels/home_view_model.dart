import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/user_data.dart';
import '../repositories/user_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => UserRepository());
}

class HomeViewModel extends ChangeNotifier {
  final UserRepository _userRepository = getIt<UserRepository>();

  UserData get currentUser => _userRepository.currentUser;

  void updateProfile(String newName, String newEmail, String newAbout) {
    _userRepository.updateProfile(
      name: newName,
      email: newEmail,
      about: newAbout,
    );
    notifyListeners();
  }

  void updateSliderValue(double newValue) {
    _userRepository.updateSliderValue(newValue);
    notifyListeners();
  }

  void updateSettings({
    required bool newsletter,
    required bool darkMode,
    required bool notifications,
    required bool offlineMode,
  }) {
    _userRepository.updateSettings(
      newsletter: newsletter,
      darkMode: darkMode,
      notifications: notifications,
      offlineMode: offlineMode,
    );
    notifyListeners();
  }
}
