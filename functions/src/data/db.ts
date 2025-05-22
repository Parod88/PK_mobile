import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

const connect = () => {
  // You can find this values inside lib/firebase_options.dart

  const app = initializeApp({
    apiKey: process.env.API_KEY,
    appId: process.env.APP_ID,
    messagingSenderId: process.env.MESSAGING_SENDER_ID,
    projectId: process.env.PROJECT_ID,
    databaseURL: process.env.DATABASE_URL,
    storageBucket: process.env.STORAGE_BUCKET,
  });
  const firestore = getFirestore(app);

  return firestore;
};

export const firestore = connect();
