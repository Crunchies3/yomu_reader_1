import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yomu_reader_1/my_classes/services/firestore.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final FireStoreService fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("History"),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: StreamBuilder(
            stream: fireStoreService.getMangaHistory(),
            builder: (context, snapshot) {
              
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.data == null) {
                return const Text("No Data");
              }

              final mangas = snapshot.data!.docs;

              return ListView.builder(
                itemCount: mangas.length,
                itemBuilder: (context, index){
                  final manga = mangas[index];

                  return ListTile(
                    title: Text(manga['manga_title']),
                  );
                },
              );







            },
          )
        )
    );
  }
}
