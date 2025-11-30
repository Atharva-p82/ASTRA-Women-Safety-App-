/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {setGlobalOptions} = require("firebase-functions");
const functions = require("firebase-functions");

// Configure function options
setGlobalOptions({maxInstances: 10});

// Export functions implemented in separate files
// New: export onAlertCreatedSendFcm implemented inline below
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

exports.onAlertCreatedSendFcm = functions.firestore
	.document('alerts/{alertId}')
	.onCreate(async (snap, context) => {
		const alert = snap.data();
		if (!alert) return null;

		const userId = alert.userId;
		const guardiansSnap = await db.collection('guardians').where('userId', '==', userId).get();
		const tokens = [];
		guardiansSnap.forEach(doc => {
			const data = doc.data();
			if (Array.isArray(data.fcmTokens)) {
				tokens.push(...data.fcmTokens);
			}
		});

		if (tokens.length === 0) {
			console.log('No device tokens to notify');
			await snap.ref.update({ status: 'no_tokens' });
			return null;
		}

		const payload = {
			notification: {
				title: 'Emergency SOS Alert',
				body: `${alert.userName || 'A user'} needs help nearby`,
			},
			data: {
				alertId: context.params.alertId,
				userId: userId,
				latitude: String(alert.latitude || ''),
				longitude: String(alert.longitude || ''),
				click_action: 'FLUTTER_NOTIFICATION_CLICK',
			},
		};

		const BATCH = 500;
		for (let i = 0; i < tokens.length; i += BATCH) {
			const batch = tokens.slice(i, i + BATCH);
			const response = await admin.messaging().sendMulticast({
				tokens: batch,
				notification: payload.notification,
				data: payload.data,
			});

			response.responses.forEach((resp, idx) => {
				if (!resp.success) {
					const err = resp.error;
					const badToken = batch[idx];
					console.error('Error sending to token', badToken, err);
					if (err && err.code === 'messaging/registration-token-not-registered') {
						db.collection('guardians').where('fcmTokens', 'array-contains', badToken).get().then(snap => {
							snap.forEach(d => d.ref.update({ fcmTokens: admin.firestore.FieldValue.arrayRemove(badToken) }));
						}).catch(e => console.error('Error removing bad token', e));
					}
				}
			});
		}

		await snap.ref.update({ status: 'notified', notifiedCount: tokens.length });
		return null;
	});
