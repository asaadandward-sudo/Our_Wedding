import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';

class DoneDialog extends StatelessWidget {
  const DoneDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double titleFontSize = InvitationHelper.setSize(context: context, forMobile: 80.sp, forTablet: 40.sp, forDesktop: 30.sp);
    return Center(
      child: Container(
        width: 420.r,
        padding: EdgeInsets.symmetric(
          horizontal: InvitationHelper.setWidth(
            context: context,
            forMobile: 20,
            forTablet: 30,
            forDesktop: 50,
          ),
          vertical: InvitationHelper.setWidth(
            context: context,
            forMobile: 30,
            forTablet: 50,
            forDesktop: 60,
          ),
        ),
        decoration: BoxDecoration(
          color: InvitationColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 0.8,
            color: InvitationColors.greenBlack.withOpacity(0.7),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SelectableTextWidget(
          englishText: 'Thank you',
          englishTextStyle: InvitationTypography.englishTitle.copyWith(
            fontSize: titleFontSize,
          ),
          textAlign: TextAlign.center,
          textType: TextLanguageType.english,
        ),
      ),
    );
  }
}
