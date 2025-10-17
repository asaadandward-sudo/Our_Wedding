import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';

class DevelopedBy extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;

  const DevelopedBy({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = InvitationHelper.setSize(context: context, forMobile: 37.sp, forTablet: 23.sp, forDesktop: 15.sp);
    return Container(
      color: InvitationColors.backgroundSecondary,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Line 1 – "Developed by {name}"
          SelectableTextWidget(
            englishText: 'Developed by $name',
            englishTextStyle: InvitationTypography.englishCaption.copyWith(
              color: InvitationColors.textPrimary.withOpacity(0.9),
              fontSize: fontSize
            ),
            textType: TextLanguageType.english,
          ),

          const SizedBox(height: 8),

          // Line 2 – "email - phone"
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email (clickable)
              GestureDetector(
                onTap: () {
                  InvitationHelper().launchEmail(email);
                },
                child: Text(
                  email,
                  style: InvitationTypography.englishCaption.copyWith(
                    color: InvitationColors.textSecondary.withOpacity(0.85),
                    decoration: TextDecoration.underline,
                    fontSize: fontSize
                  ),
                ),
              ),

              // Separator
              SelectableTextWidget(
                englishText: '   -   ',
                englishTextStyle: InvitationTypography.englishCaption.copyWith(
                  color: InvitationColors.textSecondary.withOpacity(0.6),
                  fontSize: fontSize
                ),
                textType: TextLanguageType.english,
                
              ),

              // WhatsApp phone (clickable)
              GestureDetector(
                onTap: () => InvitationHelper().launchWhatsApp(phoneNumber),
                child: Text(
                  phoneNumber,
                  style: InvitationTypography.englishCaption.copyWith(
                    color: InvitationColors.textSecondary.withOpacity(0.85),
                    fontSize: fontSize
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
