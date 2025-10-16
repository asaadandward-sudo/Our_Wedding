# Wedding Invitation Admin Setup Guide

This guide will help you set up the admin dashboard, notifications, and email functionality for your wedding invitation app.

## 🚀 Quick Setup (Most Secure & Easy)

### 1. Firebase Setup

1. **Enable Firebase Services:**
   ```bash
   # Install Firebase CLI if not already installed
   npm install -g firebase-tools
   
   # Login to Firebase
   firebase login
   
   # Initialize Firebase Functions
   cd firebase-functions
   npm install
   ```

2. **Deploy Cloud Functions:**
   ```bash
   # Deploy the functions
   firebase deploy --only functions
   ```

3. **Set up Email Configuration:**
   ```bash
   # Set your email credentials (use app password for Gmail)
   firebase functions:config:set email.user="your-email@gmail.com"
   firebase functions:config:set email.password="your-app-password"
   ```

### 2. Create Admin Accounts

1. **Create Firebase Auth Users:**
   - Go to Firebase Console → Authentication → Users
   - Add two users: one for groom, one for bride
   - Note down their UIDs

2. **Set up Admin Data:**
   - Update `setup_admin_accounts.js` with actual UIDs and emails
   - Run: `node setup_admin_accounts.js`

### 3. Configure Push Notifications

1. **Android Setup:**
   - Add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.WAKE_LOCK" />
   <uses-permission android:name="android.permission.VIBRATE" />
   ```

2. **iOS Setup:**
   - Add to `ios/Runner/Info.plist`:
   ```xml
   <key>UIBackgroundModes</key>
   <array>
     <string>remote-notification</string>
   </array>
   ```

### 4. Update Email Service URL

1. **Get your Firebase Functions URL:**
   - After deploying functions, you'll get URLs like:
   - `https://your-project-id.cloudfunctions.net/sendGuestNotificationEmail`

2. **Update the URL in your app:**
   - Edit `lib/Core/Services/email_service.dart`
   - Replace `_functionsUrl` with your actual Firebase Functions URL

## 🔐 Security Features

### Admin Access
- **Hidden Access:** Triple-tap the bottom area of the invitation to access admin login
- **Authentication:** Only authenticated admins can view guest messages
- **Role-based:** Separate groom and bride admin accounts

### Data Protection
- **Firestore Rules:** Guests can only create entries, admins can read all
- **Secure Email:** Uses Firebase Functions for email sending (no client-side credentials)
- **Push Notifications:** Topic-based notifications (groom/bride topics)

## 📱 How It Works

### For Guests:
1. Fill out RSVP form
2. Submit message and signature
3. Data saved to Firestore
4. Automatic email sent to groom and bride
5. Push notifications sent to both

### For Admins (Groom/Bride):
1. Triple-tap bottom of invitation screen
2. Login with email/password
3. View all guest messages in card format
4. Real-time updates when new messages arrive
5. Logout when done

## 🛠 Troubleshooting

### Common Issues:

1. **Email not sending:**
   - Check Firebase Functions logs: `firebase functions:log`
   - Verify email configuration: `firebase functions:config:get`
   - Ensure app password is used for Gmail

2. **Push notifications not working:**
   - Check device permissions
   - Verify FCM token is generated
   - Check Firebase Console → Cloud Messaging

3. **Admin login failing:**
   - Verify admin accounts exist in Firestore
   - Check Firebase Auth users are created
   - Ensure UIDs match between Auth and Firestore

### Testing:
1. **Test guest submission:** Submit a test RSVP
2. **Check email:** Verify emails are received
3. **Test admin login:** Try logging in with admin credentials
4. **Test notifications:** Check if push notifications appear

## 📋 Features Included

✅ **Admin Dashboard** - View guest messages in cards  
✅ **Push Notifications** - Real-time alerts for groom and bride  
✅ **Email Notifications** - Beautiful HTML emails with guest details  
✅ **Secure Authentication** - Firebase Auth with role-based access  
✅ **Real-time Updates** - Live refresh of guest messages  
✅ **Responsive Design** - Works on all screen sizes  
✅ **Arabic Support** - Maintains your existing localization  

## 🔄 Next Steps

1. Deploy the Firebase Functions
2. Set up admin accounts
3. Test the complete flow
4. Customize email templates if needed
5. Add any additional features you want

The system is designed to be both secure and easy to use. The admin access is hidden but easily accessible, and all sensitive operations happen server-side through Firebase Functions.
