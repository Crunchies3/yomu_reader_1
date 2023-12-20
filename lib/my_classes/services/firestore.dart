import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference library = FirebaseFirestore.instance.collection('manga_library');
  final CollectionReference history = FirebaseFirestore.instance.collection('manga_history');


  Future<void> addUser(UserCredential userCredential, String username){
    return users.doc(userCredential.user!.email).set({
      'email':userCredential.user!.email,
      'username':username
    });
  }

  Future<DocumentSnapshot<Object?>> getCurrentUserDetails() async{
    User? currentUser = FirebaseAuth.instance.currentUser;
    return await users.doc(currentUser!.email).get();
  }

  Future<void> addMangaToHistory(String userEmail, String mangaId ){
    return history.doc(userEmail).collection('manga').doc(mangaId).set(
      {
        'chapter_ids[]': ["d8a959f7-648e-4c8d-8f23-f1f3f8e129f3","d8a959f7-648e-4c8d-8f23-f1f3f8e129f3"],
        'date_opened' : DateTime.timestamp(),
        'manga_author' : "Cyril",
        'manga_description' : "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
        'manga_status' : "completed",
        'manga_title' : "Wan Pes",
        'recent_chapter' : "10"
      }
    );
  }






}