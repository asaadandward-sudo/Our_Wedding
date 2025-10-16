import 'package:flutter/material.dart';

enum TextLanguageType { auto, arabic, english }

class SelectableTextWidget extends StatelessWidget {
  final String? arabicText;
  final String? englishText;
  final TextStyle? englishTextStyle;
  final TextStyle? arabicTextStyle;
  final TextAlign textAlign;
  final TextLanguageType textType;

  const SelectableTextWidget({
    super.key,
    this.arabicText,
    this.englishText,
    this.englishTextStyle,
    this.arabicTextStyle,
    this.textAlign = TextAlign.center,
    this.textType = TextLanguageType.auto,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic;
    switch (textType) {
      case TextLanguageType.arabic:
        isArabic = true;
        break;
      case TextLanguageType.english:
        isArabic = false;
        break;
      default:
        isArabic = Localizations.localeOf(context).languageCode == 'ar';
    }

    final text = isArabic ? arabicText : englishText;

    if (text == null || text.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return SelectableText(
      text,
      style: isArabic ? arabicTextStyle : englishTextStyle,
      textAlign: textAlign,
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    );
  }
}
