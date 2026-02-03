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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `Okk`
  String get okk {
    return Intl.message('Okk', name: 'okk', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Are you sure you want to exit?`
  String get exitConfirmMessage {
    return Intl.message(
      'Are you sure you want to exit?',
      name: 'exitConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your MAC address is not associated with any playlist`
  String get macNotAssociated {
    return Intl.message(
      'Your MAC address is not associated with any playlist',
      name: 'macNotAssociated',
      desc: '',
      args: [],
    );
  }

  /// `Upload Playlist`
  String get uploadPlaylist {
    return Intl.message(
      'Upload Playlist',
      name: 'uploadPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Language (EN)`
  String get language {
    return Intl.message('Language (EN)', name: 'language', desc: '', args: []);
  }

  /// `Power`
  String get power {
    return Intl.message('Power', name: 'power', desc: '', args: []);
  }

  /// `This player is not active yet. Activate your subscription to access content.`
  String get playerNotActive {
    return Intl.message(
      'This player is not active yet. Activate your subscription to access content.',
      name: 'playerNotActive',
      desc: '',
      args: [],
    );
  }

  /// `Activate Now`
  String get activateNow {
    return Intl.message(
      'Activate Now',
      name: 'activateNow',
      desc: '',
      args: [],
    );
  }

  /// `Your MAC`
  String get macLabel {
    return Intl.message('Your MAC', name: 'macLabel', desc: '', args: []);
  }

  /// `WisePlayer.app is a TV player only and does not include any channels`
  String get tvOnlyWarning {
    return Intl.message(
      'WisePlayer.app is a TV player only and does not include any channels',
      name: 'tvOnlyWarning',
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
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
