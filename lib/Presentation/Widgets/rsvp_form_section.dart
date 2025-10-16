import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_typography.dart';
import 'package:weeding_invitation/Core/Utilities/selectable_text_widget.dart';
import 'package:weeding_invitation/Data/Models/guest.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_button.dart';
import 'package:weeding_invitation/Presentation/Components/custom_text_field.dart';

class RSVPFormSection extends StatefulWidget {
  final Function(Guest) onSubmit;

  const RSVPFormSection({
    super.key,
    required this.onSubmit,
  });

  @override
  State<RSVPFormSection> createState() => _RSVPFormSectionState();
}

class _RSVPFormSectionState extends State<RSVPFormSection> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  final SignatureController _signaturePadController = SignatureController(
    penStrokeWidth: 2,
    penColor: const Color(0xFF2B2B2B),
    exportBackgroundColor: Colors.white,
  );
  bool _attending = true;
  int _attendeesCount = 1;
  final List<int> _attendeeOptions = List.generate(
    InvitationContent.maxNumberOfAttendees,
    (int i) => i += 1,
    growable: false,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    _signaturePadController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final signatureBytes = await _signaturePadController.toPngBytes();
      if (signatureBytes == null || signatureBytes.isEmpty) {
        InvitationHelper.showErrorBar(context, message: 'من فضلك قم بتوقيعك قبل الأرسال');
        return;
      }

      final guest = Guest(
        name: _nameController.text.trim(),
        attending: _attending,
        attendeesCount: _attendeesCount,
        message: _messageController.text.trim(),
        signature: base64Encode(signatureBytes), 
        timestamp: DateTime.now(),
      );

      widget.onSubmit(guest);

      // إعادة تعيين النموذج
      _formKey.currentState!.reset();
      _nameController.clear();
      _messageController.clear();
      _signaturePadController.clear();
      setState(() {
        _attending = true;
        _attendeesCount = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double bodyFontSize = InvitationHelper.setSize(context: context, forMobile: 54.sp, forTablet: 30.sp, forDesktop: 20.sp);
    double titleFontSize = InvitationHelper.setSize(context: context, forMobile: 120.sp, forTablet: 70.sp, forDesktop: 50.sp);
    double captionFontSize = InvitationHelper.setSize(context: context, forMobile: 40.sp, forTablet: 20.sp, forDesktop: 15.sp);
    double subtitleFontSize = InvitationHelper.setSize(context: context, forMobile: 45.sp, forTablet: 28.sp, forDesktop: 19.sp);

    return Container(
      color: InvitationColors.backgroundSecondary,
      padding: InvitationHelper.setMainPadding(context: context),
      child: Column(
        children: [

          SelectableTextWidget(
            englishText: InvitationContent.formTitle,
            englishTextStyle: InvitationTypography.englishTitle.copyWith(
              fontSize: titleFontSize
            ),
            textAlign: TextAlign.center,
            textType: TextLanguageType.english,
          ),
    
          SizedBox(height: 70.h),
    
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  labelText: InvitationContent.nameLabel,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'من فضلك أدخل اسمك';
                    }
                    return null;
                  },
                ),
    
                const SizedBox(height: 20),
    
                // 🔹 هل ستحضر؟
                Row(
                  children: [

                    SelectableTextWidget(
                      arabicText: InvitationContent.attendingLabel,
                      arabicTextStyle: InvitationTypography.arabicSubtitle.copyWith(
                        fontSize: subtitleFontSize
                      ),
                      textAlign: TextAlign.center,
                      textType: TextLanguageType.arabic,
                    ),
                    
                    
                    const SizedBox(width: 20),

                    Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _attending,
                          activeColor: InvitationColors.royalBlue,
                          onChanged: (value) {
                            setState(() => _attending = value!);
                          },
                        ),
                        SelectableTextWidget(
                          arabicText: InvitationContent.yesLabel,
                          arabicTextStyle: InvitationTypography.arabicBody.copyWith(
                            fontSize: bodyFontSize
                          ),
                          textAlign: TextAlign.center,
                          textType: TextLanguageType.arabic,
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Radio<bool>(
                          value: false,
                          groupValue: _attending,
                          activeColor: InvitationColors.royalBlue,
                          onChanged: (value) {
                            setState(() => _attending = value!);
                          },
                        ),
                        SelectableTextWidget(
                          arabicText: InvitationContent.noLabel,
                          arabicTextStyle: InvitationTypography.arabicBody.copyWith(
                            fontSize: bodyFontSize
                          ),
                          textAlign: TextAlign.center,
                          textType: TextLanguageType.arabic,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
    
                // 🔹 عدد الحاضرين
                if (_attending) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: SelectableTextWidget(
                      arabicText: InvitationContent.howManyAttendeesLabel,
                      arabicTextStyle: InvitationTypography.arabicSubtitle.copyWith(
                        fontSize: subtitleFontSize
                      ),
                      textAlign: TextAlign.right,
                      textType: TextLanguageType.arabic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      spacing: 8,
                      children: _attendeeOptions.map((count) {
                        return ChoiceChip(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          label: Text(count.toString()),
                          selected: _attendeesCount == count,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _attendeesCount = count;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
    
                Align(
                  alignment: Alignment.centerRight,
                  child: SelectableTextWidget(
                      arabicText: InvitationContent.messageLabel,
                      arabicTextStyle: InvitationTypography.arabicSubtitle.copyWith(
                        fontSize: subtitleFontSize
                      ),
                      textAlign: TextAlign.right,
                      textType: TextLanguageType.arabic,
                    ),
                ),
                const SizedBox(height: 10),
    
                // 🔹 رسالة اختيارية
                CustomTextField(
                  controller: _messageController,
                  labelText: InvitationContent.messageLabel,
                  maxLines: 4,
                ),
                const SizedBox(height: 25),
    
                // 🔹 حقل التوقيع
                Align(
                  alignment: Alignment.centerRight,
                  child: SelectableTextWidget(
                      arabicText: InvitationContent.signatureLabel,
                      arabicTextStyle: InvitationTypography.arabicSubtitle.copyWith(
                        fontSize: subtitleFontSize
                      ),
                      textAlign: TextAlign.right,
                      textType: TextLanguageType.arabic,
                    ),
                ),
                const SizedBox(height: 10),
    
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: InvitationColors.royalBlue.withOpacity(0.3),
                      width: 0.7,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // لوحة التوقيع
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: Signature(
                          controller: _signaturePadController,
                          backgroundColor: InvitationColors.backgroundSecondary,
                        ),
                      ),
    
                      // زر مسح التوقيع
                      Positioned(
                        top: 15,
                        left: 15,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(40.r),
                          onTap: _signaturePadController.clear,
                          child: Text(
                            InvitationContent.clearSignature,
                            style: InvitationTypography.arabicCaption.copyWith(
                              fontSize: captionFontSize
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
    
                      // خط التوقيع والنص في الأسفل
                      Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Container(
                              height: 0.7,
                              color: Colors.grey.shade300,
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            const SizedBox(height: 10),
                            SelectableTextWidget(
                            arabicText: InvitationContent.signatureHint,
                            arabicTextStyle: InvitationTypography.arabicCaption.copyWith(
                              fontSize: captionFontSize
                            ),
                            textAlign: TextAlign.center,
                            textType: TextLanguageType.arabic,
                          ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    
                const SizedBox(height: 30),
    
                // 🔹 زر الإرسال
                Align(
                  alignment: Alignment.centerLeft,
                  child: InvitationButton(
                    text: InvitationContent.send,
                    onPressed: _submitForm,
                    backgroundColor: InvitationColors.greenBlack,
                    borderWidth: 0,
                    textColor: InvitationColors.backgroundPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
