import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';

class InvitationSnackBar {
  final String message;
  final String icon;
  final Color backgroundColor;
  final Duration duration;

  InvitationSnackBar({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    this.duration = const Duration(seconds: 3),
  });

  void showSnackBar(BuildContext context) => Flushbar (
    messageText: Row(
      crossAxisAlignment: CrossAxisAlignment.center, 
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
        SizedBox.square(
          dimension: 50,
          child: Center(
            child: Lottie.asset(
              icon,
              fit: BoxFit.contain,
              delegates: LottieDelegates(
                text: (key) => 'تنبيه',
              )
            ),
          ),
        ),
    
        const SizedBox(width: 15),
        
        Expanded(
          child: SelectableTextWidget(
            arabicText: message,
            textAlign: TextAlign.start,
            arabicTextStyle: InvitationTypography.arabicCaption.copyWith(
              fontSize: InvitationHelper.setSize(context: context, forMobile: 45.sp, forTablet: 22.sp, forDesktop: 18.sp),
              color: InvitationColors.backgroundSecondary,
            ),
            textType: TextLanguageType.arabic,
          ),
        ),
      ],
    ),
    isDismissible: true,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: backgroundColor,
    borderRadius: BorderRadius.circular(25),
    margin: EdgeInsets.all(20.r),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    duration: duration,
    forwardAnimationCurve: Curves.linearToEaseOut,
    reverseAnimationCurve: Curves.linearToEaseOut,
  
  )..show(context);
  
}