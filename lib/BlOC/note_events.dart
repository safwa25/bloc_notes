abstract class NoteEvents {}
 
class Add extends NoteEvents {
  final String title;
  final String content;
  final String category;
  Add({required this.title, required this.content, required this.category});
}

class Remove extends NoteEvents {
  final int index;
  Remove({required this.index});
}