// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "Popular": "الأكثر رؤية",
    "More": "المزيد",
    "What are you looking for?": "لنستكشف المزيد",
    "Badroom": "غرفة نوم",
    "Home": "الرئيسية",
    "Setting": "اللإعدادات",
    "Favorite": "المفضلة",
    "For rent": "للكراء",
    "Message": "الرسائل",
  };
  static const Map<String, dynamic> en = {
    "Popular": "Popular",
    "More": "More",
    "What are you looking for?": "What are you looking for?",
    "Badroom": "Badroom",
    "Home": "Home",
    "Setting": "Setting",
    "Favorite": "Favorite",
    "For rent": "For rent",
    "Message": "Messages",
  };
  static const Map<String, dynamic> fr = {
    "Popular": "Populaire",
    "More": "Suite",
    "What are you looking for?": "Que cherchez-vous?",
    "Badroom": "salle de bains",
    "Home": "accueil",
    "Setting": "Paramètre",
    "Favorite": "Favorit",
    "For rent": "a louer",
    "Message": "Messages",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en,
    "fr": fr
  };
}
