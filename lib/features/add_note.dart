import 'dart:io';
import 'package:firebase_core/firebase_core.dart' hide FirebaseService;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constant/app_color.dart';
import '../core/localization/app_strings.dart';
import '../data/services/firebase_service.dart';
import '../model/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  final NoteModel? note;

  const AddNoteScreen({
    super.key,
    this.note,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();
  File? selectedImage;
  String? audioFilePath;
  List<Color> availableColors = AppColors.noteColors;
  Color selectedColor = AppColors.noteColors[0];
  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;
  TextDecoration _textDecoration = TextDecoration.none;
  double _fontSize = 16;
  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;

      selectedColor = availableColors[widget.note!.colorIndex];
    }
  }
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
  Future<void> saveNote() async {
    if (titleController.text.trim().isEmpty &&
        contentController.text.trim().isEmpty) {
      return;
    }

    String? imageUrl;

    if (selectedImage != null) {
      imageUrl = await uploadImageToImgBB(selectedImage!);
    }

    final note = NoteModel(
      id: widget.note?.id,
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      imageUrl: imageUrl ?? widget.note?.imageUrl,
      audioUrl: audioFilePath ?? widget.note?.audioUrl,
      colorIndex: AppColors.noteColors.indexOf(selectedColor),
      isPinned: widget.note?.isPinned ?? false,
      createdAt: widget.note?.createdAt ?? Timestamp.now(),
    );

    if (widget.note == null) {
      await firebaseService.addNote(note);
    } else {
      await firebaseService.updateNote(note);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }
  void showColorPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(12),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: availableColors.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: selectedColor == color
                        ? Border.all(color: AppColors.primary, width: 3)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<String?> uploadImageToImgBB(File imageFile) async {
    const apiKey = '9b58b9c23bcfd5619d1b023e931baf9d';

    final url = Uri.parse(
        'https://api.imgbb.com/1/upload?key=$apiKey');

    try {
      final request = http.MultipartRequest('POST', url);

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData =
        await response.stream.bytesToString();

        final jsonResponse = json.decode(responseData);

        return jsonResponse['data']['url'];
      } else {
        debugPrint("Upload Failed ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
  Widget _fontSizeItem(
      double size,
      void Function(void Function()) menuSetState,
      ) {
    return InkWell(
      onTap: () {
        setState(() {
          _fontSize = size;
        });

        menuSetState(() {});
      },
      child: Container(
        width: 50,
        height: 25,
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          color: _fontSize == size
              ? AppColors.primary.withOpacity(.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          size.toInt().toString(),
          style: TextStyle(
            fontSize: 19,
            fontWeight: _fontSize == size
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
        Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? AppColors.dr : AppColors.icon,
            size: 25,
          ),
        ),

        centerTitle: true,

        title: Text(
          AppStrings.tr("add_note"),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.dr : AppColors.title,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () async {
              await saveNote();
            },
            icon: Icon(
              Icons.check,
              color: isDark
                  ? AppColors.dr
                  : AppColors.icon,
              size: 25,
            ),
          ),
        ],
      ),

        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,

                    decoration: InputDecoration(
                      labelText: AppStrings.tr("title"),

                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.dr : AppColors.title,
                      ),

                      hintText: AppStrings.tr("note_title"),

                      hintStyle: const TextStyle(
                        color: AppColors.hint,
                        fontSize: 14,
                      ),

                      floatingLabelBehavior:
                      FloatingLabelBehavior.always,

                      filled: true,

                      fillColor: isDark
                          ? const Color(0xFF202124)
                          : AppColors.cardBackground,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColors.dr
                              : AppColors.border,
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColors.border
                              : AppColors.cardBackground,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColors.dr
                              : AppColors.border,
                        ),
                      ),
                    ),
                  ),

              const SizedBox(height: 20),

                  Expanded(
                    child: TextField(
                      controller: contentController,

                      expands: true,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,

                      style: TextStyle(
                        fontWeight: _fontWeight,
                        fontStyle: _fontStyle,
                        decoration: _textDecoration,
                        fontSize: _fontSize,
                      ),

                      decoration: InputDecoration(
                        hintText: AppStrings.tr("write_something"),

                        hintStyle: const TextStyle(
                          color: AppColors.hint,
                        ),

                        filled: true,
                        fillColor: isDark
                            ? const Color(0xFF202124)
                            : AppColors.cardBackground,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.dr
                                : AppColors.border,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.dr
                                : AppColors.border,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.dr
                                : AppColors.border,
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (selectedImage != null)
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(selectedImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xFF202124): AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? AppColors.dr
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PopupMenuButton<String>(
                      color: isDark ?Color(0xFF202124): AppColors.cardBackground,
                      constraints: const BoxConstraints(
                        minWidth:200,
                      ),
                      offset: const Offset(-48,-50),
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _fontWeight = _fontWeight == FontWeight.bold
                                                ? FontWeight.normal
                                                : FontWeight.bold;
                                          });

                                          menuSetState(() {});
                                        },
                                        icon: Icon(
                                          Icons.format_bold,
                                          color: _fontWeight == FontWeight.bold
                                              ? AppColors.primary
                                              : (isDark ? AppColors.dr : Colors.black),
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _fontStyle = _fontStyle == FontStyle.italic
                                                ? FontStyle.normal
                                                : FontStyle.italic;
                                          });

                                          menuSetState(() {});
                                        },
                                        icon: Icon(
                                          Icons.format_italic,
                                          color: _fontStyle == FontStyle.italic
                                              ? AppColors.primary
                                              : (isDark ? AppColors.dr : Colors.black),
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _textDecoration = _textDecoration ==
                                                TextDecoration.underline
                                                ? TextDecoration.none
                                                : TextDecoration.underline;
                                          });

                                          menuSetState(() {});
                                        },
                                        icon: Icon(
                                          Icons.format_underlined,
                                          color: _textDecoration == TextDecoration.underline
                                              ? AppColors.primary
                                              : (isDark ? AppColors.dr : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                  Text(AppStrings.tr
                                   ( "Font Size"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.dr: AppColors.icon,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Divider(thickness: 1, color: AppColors.body),
                                  const SizedBox(height: 12),

                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      _fontSizeItem(10, menuSetState),
                                      _fontSizeItem(12, menuSetState),
                                      _fontSizeItem(14, menuSetState),
                                      _fontSizeItem(16, menuSetState),
                                      _fontSizeItem(18, menuSetState),
                                      _fontSizeItem(20, menuSetState),
                                      _fontSizeItem(24, menuSetState),
                                      _fontSizeItem(36, menuSetState),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                      child: const Text(
                        "Aa",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.icon,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                        color: AppColors.icon,
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mic_none_rounded,
                        color: AppColors.icon,
                      ),
                    ),

                    IconButton(
                      onPressed: showColorPicker,
                      icon: const Icon(
                        Icons.palette_outlined,
                        color: AppColors.icon,
                      ),
                    ),
                  ],
                ),
              ),          ],
              ),
            ),
        ),
    );
    }
}