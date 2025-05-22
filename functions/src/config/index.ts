export const project = process.env.FIREBASE_CONFIG
  ? JSON.parse(process.env.FIREBASE_CONFIG).projectId
  : null;
export const location = "europe-west2";
