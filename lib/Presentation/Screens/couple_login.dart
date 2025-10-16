import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Logic/Cubit/couples_cubit.dart';
import 'package:weeding_invitation/Logic/Cubit/couples_state.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Presentation/Components/custom_text_field.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_button.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_top_bar.dart';
import 'package:weeding_invitation/Core/Navigation/navigation_service.dart';

class CoupleLogin extends StatefulWidget {
  const CoupleLogin({super.key});

  @override
  State<CoupleLogin> createState() => _CoupleLoginScreenState();
}

class _CoupleLoginScreenState extends State<CoupleLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double bodyFontSize = InvitationHelper.setSize(
        context: context, forMobile: 60.sp, forTablet: 30.sp, forDesktop: 20.sp);
    double titleFontSize = InvitationHelper.setSize(
        context: context, forMobile: 120.sp, forTablet: 70.sp, forDesktop: 50.sp);

    return Scaffold(
      backgroundColor: InvitationColors.backgroundSecondary,
      body: BlocConsumer<CouplesCubit, CouplesState>(
        listener: (context, state) {
          if (state is CouplesLoading && state.showDialog) {
            InvitationHelper.showLoadingDialog(context);
          }

          if (state is CouplesError) {
            InvitationHelper.hideDialog(context);
            InvitationHelper.showErrorBar(context, message: state.message);
          }

          if (state is CouplesAuthenticated) {
            InvitationHelper.hideDialog(context);
            NavigationService.pushReplacementNamed(AppRoutes.dashboard);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: InvitationHelper.setMainPadding(context: context).copyWith(top: 25),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 50.h, // keeps it vertically centered
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // 🔹 Top Bar
                    InvitationTopBar(
                      leading: IconButton(
                        icon: const Icon(Icons.home, color: Colors.white),
                        onPressed: () => NavigationService.pushNamedAndRemoveUntil(AppRoutes.home, (r) => r.isFirst),
                        tooltip: 'Home',
                      ),
                      actions: const [],
                    ),

                    // 🔹 Centered Body
                    Expanded(
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SelectableTextWidget(
                                  englishText: InvitationContent.loginTitle,
                                  englishTextStyle:
                                      InvitationTypography.englishTitle.copyWith(fontSize: titleFontSize),
                                  textAlign: TextAlign.center,
                                  textType: TextLanguageType.english,
                                ),
                                SelectableTextWidget(
                                  englishText: InvitationContent.loginSubtitle,
                                  englishTextStyle:
                                      InvitationTypography.englishBody.copyWith(fontSize: bodyFontSize),
                                  textAlign: TextAlign.center,
                                  textType: TextLanguageType.english,
                                ),
                                SizedBox(height: 48.h),

                                // Email Field
                                CustomTextField(
                                  controller: _emailController,
                                  labelText: InvitationContent.emailLabel,
                                  hintText: InvitationContent.emailHint,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(Icons.email,
                                      color: InvitationColors.royalBlue),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return InvitationContent.emailEmptyError;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Password Field
                                CustomTextField(
                                  controller: _passwordController,
                                  labelText: InvitationContent.passwordLabel,
                                  hintText: InvitationContent.passwordHint,
                                  obscureText: true,
                                  prefixIcon: const Icon(Icons.lock,
                                      color: InvitationColors.royalBlue),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return InvitationContent.passwordEmptyError;
                                    }
                                    if (value.length < 6) {
                                      return InvitationContent.passwordTooShortError;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 50.h),

                                // Login Button
                                InvitationButton(
                                  text: InvitationContent.loginButton,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<CouplesCubit>().signInWithEmailAndPassword(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          );
                                    }
                                  },
                                  backgroundColor: InvitationColors.greenBlack,
                                  borderWidth: 0,
                                  textColor: InvitationColors.backgroundPrimary,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
