import 'package:flutter/material.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  String title;
  String buttonName;
  final NoteModel? note;
  NoteDetailScreen(
      {Key? key, required this.title, this.note, required this.buttonName})
      : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _descriptionController =
          TextEditingController(text: widget.note!.description);
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController!.dispose();
    _descriptionController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<ProviderModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 1),
                  ),
                  labelText: 'Title',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  // label: Text('Title'),
                  hintText: 'write a title',
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 150,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 1),
                    ),
                    labelText: 'Description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // label: Text('Title'),
                    hintText: 'write description',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () async {
                          noteProvider.addOrUpdateNote(
                            id: widget.note != null ? widget.note!.id : null,
                            title: _titleController!.text,
                            description: _descriptionController!.text,
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.buttonName,
                          style: const TextStyle(fontSize: 20),
                        )),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
