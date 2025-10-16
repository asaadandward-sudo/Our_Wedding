import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Data/Models/weeding.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_button.dart';

class ClosingSection extends StatelessWidget {
  final Wedding wedding;
  final VoidCallback onAddToCalendar;

  const ClosingSection({
    super.key,
    required this.wedding,
    required this.onAddToCalendar,
  });

  @override
  Widget build(BuildContext context) {
    
    double bodyFontSize = InvitationHelper.setSize(context: context, forMobile: 54.sp, forTablet: 30.sp, forDesktop: 20.sp);
    double titleFontSize = InvitationHelper.setSize(context: context, forMobile: 120.sp, forTablet: 70.sp, forDesktop: 50.sp);


    return Container(
      width: double.infinity,
      color: InvitationColors.backgroundPrimary,
      padding: InvitationHelper.setMainPadding(context: context),
      child: Column(
        children: [

          SelectableTextWidget(
            englishText: InvitationContent.closingTitle,
            englishTextStyle: InvitationTypography.englishTitle.copyWith(
              fontSize: titleFontSize
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.english,
          ),

          SelectableTextWidget(
            englishText: InvitationContent.closingDescription,
            englishTextStyle: InvitationTypography.englishBody.copyWith(
              fontSize: bodyFontSize,
            ),
            textAlign: TextAlign.center, 
            textType: TextLanguageType.english,
          ),

          const SizedBox(height: 40),
          
          InvitationButton(
            text: InvitationContent.addToCalendar,
            onPressed: onAddToCalendar,
          ),
        ],
      ),
    );
  }
}
