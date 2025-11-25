import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An error occurred. Please try again';
    }
  }

  // Sign up with email and password
  Future<User?> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;
      if (user != null) {
        // Update display name
        await user.updateDisplayName(fullName);

        // Create user document in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'fullName': fullName,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'accountBalance': 0.0,
          'totalTrades': 0,
          'winRate': 0.0,
        });

        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An error occurred during sign up. Please try again';
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'Error signing out. Please try again';
    }
  }

  // Update last login timestamp
  Future<void> updateLastLogin() async {
    final user = currentUser;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        // Silently fail - not critical
        print('Error updating last login: $e');
      }
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    final user = currentUser;
    if (user != null) {
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        return doc.data();
      } catch (e) {
        print('Error getting user data: $e');
        return null;
      }
    }
    return null;
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? fullName,
    String? photoUrl,
  }) async {
    final user = currentUser;
    if (user != null) {
      try {
        if (fullName != null) {
          await user.updateDisplayName(fullName);
          await _firestore.collection('users').doc(user.uid).update({
            'fullName': fullName,
          });
        }
        if (photoUrl != null) {
          await user.updatePhotoURL(photoUrl);
        }
      } catch (e) {
        throw 'Error updating profile: $e';
      }
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Error sending password reset email';
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    final user = currentUser;
    if (user != null) {
      try {
        // Delete user document from Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete user authentication
        await user.delete();
      } catch (e) {
        throw 'Error deleting account: $e';
      }
    }
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      case 'requires-recent-login':
        return 'Please sign in again to perform this action';
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}
