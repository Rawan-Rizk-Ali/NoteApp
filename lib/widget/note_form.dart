import 'dart:io';

import 'package:flutter/material.dart';

class NoteForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  final File? selectedImage;

  final List<Color> availableColors;
  final Color selectedColor;

  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;

  final VoidCallback onPickImage;
  final VoidCallback onShowColorPicker;

  final VoidCallback onBold;
  final VoidCallback onItalic;
  final VoidCallback onUnderline;
  final VoidCallback onClear;

  const NoteForm({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.selectedImage,
    required this.availableColors,
    required this.selectedColor,
    required this.fontWeight,
    required this.fontStyle,
    required this.textDecoration,
    required this.onPickImage,
    required this.onShowColorPicker,
    required this.onBold,
    required this.onItalic,
    required this.onUnderline,
    required this.onClear,
  });

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.titleController,
          decoration: InputDecoration(
            labelText: "Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: TextField(
            controller: widget.contentController,
            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,

            style: TextStyle(
              fontWeight: widget.fontWeight,
              fontStyle: widget.fontStyle,
              decoration: widget.textDecoration,
              fontSize: 16,
            ),

            decoration: InputDecoration(
              hintText: "Write something...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}