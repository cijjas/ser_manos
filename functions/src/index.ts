import {onDocumentCreated, onDocumentUpdated} from "firebase-functions/v2/firestore";
import { initializeApp } from "firebase-admin/app";
import { getMessaging, BatchResponse, SendResponse } from "firebase-admin/messaging"; // Import BatchResponse and SendResponse
import { getFirestore } from "firebase-admin/firestore";

initializeApp();

export const sendPostulationStatusNotification = onDocumentUpdated(
    "users/{userId}",
    async (event) => {
        const before = event.data?.before.data();
        const after = event.data?.after.data();

        if (!before || !after) return;

        const oldVoluntariados = before.voluntariados || [];
        const newVoluntariados = after.voluntariados || [];

        for (const newVol of newVoluntariados) {
            const oldVol = oldVoluntariados.find((v: any) => v.id === newVol.id);
            // Check if status changed or if it's a new entry and status is accepted/rejected
            if (!oldVol || oldVol.estado !== newVol.estado) {
                if (newVol.estado === "accepted" || newVol.estado === "rejected") {
                    const token = after.fcmToken; // Assuming fcmToken is stored directly on the user document
                    if (!token) {
                        console.log(`No FCM token found for user ${event.params.userId}`);
                        return;
                    }

                    const title =
                        newVol.estado === "accepted"
                            ? "¡Postulación aceptada!"
                            : "Tu postulación fue rechazada";
                    // You might want to fetch the voluntariado name here for a better message
                    const body = `Tu postulación para el voluntariado ha sido ${newVol.estado === "accepted" ? "aceptada" : "rechazada"}.`;

                    await getMessaging().send({
                        token,
                        notification: { title, body },
                        data: {
                            type: "postulation_status",
                            voluntariadoId: newVol.id,
                        },
                    });
                    console.log(`Notification sent for postulation status change to ${newVol.estado} for voluntariado ${newVol.id} to user ${event.params.userId}`);
                }
            }
        }
    }
);

export const sendNewsNotification = onDocumentCreated(
    "novedades/{novedadId}",
    async (event) => {
        const novedad = event.data?.data();

        if (!novedad) {
            console.log("No news data found for the created document.");
            return;
        }

        const newsId = event.params.novedadId;
        const title = "¡Nueva Noticia!";
        const body = novedad.titulo || "Descubre las últimas novedades.";

        const firestore = getFirestore();
        const usersSnapshot = await firestore.collection('users').get();
        const tokens: string[] = [];

        usersSnapshot.forEach(doc => {
            const userData = doc.data();
            if (userData.fcmToken) {
                tokens.push(userData.fcmToken);
            }
        });

        if (tokens.length === 0) {
            console.log("No FCM tokens found to send news notification.");
            return;
        }

        const message = {
            notification: { title, body },
            data: {
                type: "news",
                newsId: newsId,
            },
        };

        try {
            const response: BatchResponse = await getMessaging().sendEachForMulticast({ tokens, ...message });
            console.log(`Successfully sent news notification to ${response.successCount} devices, failed on ${response.failureCount} devices.`);

            // Correct way to get failed tokens
            if (response.failureCount > 0) {
                const failedTokens: string[] = [];
                response.responses.forEach((resp: SendResponse, index: number) => {
                    if (!resp.success) {
                        // The index in responses corresponds to the index in the original tokens array
                        failedTokens.push(tokens[index]);
                    }
                });
                console.log('List of tokens that caused failures:', failedTokens);
            }
        } catch (error) {
            console.error("Error sending news notification:", error);
        }
    }
);