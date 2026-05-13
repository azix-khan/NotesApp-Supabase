import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_supabase/Auth/auth_service.dart';
import 'package:notes_supabase/Models/note.dart';
import 'package:notes_supabase/Services/upload_image_service.dart';

import '../../Database/note_database.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final noteDatabase = NoteDatabase();
  final textController = TextEditingController();
  final authService = AuthService();

  final imageService = UploadImageService();

  File? selectedImage;
  String? uploadedImageUrl;

  // PICK IMAGE
  Future<void> pickImage(StateSetter setStateDialog) async {
    final file = await imageService.pickImage();
    if (file == null) return;

    setStateDialog(() {
      selectedImage = file;
    });
  }

  // CREATE NOTE
  void createNote() {
    selectedImage = null;
    uploadedImageUrl = null;
    textController.clear();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("New Note"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(hintText: "Enter note"),
                ),

                const SizedBox(height: 10),

                if (selectedImage != null)
                  Image.file(selectedImage!, height: 150),

                TextButton(
                  onPressed: () => pickImage(setStateDialog),
                  child: const Text("Pick Image"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                  selectedImage = null;
                  uploadedImageUrl = null;
                },
                child: const Text("Cancel"),
              ),

              TextButton(
                onPressed: () async {
                  // ✅ UPLOAD IMAGE HERE (ONLY ON SAVE)
                  if (selectedImage != null) {
                    uploadedImageUrl = await imageService.uploadImage(
                      selectedImage!,
                    );
                  }

                  await noteDatabase.createNote(
                    textController.text,
                    uploadedImageUrl,
                  );

                  Navigator.pop(context);

                  textController.clear();
                  selectedImage = null;
                  uploadedImageUrl = null;
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }

  // UPDATE NOTE
  void updateNote(Note note) {
    textController.text = note.content;
    uploadedImageUrl = note.imageUrl;
    selectedImage = null;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("Update Note"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: textController),

                const SizedBox(height: 10),

                if (note.imageUrl != null)
                  Image.network(note.imageUrl!, height: 150, fit: BoxFit.cover),

                TextButton(
                  onPressed: () => pickImage(setStateDialog),
                  child: const Text("Change Image"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
                child: const Text("Cancel"),
              ),

              TextButton(
                onPressed: () async {
                  // upload new image if selected
                  if (selectedImage != null) {
                    uploadedImageUrl = await imageService.uploadImage(
                      selectedImage!,
                    );
                  }

                  await noteDatabase.updateNote(
                    note.id,
                    textController.text,
                    uploadedImageUrl,
                  );

                  Navigator.pop(context);

                  textController.clear();
                  selectedImage = null;
                  uploadedImageUrl = null;
                },
                child: const Text("Update"),
              ),
            ],
          );
        },
      ),
    );
  }

  // DELETE NOTE
  void deleteNote(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await noteDatabase.deleteNote(id);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder<List<Note>>(
        stream: noteDatabase.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.content, style: const TextStyle(fontSize: 16)),

                      const SizedBox(height: 10),

                      if (note.imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            note.imageUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => updateNote(note),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteNote(note.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
