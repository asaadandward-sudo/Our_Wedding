import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weeding_invitation/Logic/Cubit/invitation_state.dart';
import 'package:weeding_invitation/Data/Models/guest.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> openMaps(BuildContext context, String mapLink) async {
    try {
      if (mapLink.trim().isEmpty) {
        throw Exception(InvitationContent.emptyMapLink);
      }

      final Uri url = Uri.parse(mapLink);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception(InvitationContent.cannotOpenMap);
      }
    } catch (e) {
      emit(InvitationError(InvitationContent.mapsFailed));
    }
  }

  Future<void> openCalendar(BuildContext context, {required String title,required String start, required String end, required String location, String details = ''}) async {
    try {
      if (title.trim().isEmpty || start.trim().isEmpty || end.trim().isEmpty || location.trim().isEmpty) {
        throw Exception(InvitationContent.calendarMissingParams);
      }

      final String calendarUrl = 'https://calendar.google.com/calendar/render?action=TEMPLATE&text=${Uri.encodeComponent(title)}&dates=$start/$end&details=${Uri.encodeComponent(details)}&location=${Uri.encodeComponent(location)}';
      final Uri url = Uri.parse(calendarUrl);

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception(InvitationContent.cannotOpenCalendar);
      }
    } catch (e) {
      emit(InvitationError(InvitationContent.calendarFailed));
    }
  }

  Future<void> submitGuestRSVP(BuildContext context, Guest guest) async {
    emit(InvitationLoading());
    try {
      if (guest.name.trim().isEmpty) {
        throw Exception(InvitationContent.guestNameEmpty);
      }
      if (guest.message.trim().isEmpty) {
        throw Exception(InvitationContent.messageEmpty);
      }
      
      // Add guest to Firestore
      final guestData = guest.toMap();
      await _firestore.collection('Guests').add(guestData);

      emit(InvitationDone());
    } catch (e) {
      emit(InvitationError(InvitationContent.submitFailed));
    }
  }





}
