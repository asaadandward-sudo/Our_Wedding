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
      case 'parkavenue':
        return TextStyle(
          fontFamily: 'ParkAvenue',
          fontSize: size,
          fontWeight: weight,
          color: textColor,
          height: height,
        );

      case 'cormorant':
        return GoogleFonts.cormorantGaramond(
          fontSize: size,
          fontWeight: weight,
          color: textColor,
          height: height,
        );
      
      case 'lateef':
        return GoogleFonts.lateef(
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
        fontFamily: 'parkavenue',
        size: 50,
        weight: FontWeight.w600,
        height: 2,
        color: InvitationColors.greenBlack
      );

  static TextStyle get englishSubtitle => _font(
        fontFamily: 'parkavenue',
        size: 35,
        weight: FontWeight.w600,
        color: InvitationColors.textPrimary,
        height: 1.7
      );

  static TextStyle get englishBody => _font(
        fontFamily: 'cormorant',
        size: 25,
        height: 1.5,
        weight: FontWeight.w500,
        color: InvitationColors.textPrimary
      );

  static TextStyle get englishCaption => _font(
        fontFamily: 'cormorant',
        size: 15,
        weight: FontWeight.w300,
        color: InvitationColors.textPrimary.withOpacity(0.7),
        height: 1.3
      );

  static TextStyle get englishButton => _font(
        fontFamily: 'cormorant',
        size: 20,
        weight: FontWeight.w400,
        color: InvitationColors.textSecondary,
        height: 1.5
      );





  static TextStyle arabicTitle = _font(
        fontFamily: 'lateef',
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
