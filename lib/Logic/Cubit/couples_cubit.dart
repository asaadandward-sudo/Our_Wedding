import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weeding_invitation/Logic/Cubit/couples_state.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Data/Models/admin_user.dart';
import 'package:weeding_invitation/Data/Models/guest.dart';

class CouplesCubit extends Cubit<CouplesState> {
  CouplesCubit() : super(CouplesInitial());
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AdminUser? _currentAdmin;
  List<Guest> _guests = [];

  AdminUser? get currentAdmin => _currentAdmin;
  List<Guest> get guests => _guests;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(CouplesLoading(showDialog: true));
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get admin user data from Firestore
      final DocumentSnapshot adminDoc = await _firestore
          .collection('admins')
          .doc(userCredential.user!.uid)
          .get();

      if (adminDoc.exists) {
        _currentAdmin = AdminUser.fromMap(adminDoc.data() as Map<String, dynamic>);
        
        // Save login state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('admin_uid', _currentAdmin!.uid);
        
        emit(CouplesAuthenticated(_currentAdmin!));
        await loadGuests();
      } else {
        await _auth.signOut();
        emit(CouplesError(InvitationContent.adminNotFound));
      }
    } catch (e) {
      emit(CouplesError(InvitationContent.loginFailed));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(CouplesLoading(showDialog: false));
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? adminUid = prefs.getString('admin_uid');
      
      if (adminUid != null && _auth.currentUser != null) {
        final DocumentSnapshot adminDoc = await _firestore
            .collection('admins')
            .doc(adminUid)
            .get();

        if (adminDoc.exists) {
          _currentAdmin = AdminUser.fromMap(adminDoc.data() as Map<String, dynamic>);
          emit(CouplesAuthenticated(_currentAdmin!));
          await loadGuests();
          return;
        }
      }
      
      emit(CouplesUnauthenticated());
    } catch (e) {
      emit(CouplesError(InvitationContent.authCheckFailed));
    }
  }

  Future<void> loadGuests() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('Guests')
          .orderBy('timestamp', descending: true)
          .get();

      _guests = querySnapshot.docs
          .map((doc) => Guest.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      emit(CouplesGuestsLoaded(_guests));
    } catch (e) {
      emit(CouplesError(InvitationContent.loadGuestsFailed));
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('admin_uid');
      _currentAdmin = null;
      _guests = [];
      emit(CouplesUnauthenticated());
    } catch (e) {
      emit(CouplesError(InvitationContent.signOutFailed));
    }
  }

  Future<void> refreshGuests() async {
    await loadGuests();
  }
}
