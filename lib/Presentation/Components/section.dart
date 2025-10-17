import 'package:flutter/material.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';

class Section extends StatelessWidget {
  final Widget child;
  final DecorationImage? backgroundImage;
  final EdgeInsets? padding;

  const Section({super.key, required this.child, this.backgroundImage, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? InvitationHelper.setMainPadding(context: context),
      decoration: BoxDecoration(
        image: backgroundImage,
      ),
      child: child,
    );
  }
}


