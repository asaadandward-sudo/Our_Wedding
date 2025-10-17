import 'package:flutter/material.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Data/Models/weeding.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_button.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_sizes.dart';

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/design3h.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
      padding: InvitationHelper.setMainPadding(context: context),
      child: Column(
        children: [
          SelectableTextWidget(
            englishText: InvitationContent.closingTitle,
            englishTextStyle: InvitationTypography.englishTitle.copyWith(
              fontSize: InvitationSizes.of(context).titleL(),
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.english,
          ),

          SelectableTextWidget(
            englishText: InvitationContent.closingDescription,
            englishTextStyle: InvitationTypography.englishBody.copyWith(
              fontSize: InvitationSizes.of(context).body(),
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
