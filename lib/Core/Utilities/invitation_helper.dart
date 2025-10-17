import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Presentation/Components/done_dialog.dart';
import 'package:weeding_invitation/Presentation/Components/invitation_snack_bar.dart';
import 'package:weeding_invitation/Presentation/Components/loading_dialog.dart';

class InvitationHelper {

  static double setSize({required BuildContext context, required double forMobile, required double forTablet, required double forDesktop}) {
    double currentScreenWidth = MediaQuery.of(context).size.width;
    return (currentScreenWidth > 700)? (currentScreenWidth > 1200)? forDesktop : forTablet : forMobile;
  }

  
  static double setWidth({required BuildContext context, required double forMobile, required double forTablet, required double forDesktop}) {
    double w = MediaQuery.of(context).size.width;
    return (w > 700) ? (w > 1200 ? forDesktop : forTablet) : forMobile;
  }

  static double setHeight({required BuildContext context, required double forMobile, required double forTablet, required double forDesktop}) {
    double h = MediaQuery.of(context).size.height;
    return (h > 850) ? (h > 1100 ? forDesktop : forTablet) : forMobile;
  }


  static EdgeInsets setMainPadding({required BuildContext context}) {
    double w = MediaQuery.of(context).size.width;
    return (w > 700)? (w > 1200)? const EdgeInsets.symmetric(vertical: 70, horizontal: 400)
            : const EdgeInsets.symmetric(vertical: 60, horizontal: 170)
        : const EdgeInsets.symmetric(vertical: 50, horizontal: 25);
  }



  static void hideDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }


  static void showErrorBar(BuildContext context, {required String message}) {
    InvitationSnackBar(message: message, backgroundColor: InvitationColors.error30, icon: 'assets/animations/Error.json').showSnackBar(context);
  }


  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: Navigator.of(context, rootNavigator: true).context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 20,
        insetPadding: EdgeInsets.zero,
        child: LoadingDialog()
      )
    );
  }

  static void showDoneDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 20,
        insetPadding: EdgeInsets.zero,
        child: DoneDialog()
      )
    );
  }

  Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello $email&body=Hi there,',
    );
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not open email client');
    }
  }

  Future<void> launchWhatsApp(String number) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$number');
    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not open WhatsApp');
    }
  }

  static String setBGs({required String mobilBG, required String deskBG, required BuildContext context}) {
    return (MediaQuery.of(context).size.width > 700)? deskBG: mobilBG;
  }


}




