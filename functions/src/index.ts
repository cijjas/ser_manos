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

        // Check if data and the 'voluntariados' field exist
        if (!beforeData?.voluntariados || !afterData?.voluntariados) {
            logger.log("No 'voluntariados' field found or data is missing. Exiting.");
            return null;
        }

        // Find the changed voluntariado
        const changedVoluntariado = afterData.voluntariados.find((vAfter: any) => {
            const vBefore = beforeData.voluntariados.find(
                (vb: any) => vb.id === vAfter.id
            );
            // If the voluntariado is new or its state has changed
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
            // We only send notifications for 'accepted' or 'rejected' states
            return null;
        }

        // Get the user's FCM token from the 'after' state data
        const fcmToken = afterData.fcmToken;

        if (!fcmToken) {
            logger.log(`No FCM token for user ${userId}.`);
            return null;
        }

        // TODO falta el deep link ?
        const payload = {
            notification: { title, body },
            data: {
                type: "postulation_status",
                voluntariadoId,
            },
        };

        logger.log(`Sending notification to user ${userId}...`);
        return fcm.sendToDevice(fcmToken, payload);
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

        const payload = {
            notification: {
                title: "¡Nueva noticia! 📰",
                body: newsData.titulo,
            },
            data: {
                type: "news",
                newsId,
            },
        };

        const usersSnapshot = await db.collection("users").get();
        const tokens = usersSnapshot.docs
            .map((doc) => doc.data().fcmToken)
            .filter((token) => token);

        if (tokens.length === 0) {
            logger.log("No users with FCM tokens to send notifications to.");
            return null;
        }

        logger.log(`Sending notification for new news to ${tokens.length} users.`);
        return fcm.sendToDevice(tokens, payload);
    }
);
