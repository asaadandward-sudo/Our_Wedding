import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 420.r,
        padding: EdgeInsets.symmetric(
          horizontal: InvitationHelper.setWidth(
            context: context,
            forMobile: 40,
            forTablet: 60,
            forDesktop: 80,
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
        child: SizedBox(
          width: InvitationHelper.setWidth(
            context: context,
            forMobile: 220.r,
            forTablet: 130.r,
            forDesktop: 120.r,
          ),
          child: Lottie.asset('assets/animations/Blue flower.json'),
        ),
      ),
    );
  }
}
