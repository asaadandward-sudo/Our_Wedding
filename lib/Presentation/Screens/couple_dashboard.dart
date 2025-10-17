import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_top_bar.dart';
import 'package:weeding_invitation/Presentation/Components/guest_card.dart';
import 'package:weeding_invitation/Logic/Cubit/couples_cubit.dart';
import 'package:weeding_invitation/Logic/Cubit/couples_state.dart';
import 'package:weeding_invitation/Core/Navigation/navigation_service.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_sizes.dart';

class CoupleDashboard extends StatefulWidget {
  const CoupleDashboard({super.key});

  @override
  State<CoupleDashboard> createState() => _CoupleDashboardScreenState();
}

class _CoupleDashboardScreenState extends State<CoupleDashboard> {
  @override
  void initState() {
    super.initState();
    context.read<CouplesCubit>().checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    double bodyFontSize = InvitationSizes.of(context).bodySm();
    double titleFontSize = InvitationSizes.of(context).titleL();

    return Scaffold(
      backgroundColor: InvitationColors.backgroundPrimary,
      body: BlocConsumer<CouplesCubit, CouplesState>(
        listener: (context, state) {
          if (state is CouplesError) {
            InvitationHelper.showErrorBar(context, message: state.message);
          }
          if (state is CouplesUnauthenticated) {
            InvitationHelper.hideDialog(context);
            NavigationService.pushNamedAndRemoveUntil(AppRoutes.login, (route) => route.settings.name == AppRoutes.home);
          }
         },
        builder: (context, state) {
          if (state is CouplesLoading) {
            return Scaffold(
              backgroundColor: InvitationColors.backgroundPrimary,
              body: Center(
                child: SizedBox(
                  width: InvitationHelper.setWidth(context: context, forMobile: 220.r, forTablet: 120.r, forDesktop: 120.r),
                  child: Lottie.asset('assets/animations/Blue flower.json'),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: InvitationHelper.setMainPadding(context: context).copyWith(top: 25),
            child: Column(
              children: [
                // 🔹 Top Bar
                InvitationTopBar(
                  leading: IconButton(
                    icon: const Icon(Icons.home, color: Colors.white),
                    onPressed: () => NavigationService.pushNamedAndRemoveUntil(AppRoutes.home, (r) => r.isFirst),
                    tooltip: 'Home',
                  ),
                  title: SelectableTextWidget(
                    englishText: 'Dashboard',
                    englishTextStyle: InvitationTypography.englishBody.copyWith(
                      color: InvitationColors.backgroundSecondary,
                      fontSize: bodyFontSize
                    ),
                    textType: TextLanguageType.english,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        context.read<CouplesCubit>().signOut();
                      },
                      tooltip: 'Logout',
                    ),
                  ],
                ),
                        
                // 🔹 Title
                Padding(
                  padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
                  child: SelectableTextWidget(
                    englishText: 'Couple Dashboard',
                    englishTextStyle: InvitationTypography.englishTitle
                        .copyWith(fontSize: titleFontSize),
                    textAlign: TextAlign.center,
                    textType: TextLanguageType.english,
                  ),
                ),
                        
                // 🔹 Subtitle (Arabic text)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'كل الرسايل',
                          textAlign: TextAlign.right,
                          style: InvitationTypography.arabicBody.copyWith(
                            fontSize: bodyFontSize,
                            color: InvitationColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            context.read<CouplesCubit>().refreshGuests();
                          },
                          icon: Icon(
                            Icons.refresh,
                            color: InvitationColors.royalBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),
                        
                // 🔹 Guest Cards List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _buildGuestList(state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuestList(CouplesState state) {
    double bodyFontSize = InvitationSizes.of(context).bodySm();
        
    if (state is CouplesGuestsLoaded) {
      final guests = state.guests;
      
      if (guests.isEmpty) {
        return Center(
          child: SelectableTextWidget(
            arabicText: 'ليس لديك اي بطاقات تهنئة بعد',
            arabicTextStyle: InvitationTypography.arabicBody.copyWith(
              fontSize: bodyFontSize
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.arabic,
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: guests.length,
        itemBuilder: (context, index) {
          final guest = guests[index];
          return GuestCard(
            guestName: guest.name,
            isAttending: guest.attending,
            numberOfGuests: guest.attendeesCount,
            message: guest.message,
            base64Signature: guest.signature,
          );
        },
      );
    }

    // Default state - show loading or placeholder
    return Center(
      child: SizedBox(
            width: InvitationHelper.setWidth(context: context, forMobile: 220.r, forTablet: 120.r, forDesktop: 120.r),
            child: Lottie.asset('assets/animations/Blue flower.json'),
          ),
      
    );
  }
}
