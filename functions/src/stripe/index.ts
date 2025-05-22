import Stripe from "stripe";
import { defineSecret } from "firebase-functions/params";

const stripeSecretKey = defineSecret(process.env.STRIPE_SECRET_KEY!);
const endpointSecretKey = defineSecret(process.env.STRIPE_ENDPOINT_SECRET!);

export const stripeFactory = () => new Stripe(stripeSecretKey.value());
export const endpointSecret = () => endpointSecretKey.value();
