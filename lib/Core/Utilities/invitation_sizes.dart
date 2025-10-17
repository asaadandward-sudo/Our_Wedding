import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';

class InvitationSizes {
  final BuildContext context;

  InvitationSizes._(this.context);

  factory InvitationSizes.of(BuildContext context) => InvitationSizes._(context);

  static double pick(BuildContext context, {required double mobile, required double tablet, required double desktop}) {
    return InvitationHelper.setSize(context: context, forMobile: mobile, forTablet: tablet, forDesktop: desktop);
  }

  // Commonly used typography tiers
  double titleXL() => InvitationHelper.setSize(context: context, forMobile: 150.sp, forTablet: 60.sp, forDesktop: 45.sp);
  double titleL()  => InvitationHelper.setSize(context: context, forMobile: 100.sp, forTablet: 60.sp, forDesktop: 45.sp);

  double body()    => InvitationHelper.setSize(context: context, forMobile: 54.sp,  forTablet: 30.sp, forDesktop: 20.sp);
  double bodySm()  => InvitationHelper.setSize(context: context, forMobile: 50.sp,  forTablet: 30.sp, forDesktop: 20.sp);
  double bodyXL()  => InvitationHelper.setSize(context: context, forMobile: 60.sp,  forTablet: 30.sp, forDesktop: 20.sp);

  double subtitle()   => InvitationHelper.setSize(context: context, forMobile: 45.sp, forTablet: 28.sp, forDesktop: 19.sp);
  double caption()    => InvitationHelper.setSize(context: context, forMobile: 40.sp, forTablet: 20.sp, forDesktop: 15.sp);
  double captionLg()  => InvitationHelper.setSize(context: context, forMobile: 50.sp, forTablet: 30.sp, forDesktop: 25.sp);
}


