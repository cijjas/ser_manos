/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { onDocumentUpdated, onDocumentCreated } from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";
import { logger } from "firebase-functions";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

/**
 * Sends a notification when a user's application status for a "voluntariado" changes.
 * This function uses the v2 syntax.
 */
export const onVoluntariadoApplicationChange = onDocumentUpdated(
    {
        document: "users/{userId}",
        region: "southamerica-east1"
    },
    async (event) => {
        const beforeData = event.data?.before.data();
        const afterData = event.data?.after.data();
        const userId = event.params.userId;

        if (!beforeData?.voluntariados || !afterData?.voluntariados) {
            logger.log("No 'voluntariados' field found or data is missing. Exiting.");
            return null;
        }

        const changedVoluntariado = afterData.voluntariados.find((vAfter: any) => {
            const vBefore = beforeData.voluntariados.find((vb: any) => vb.id === vAfter.id);
            return !vBefore || vBefore.estado !== vAfter.estado;
        });

        if (!changedVoluntariado) {
            logger.log("No change in voluntariado status detected.");
            return null;
        }

        const { id: voluntariadoId, estado } = changedVoluntariado;
        let title = "";
        let body = "";

        if (estado === "accepted") {
            title = "¡Felicitaciones! 🎉";
            body = "Tu postulación al voluntariado ha sido aceptada.";
        } else if (estado === "rejected") {
            title = "Novedades sobre tu postulación";
            body = "Tu postulación al voluntariado ha sido rechazada.";
        } else {
            return null;
        }

        const fcmToken = afterData.fcmToken;

        if (!fcmToken) {
            logger.log(`No FCM token for user ${userId}.`);
            return null;
        }

        const message = {
            tokens: [fcmToken],
            notification: { title, body },
            data: {
                type: "postulation_status",
                voluntariadoId,
            },
        };

        logger.log(`Sending notification to user ${userId}...`);
        const response = await fcm.sendEachForMulticast(message);

        const result = response.responses[0];
        if (!result.success) {
            logger.error(`Error sending notification: ${result.error?.message}`);
            if (
                result.error?.code === "messaging/invalid-argument" ||
                result.error?.code === "messaging/registration-token-not-registered"
            ) {
                await db.collection("users").doc(userId).update({
                    fcmToken: admin.firestore.FieldValue.delete(),
                });
                logger.log(`Deleted invalid FCM token for user ${userId}`);
            }
        }

        return null;
    }
);



/**
 * Sends a notification to all users when a new "noticia" (news) is created.
 * This function uses the v2 syntax.
 */
export const onNewNoticia = onDocumentCreated(
    {
        document: "novedades/{newsId}",
        region: "southamerica-east1"
    },
    async (event) => {
        const newsData = event.data?.data();
        const newsId = event.params.newsId;

        if (!newsData) {
            logger.log("No data for the new news item.");
            return null;
        }

        const usersSnapshot = await db.collection("users").get();
        const tokens = usersSnapshot.docs
            .map((doc) => ({ token: doc.data().fcmToken, doc }))
            .filter(({ token }) => !!token);

        if (tokens.length === 0) {
            logger.log("No users with FCM tokens to send notifications to.");
            return null;
        }

        const message = {
            tokens: tokens.map((t) => t.token),
            notification: {
                title: "¡Nueva noticia! 📰",
                body: newsData.titulo,
            },
            data: {
                type: "news",
                newsId,
            },
        };

        logger.log(`Sending notification to ${tokens.length} users.`);
        const response = await fcm.sendEachForMulticast(message);

        const failedTokens: string[] = [];

        response.responses.forEach((res, idx) => {
            if (!res.success) {
                const token = tokens[idx].token;
                const docRef = tokens[idx].doc.ref;

                logger.error(`Failed to send to ${token}: ${res.error?.message}`);
                if (
                    res.error?.code === "messaging/invalid-argument" ||
                    res.error?.code === "messaging/registration-token-not-registered"
                ) {
                    failedTokens.push(token);
                    docRef.update({ fcmToken: admin.firestore.FieldValue.delete() });
                    logger.log(`Removed invalid token from user ${docRef.id}`);
                }
            }
            else{
                const token = tokens[idx].token;
                const docRef = tokens[idx].doc.ref;
                logger.log(`successfull message to ${docRef.id}` );
            }
        });

        return null;
    }
);

