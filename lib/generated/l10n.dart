// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Firebase starter`
  String get appName {
    return Intl.message(
      'Firebase starter',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signupButtonText {
    return Intl.message(
      'Sign up',
      name: 'signupButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get googleButtonText {
    return Intl.message(
      'Continue with Google',
      name: 'googleButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get loginPageTitleText {
    return Intl.message(
      'Welcome',
      name: 'loginPageTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Our awesome login app`
  String get loginPageSubtitleText {
    return Intl.message(
      'Our awesome login app',
      name: 'loginPageSubtitleText',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailFieldlabel {
    return Intl.message(
      'Email',
      name: 'emailFieldlabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordFieldLabel {
    return Intl.message(
      'Password',
      name: 'passwordFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get emailValidationError {
    return Intl.message(
      'Please enter email',
      name: 'emailValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get passwordValidationError {
    return Intl.message(
      'Please enter password',
      name: 'passwordValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm password`
  String get confirmPasswordValidationEmptyError {
    return Intl.message(
      'Please confirm password',
      name: 'confirmPasswordValidationEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get confirmPasswordValidationMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'confirmPasswordValidationMatchError',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordFieldLabel {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logoutButtonText {
    return Intl.message(
      'Log out',
      name: 'logoutButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profilePageTitle {
    return Intl.message(
      'Profile',
      name: 'profilePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameFieldLabel {
    return Intl.message(
      'Name',
      name: 'nameFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButtonLabel {
    return Intl.message(
      'Save',
      name: 'saveButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get pickFromGalleryButtonLabel {
    return Intl.message(
      'Gallery',
      name: 'pickFromGalleryButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get pickFromCameraButtonLabel {
    return Intl.message(
      'Take Photo',
      name: 'pickFromCameraButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButtonLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get pickImageDialogTitle {
    return Intl.message(
      'Pick Image',
      name: 'pickImageDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get introFinishButtonLabel {
    return Intl.message(
      'Get Started',
      name: 'introFinishButtonLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}