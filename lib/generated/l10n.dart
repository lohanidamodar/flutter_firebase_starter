// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get appName {
    return Intl.message(
      'Firebase starter',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: '',
      args: [],
    );
  }

  String get signupButtonText {
    return Intl.message(
      'Sign up',
      name: 'signupButtonText',
      desc: '',
      args: [],
    );
  }

  String get googleButtonText {
    return Intl.message(
      'Continue with Google',
      name: 'googleButtonText',
      desc: '',
      args: [],
    );
  }

  String get loginPageTitleText {
    return Intl.message(
      'Welcome',
      name: 'loginPageTitleText',
      desc: '',
      args: [],
    );
  }

  String get loginPageSubtitleText {
    return Intl.message(
      'Our awesome login app',
      name: 'loginPageSubtitleText',
      desc: '',
      args: [],
    );
  }

  String get emailFieldlabel {
    return Intl.message(
      'Email',
      name: 'emailFieldlabel',
      desc: '',
      args: [],
    );
  }

  String get passwordFieldLabel {
    return Intl.message(
      'Password',
      name: 'passwordFieldLabel',
      desc: '',
      args: [],
    );
  }

  String get emailValidationError {
    return Intl.message(
      'Please enter email',
      name: 'emailValidationError',
      desc: '',
      args: [],
    );
  }

  String get passwordValidationError {
    return Intl.message(
      'Please enter password',
      name: 'passwordValidationError',
      desc: '',
      args: [],
    );
  }

  String get confirmPasswordValidationEmptyError {
    return Intl.message(
      'Please confirm password',
      name: 'confirmPasswordValidationEmptyError',
      desc: '',
      args: [],
    );
  }

  String get confirmPasswordValidationMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'confirmPasswordValidationMatchError',
      desc: '',
      args: [],
    );
  }

  String get confirmPasswordFieldLabel {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordFieldLabel',
      desc: '',
      args: [],
    );
  }

  String get logoutButtonText {
    return Intl.message(
      'Log out',
      name: 'logoutButtonText',
      desc: '',
      args: [],
    );
  }

  String get profilePageTitle {
    return Intl.message(
      'Profile',
      name: 'profilePageTitle',
      desc: '',
      args: [],
    );
  }

  String get nameFieldLabel {
    return Intl.message(
      'Name',
      name: 'nameFieldLabel',
      desc: '',
      args: [],
    );
  }

  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  String get saveButtonLabel {
    return Intl.message(
      'Save',
      name: 'saveButtonLabel',
      desc: '',
      args: [],
    );
  }

  String get pickFromGalleryButtonLabel {
    return Intl.message(
      'Gallery',
      name: 'pickFromGalleryButtonLabel',
      desc: '',
      args: [],
    );
  }

  String get pickFromCameraButtonLabel {
    return Intl.message(
      'Take Photo',
      name: 'pickFromCameraButtonLabel',
      desc: '',
      args: [],
    );
  }

  String get cancelButtonLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelButtonLabel',
      desc: '',
      args: [],
    );
  }

  String get pickImageDialogTitle {
    return Intl.message(
      'Pick Image',
      name: 'pickImageDialogTitle',
      desc: '',
      args: [],
    );
  }

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
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}