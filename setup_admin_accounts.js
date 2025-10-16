// Run this script to set up admin accounts in Firebase
// Make sure you have Firebase CLI installed and are logged in
// Run: node setup_admin_accounts.js

const admin = require('firebase-admin');

// Initialize Firebase Admin (you'll need to download your service account key)
const serviceAccount = require('./path-to-your-service-account-key.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://your-project-id.firebaseio.com'
});

const db = admin.firestore();

async function setupAdminAccounts() {
  try {
    // Create admin accounts
    const adminAccounts = [
      {
        uid: 'groom-admin-uid', // Replace with actual UID from Firebase Auth
        email: 'groom@example.com', // Replace with groom's email
        role: 'groom',
        createdAt: new Date()
      },
      {
        uid: 'bride-admin-uid', // Replace with actual UID from Firebase Auth
        email: 'bride@example.com', // Replace with bride's email
        role: 'bride',
        createdAt: new Date()
      }
    ];

    // Add admin accounts to Firestore
    for (const adminAccount of adminAccounts) {
      await db.collection('admins').doc(adminAccount.uid).set(adminAccount);
      console.log(`Created admin account for ${adminAccount.role}: ${adminAccount.email}`);
    }

    // Create wedding info document
    const weddingInfo = {
      groomName: 'Asaad',
      brideName: 'Ward',
      groomEmail: 'groom@example.com', // Replace with actual emails
      brideEmail: 'bride@example.com',
      day: 'Saturday',
      date: 'October 25, 2025',
      time: '9:30 AM',
      quote: 'Two souls, one heart',
      church: 'St. Mary Church',
      city: 'Cairo',
      state: 'Egypt',
      locationDetails: 'Main Hall',
      mapLink: 'https://maps.google.com/...', // Replace with actual map link
      calendarDate: '20251025T093000Z',
      details: 'Join us for our special day',
      logo: 'assets/image/wedding_template_logo.dart.png'
    };

    await db.collection('WeddingInfo').doc('main').set(weddingInfo);
    console.log('Created wedding info document');

    console.log('Setup completed successfully!');
  } catch (error) {
    console.error('Error setting up admin accounts:', error);
  }
}

setupAdminAccounts();
