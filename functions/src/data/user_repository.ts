import {
  collection,
  doc,
  getDocs,
  query,
  updateDoc,
  where,
} from "firebase/firestore";
import { firestore } from "./db";
import { User } from "../model/user";

export class UserRepository {
  private static _collection = collection(firestore, "users");

  static getUser = async (email: string): Promise<User | undefined> => {
    const q = query(UserRepository._collection, where("email", "==", email));
    const querySnapshot = await getDocs(q);
    if (querySnapshot.empty) return undefined;
    return querySnapshot.docs[0].data() as User;
  };

  static saveStripeId = async (user: User, stripeCustomerId: string) => {
    await updateDoc(doc(UserRepository._collection, user.id), {
      stripeCustomerId,
    });
  };
}
