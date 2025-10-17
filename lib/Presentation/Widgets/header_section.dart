import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Presentation/Screens/couple_login.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_sizes.dart';
import 'package:weeding_invitation/Presentation/Components/section.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    
    int adminTapCount = 0;
    Timer? tapResetTimer;

    return Section(
      backgroundImage: DecorationImage(
        image: AssetImage('assets/image/design1h.png'),
        fit: (MediaQuery.of(context).size.width < 700) ? BoxFit.cover : BoxFit.fitHeight,
      ),
      child: Column(
        children: [
          SizedBox(
            width: InvitationHelper.setWidth(context: context, forMobile: 220.r, forTablet: 120.r, forDesktop: 120.r),
            child: Lottie.asset('assets/animations/Blue flower.json'),
          ),

          SizedBox(height: 50.h),

          // Quote
          SelectableTextWidget(
            arabicText: InvitationContent.initialQuote,
            arabicTextStyle: InvitationTypography.arabicBody.copyWith(
              fontSize: InvitationSizes.of(context).body()
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.arabic,
          ),

          SizedBox(height: 60.h),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: GestureDetector(
              onTap: () {
                  adminTapCount++;
                  tapResetTimer?.cancel();
                  tapResetTimer = Timer(const Duration(milliseconds: 1500), () {
                    adminTapCount = 0;
                  });

                  if (adminTapCount >= 3) {
                    tapResetTimer?.cancel();
                    adminTapCount = 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const CoupleLogin(),
                      ),
                    );
                  }
              },
              child: SizedBox(
                width: InvitationHelper.setWidth(context: context, forMobile: 800.r, forTablet: 550.r, forDesktop: 450.r),
                child: Image(
                  image: AssetImage(InvitationContent.coupleData.logo),
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.low,
                ),
              ),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableTextWidget(
                    arabicText: InvitationContent.coupleData.day,
                    arabicTextStyle: InvitationTypography.arabicBody.copyWith(
                  fontSize: InvitationSizes.of(context).body()
                    ),
                    textAlign: TextAlign.center,
                    textType: TextLanguageType.arabic,
                  ),
                  const SizedBox(height: 4),
                  SelectableTextWidget(
                    arabicText: '${InvitationContent.coupleData.time.split(' ')[0]} صباحاً',
                    arabicTextStyle: InvitationTypography.arabicBody.copyWith(
                  fontSize: InvitationSizes.of(context).body()
                    ),
                    textAlign: TextAlign.center,
                    textType: TextLanguageType.arabic,
                  ),
                  
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: 0.7,
                height: 40,
                color: InvitationColors.darkOlive,
              ),



              SelectableTextWidget(
                arabicText: InvitationContent.coupleData.date.split(' ')[0],
                arabicTextStyle: InvitationTypography.englishTitle.copyWith(
                  fontSize: InvitationSizes.of(context).titleXL()
                ),
                textAlign: TextAlign.center,
                textType: TextLanguageType.arabic,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: 0.7,
                height: 40,
                color: InvitationColors.darkOlive,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableTextWidget(
                    arabicText: InvitationContent.coupleData.date.split(' ')[1],
                    arabicTextStyle: InvitationTypography.arabicBody.copyWith(
                  fontSize: InvitationSizes.of(context).body()
                    ),
                    textAlign: TextAlign.center,
                    textType: TextLanguageType.arabic,
                  ),
                  
                  const SizedBox(height: 4),

                  SelectableTextWidget(
                    englishText: InvitationContent.coupleData.date.split(' ')[2],
                    englishTextStyle: InvitationTypography.arabicBody.copyWith(
                  fontSize: InvitationSizes.of(context).body()
                    ),
                    textAlign: TextAlign.center,
                    textType: TextLanguageType.english,
                  ),

                ],
              ),

              
            ],
          ),

          SizedBox(height: 40.h),

          SelectableTextWidget(
            arabicText: '${InvitationContent.coupleData.church} ${InvitationContent.coupleData.city} ${InvitationContent.coupleData.state} \n${InvitationContent.coupleData.locationDetails}',
            arabicTextStyle: InvitationTypography.arabicBody.copyWith(
              fontSize: InvitationSizes.of(context).body()
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.arabic,
          ),

          SizedBox(height: 20.h),


          SelectableTextWidget(
            arabicText: InvitationContent.coupleData.details,
            arabicTextStyle: InvitationTypography.arabicBody.copyWith(
              fontSize: InvitationSizes.of(context).body()
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.arabic,
          ),

        ],
      ),
    );
  }
}
