import 'package:notes_supabase/Models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteDatabase {
  final db = Supabase.instance.client.from('notes');

  // CREATE
  Future createNote(String content, String? imageUrl) async {
    await db.insert({'content': content, 'image_url': imageUrl});
  }

  // READ (REALTIME)
  final stream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id'])
      .map((data) => data.map((e) => Note.fromMap(e)).toList());

  // UPDATE
  Future updateNote(int id, String content, String? imageUrl) async {
    await db.update({'content': content, 'image_url': imageUrl}).eq('id', id);
  }

  // DELETE
  Future deleteNote(int id) async {
    await db.delete().eq('id', id);
  }
}
