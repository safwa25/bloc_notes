import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BlOC/note_block.dart';
import 'BlOC/note_events.dart';
import 'BlOC/note_state.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {  
    return BlocProvider(
      create: (context) => NoteBlock(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NotesPage(),
      ),
    );
  }
}
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _editTitle = TextEditingController();
  final TextEditingController _editDiscription = TextEditingController();
  final List<String> _dropdownItems = ['Work', 'Personal', 'Shopping', 'Others'];
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    final noteBlock=BlocProvider.of<NoteBlock>(context);

    return Scaffold(
      appBar:AppBar(title: const Text('Notes App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _editTitle,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _editDiscription,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Discription',
              ),
            ),
          ),
          DropdownButton(
            value:_selectedItem,
            hint: const Text('Select Category'),
            items: _dropdownItems.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
            },
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if(_editTitle.text.isNotEmpty && _editDiscription.text.isNotEmpty && _selectedItem!=null){
                  noteBlock.add(Add(title: _editTitle.text, content: _editDiscription.text, category: _selectedItem!));
                  _editTitle.clear();
                  _editDiscription.clear();
                  setState(() {
                    _selectedItem=null;
                  });
                }
              },
              child: const Text('Add Note'),
            ),
          ),
          Expanded(
            child: BlocBuilder<NoteBlock, NoteState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(note.content),
                            const SizedBox(height: 4),
                            Text('Category: ${note.category}', style: const TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red,),
                          onPressed: () {
                            noteBlock.add(Remove(index: index));
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}