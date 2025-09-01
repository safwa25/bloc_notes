class Notes{
final String title;
final String content;   
final String category;
Notes({required this.title, required this.content, required this.category});
}

class NoteState{
final List<Notes> notes;
NoteState({required this.notes});

}