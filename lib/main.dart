import 'package:brick_core/core.dart';
import 'package:flutter/material.dart';
import 'package:offline_first/brick/repository.dart';
import 'package:offline_first/models/note.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Repository.configure(databaseFactory);
  // .initialize() does not need to be invoked within main()
  // It can be invoked from within a state manager or within
  // an initState()
  await Repository().initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final Stream<List<Note>> notesStream = Repository().subscribe<Note>();

  @override
  void initState() {
    super.initState();

    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      Supabase.instance.client.auth.signInAnonymously();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder(
          stream: notesStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].content),
                    trailing: IconButton(
                      onPressed: () {
                        Repository().delete<Note>(snapshot.data![index]);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              );
            }
            return Center(child: const Text("No Notes"));
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Repository().upsert<Note>(
              Note(
                content: 'New Note',
                createdAt: DateTime.now().toIso8601String(),
              ),
            );
          },
        ),
      ),
    );
  }
}
