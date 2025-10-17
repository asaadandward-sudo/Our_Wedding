import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';

class InvitationTypography {
  InvitationTypography._();

  /// 🏗 Helper method to build font styles dynamically
  static TextStyle _font({
    required String fontFamily,
    required double size,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height = 1.5,
  }) {
    final textColor = color ?? InvitationColors.textPrimary;
    switch (fontFamily.toLowerCase()) {
      case 'ffl':
        return GoogleFonts.playfairDisplaySc(
          fontSize: size,
          fontWeight: weight,
          color: textColor,
          height: height,
        );

      case 'fancy':
        return GoogleFonts.parisienne(
          fontSize: size,
          fontWeight: weight,
          color: textColor,
          height: height,
        );

      case 'scheherazade':
        return GoogleFonts.scheherazadeNew(
          fontSize: size,
          fontWeight: weight,
          color: textColor,
          height: height,
        );

      default:
        return TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: textColor,
          height: height,
        );
    }
  }

  static TextStyle get englishTitle => _font(
        fontFamily: 'ffl',
        size: 50,
        weight: FontWeight.w400,
        height: 2,
        color: InvitationColors.greenBlack
      );

  static TextStyle get englishSubtitle => _font(
        fontFamily: 'ffl',
        size: 35,
        weight: FontWeight.w400,
        color: InvitationColors.textPrimary,
        height: 1.7
      );

  static TextStyle get englishBody => _font(
        fontFamily: 'ffl',
        size: 25,
        height: 1.5,
        weight: FontWeight.w400,
        color: InvitationColors.textPrimary
      );

  static TextStyle get englishCaption => _font(
        fontFamily: 'fancy',
        size: 15,
        weight: FontWeight.w400,
        color: InvitationColors.textPrimary.withOpacity(0.8),
        height: 1.3
      );

  static TextStyle get englishButton => _font(
        fontFamily: 'ffl',
        size: 20,
        weight: FontWeight.w400,
        color: InvitationColors.textSecondary,
        height: 1.5
      );





  static TextStyle arabicTitle = _font(
        fontFamily: 'scheherazade',
        size: 50,
        weight: FontWeight.w500,
        height: 2,
        color: InvitationColors.greenBlack
      );

  static TextStyle get arabicSubtitle => _font(
        fontFamily: 'scheherazade',
        size: 35,
        weight: FontWeight.w500,
        color: InvitationColors.textPrimary,
        height: 1.7
      );

  static TextStyle arabicBody = _font(
        fontFamily: 'scheherazade',
        size: 25,
        height: 1.5,
        color: InvitationColors.textPrimary
      );

  static TextStyle get arabicCaption => _font(
        fontFamily: 'scheherazade',
        size: 15,
        height: 1.3,
        weight: FontWeight.w300,
        color: InvitationColors.textPrimary
      );

  static TextStyle arabicButton = _font(
        fontFamily: 'scheherazade',
        size: 20,
        weight: FontWeight.w400,
        color: InvitationColors.textSecondary,
        height: 1.5
      );
}
