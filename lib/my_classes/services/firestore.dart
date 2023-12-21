import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference library =
      FirebaseFirestore.instance.collection('manga_library');
  final CollectionReference history =
      FirebaseFirestore.instance.collection('manga_history');

  Future<void> addUser(UserCredential userCredential, String username) {
    return users
        .doc(userCredential.user!.email)
        .set({'email': userCredential.user!.email, 'username': username});
  }

  Future<DocumentSnapshot<Object?>> getCurrentUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return await users.doc(currentUser!.email).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMangaHistory()  {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return history.doc(currentUser!.email).collection('manga').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMangaLibrary()  {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return library.doc(currentUser!.email).collection('manga').snapshots();
  }



  Future<void> addMangaToLibrary(String userEmail, String mangaId, currentChap,
      chapterIds, author, description, status, mangaTitle, chapterTitle, url) {
    return library.doc(userEmail).collection('manga').doc(mangaId).set({
      'chapter_ids': chapterIds,
      'date_opened': DateTime.timestamp(),
      'manga_author': author,
      'manga_description': description,
      'manga_status': status,
      'manga_title': mangaTitle,
      'recent_chapter': currentChap,
      'chapter_title': "Chapter $chapterTitle",
      'manga_id': mangaId,
      'cover_link' : url
    });
  }

  Future<void> removeMangaFromLibrary(String userEmail, String mangaId) {
    return library.doc(userEmail).collection('manga').doc(mangaId).delete();
  }



  Future<void> addMangaToHistory(String userEmail, String mangaId, currentChap,
      chapterIds, author, description, status, mangaTitle, chapterTitle, url) {
    return history.doc(userEmail).collection('manga').doc(mangaId).set({
      'chapter_ids': chapterIds,
      'date_opened': DateTime.timestamp(),
      'manga_author': author,
      'manga_description': description,
      'manga_status': status,
      'manga_title': mangaTitle,
      'recent_chapter': currentChap,
      'chapter_title': "Chapter $chapterTitle",
      'manga_id': mangaId,
      'cover_link' : url
    });
  }
}
