import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';

class GuestCard extends StatelessWidget {
  final String guestName;
  final bool isAttending;
  final int numberOfGuests;
  final String message;
  final String base64Signature;

  const GuestCard({
    super.key,
    required this.guestName,
    required this.isAttending,
    required this.numberOfGuests,
    required this.message,
    required this.base64Signature,
  });

  @override
  Widget build(BuildContext context) {
    double bodyFontSize = InvitationHelper.setSize(
      context: context,
      forMobile: 50.sp,
      forTablet: 30.sp,
      forDesktop: 20.sp,
    );
    double titleFontSize = InvitationHelper.setSize(
      context: context,
      forMobile: 80.sp,
      forTablet: 40.sp,
      forDesktop: 25.sp,
    );
    double captionFontSize = InvitationHelper.setSize(
      context: context,
      forMobile: 45.sp,
      forTablet: 25.sp,
      forDesktop: 18.sp,
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: const AssetImage('assets/image/Minimalist Thank You Card .png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            InvitationColors.deepEmerald.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          // 🌿 Main column aligned to the right
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟢 Name
                SelectableTextWidget(
                  arabicText: guestName,
                  arabicTextStyle: InvitationTypography.arabicTitle.copyWith(
                    fontSize: titleFontSize,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                  textType: TextLanguageType.arabic,
                ),

                SizedBox(height: 14.h),

                // 💬 Message
                SelectableTextWidget(
                  arabicText: message.isNotEmpty
                      ? message
                      : InvitationContent.noMessageProvided,
                  arabicTextStyle: InvitationTypography.arabicBody.copyWith(
                    fontSize: bodyFontSize,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.right,
                  textType: TextLanguageType.arabic,
                ),

                SizedBox(height: 50),

                // 🟢 Attending Chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: isAttending
                        ? InvitationColors.accentLeaf
                        : InvitationColors.error30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SelectableTextWidget(
                    arabicText: isAttending
                        ? InvitationContent.attendingYes
                        : InvitationContent.attendingNo,
                    arabicTextStyle: InvitationTypography.arabicCaption.copyWith(
                      fontSize: captionFontSize - 5,
                      color: InvitationColors.backgroundSecondary,
                    ),
                    textAlign: TextAlign.center,
                    textType: TextLanguageType.arabic,
                  ),
                ),

                SizedBox(height: 10),

                // 🧍‍♂️ عدد الحاضرين
                SelectableTextWidget(
                  arabicText:
                      '${InvitationContent.attendeeCountLabel} $numberOfGuests',
                  arabicTextStyle: InvitationTypography.arabicBody.copyWith(
                    fontSize: bodyFontSize - 5,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                  textType: TextLanguageType.arabic,
                ),
              ],
            ),
          ),

          // ✍️ Signature bottom-left
          Positioned(
            bottom: 15.h,
            left: 15.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableTextWidget(
                  arabicText: 'التوقيع',
                  arabicTextStyle: InvitationTypography.arabicCaption.copyWith(
                    fontSize: captionFontSize,
                    color: InvitationColors.deepEmerald,
                  ),
                  textAlign: TextAlign.center,
                  textType: TextLanguageType.arabic,
                ),
                SizedBox(height: 8),
                if (base64Signature.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      base64Decode(base64Signature),
                      height: 60.h,
                      width: 180.w,
                      fit: BoxFit.contain,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
