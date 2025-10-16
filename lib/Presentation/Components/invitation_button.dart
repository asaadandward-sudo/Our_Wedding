import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';

class InvitationButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const InvitationButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? InvitationColors.backgroundSecondary,
        foregroundColor: textColor ?? InvitationColors.deepEmerald,
        side: BorderSide(
          color: InvitationColors.greenBlack,
          width: borderWidth ?? 2.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 100.w,
          vertical: 25.h,
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: isLoading
          ? SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xFF2B2B2B),
                ),
              ),
            )
          :
            Text(
              text,
              style: InvitationTypography.arabicButton.copyWith(
                fontSize: InvitationHelper.setSize(context: context, forMobile: 45.sp, forTablet: 30.sp, forDesktop: 20.sp),
                color: textColor
              ),
              textAlign: TextAlign.center,
            )
          
     );
  }
}