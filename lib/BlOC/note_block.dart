import 'note_events.dart';
import 'note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBlock extends Bloc<NoteEvents,NoteState>{
  NoteBlock():super(NoteState(notes:List.empty())){
    on<Add>((event, emit) {
      final newNote=Notes(title: event.title, content: event.content, category: event.category);
      final updatedNotes=List<Notes>.from(state.notes)..add(newNote);
      emit(NoteState(notes: updatedNotes));
    });
    on<Remove>((event, emit) {
      final updatedNotes=List<Notes>.from(state.notes)..removeAt(event.index);
      emit(NoteState(notes: updatedNotes));
    });
  }
  
}