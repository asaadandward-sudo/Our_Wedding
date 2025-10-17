import 'package:flutter/material.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Presentation/Components/interactive_map_box.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_button.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_sizes.dart';
import 'package:weeding_invitation/Presentation/Components/section.dart';

class EventInfoSection extends StatelessWidget {
  final VoidCallback onOpenLocation;
  
  const EventInfoSection({
    super.key,
    required this.onOpenLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Section(
          backgroundImage: const DecorationImage(
            image: AssetImage('assets/image/design2h.png'),
            fit: BoxFit.cover,
          ),
          child: Column(
            children: [
              SelectableTextWidget(
                englishText: InvitationContent.witnessTitle,
                englishTextStyle: InvitationTypography.englishTitle.copyWith(
                  fontSize: InvitationSizes.of(context).titleL(),
                ),
                textAlign: TextAlign.center,
                textType: TextLanguageType.english,
              ),
              const SizedBox(height: 40),
              _buildInfoRow(
                title: InvitationContent.dateLabel,
                fontSize: InvitationSizes.of(context).body(),
                content: '${InvitationContent.coupleData.day} ${InvitationContent.coupleData.date}',
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: onOpenLocation,
                child: _buildInfoRow(
                  title: InvitationContent.venueLabel,
                  fontSize: InvitationSizes.of(context).body(),
                  content: '${InvitationContent.coupleData.church}\n${InvitationContent.coupleData.city} ${InvitationContent.coupleData.state}\n ${InvitationContent.coupleData.locationDetails}',
                ),
              ),

              const SizedBox(height: 40),

        // Interactive Map Box
        InteractiveMapBox(
          locationTitle: 'Tia-Vie',
          latitude: 30.1048,
          longitude: 31.5865,
        ),
      
        const SizedBox(height: 40),

        InvitationButton(
          text: InvitationContent.openLocation,
          onPressed: onOpenLocation,
        ),
            ],
          ),
        ),
      ],
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

