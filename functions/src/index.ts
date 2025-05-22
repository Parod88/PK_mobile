import "dotenv/config";
import { onRequest } from "firebase-functions/v2/https";
import { setGlobalOptions } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { stripePaymentHandler } from "./functions/stripePayment";
import { stripeWebhooksHandler } from "./functions/stripeWebhooks";
import { onDocumentWritten } from "firebase-functions/v2/firestore";
import { onWriteBookingHandler } from "./functions/onWriteBooking";
import { readQrCode } from "./functions/readQrCode";

admin.initializeApp({ credential: admin.credential.applicationDefault() });

setGlobalOptions({ maxInstances: 10, region: "europe-west2" });
const STRIPE_SECRET_KEY = process.env.STRIPE_SECRET_KEY;
const STRIPE_ENDPOINT_SECRET = process.env.STRIPE_ENDPOINT_SECRET;

if (!STRIPE_SECRET_KEY || !STRIPE_ENDPOINT_SECRET)
  throw Error("Missing required env variables");

export const stripePayment = onRequest(
  { secrets: [STRIPE_SECRET_KEY] },
  stripePaymentHandler
);

export const stripeWebhooks = onRequest(
  { secrets: [STRIPE_ENDPOINT_SECRET] },
  stripeWebhooksHandler
);

export const passQrCode = onRequest(readQrCode);

export const onWriteBooking = onDocumentWritten(
  { secrets: [STRIPE_SECRET_KEY], document: "bookings/{id}" },
  onWriteBookingHandler
);
