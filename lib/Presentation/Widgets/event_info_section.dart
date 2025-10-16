import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Presentation/Components/interactive_map_box.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_button.dart';

class EventInfoSection extends StatelessWidget {
  final VoidCallback onOpenLocation;
  
  const EventInfoSection({
    super.key,
    required this.onOpenLocation,
  });

  @override
  Widget build(BuildContext context) {

    double bodyFontSize = InvitationHelper.setSize(context: context, forMobile: 54.sp, forTablet: 30.sp, forDesktop: 20.sp);
    double titleFontSize = InvitationHelper.setSize(context: context, forMobile: 120.sp, forTablet: 70.sp, forDesktop: 50.sp);


    return Container(
      width: double.infinity,
      color: InvitationColors.backgroundPrimary.withOpacity(0.2),
      padding: InvitationHelper.setMainPadding(context: context),
      child: Column(
        children: [

          SelectableTextWidget(
            englishText: InvitationContent.witnessTitle,
            englishTextStyle: InvitationTypography.englishTitle.copyWith(
              fontSize: titleFontSize
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.english,
          ),

          SizedBox(height: 40),
          
          _buildInfoRow(
            title: InvitationContent.dateLabel,
            fontSize: bodyFontSize,
            content: '${InvitationContent.coupleData.day} ${InvitationContent.coupleData.date}',
          ),

          SizedBox(height: 40),

          GestureDetector(
            onTap: onOpenLocation,
            child: _buildInfoRow(
              title: InvitationContent.venueLabel,
              fontSize: bodyFontSize,
              content: '${InvitationContent.coupleData.church}\n${InvitationContent.coupleData.city} ${InvitationContent.coupleData.state}\n ${InvitationContent.coupleData.locationDetails}',
            ),
          ),

          SizedBox(height: 60),

          // Interactive Map Box
          InteractiveMapBox(
            locationTitle: 'Tia-Vie',
            latitude: 30.1048,
            longitude: 31.5865,
          ),
        
          SizedBox(height: 40),
          
          // Open Location button
          InvitationButton(
            text: InvitationContent.openLocation,
            onPressed: onOpenLocation,
          ),
     
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String title, required String content, required double fontSize}) {
    return Column(
      children: [

        SelectableTextWidget(
          arabicText: title,
          arabicTextStyle: InvitationTypography.arabicBody.copyWith(
            fontSize: fontSize,
            color: InvitationColors.textSecondary
          ),
          textAlign: TextAlign.center,
          textType: TextLanguageType.arabic,
        ),


        const SizedBox(height: 7),


        SelectableTextWidget(
        arabicText: content,
        arabicTextStyle: InvitationTypography.arabicBody.copyWith(
          fontSize: fontSize
        ),
        textAlign: TextAlign.center,
        textType: TextLanguageType.arabic,
      ),
      ],
    );
  }
}

