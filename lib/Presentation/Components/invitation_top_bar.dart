import 'package:flutter/material.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';

class InvitationTopBar extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  const InvitationTopBar({super.key, this.leading, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: InvitationColors.forestGreen.withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          leading ?? const SizedBox.shrink(),
          const SizedBox(width: 8),
          Expanded(child: Center(child: title ?? const SizedBox.shrink())),
          const SizedBox(width: 8),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
