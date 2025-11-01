import 'package:flutter/material.dart';

class AddIdeaDialog extends StatelessWidget {
  final String? initialText;
  final Function(String) onSave;

  const AddIdeaDialog({super.key, this.initialText, required this.onSave});

  @override
  Widget build(BuildContext context) {
    String newIdea = initialText ?? '';
    final controller = TextEditingController(text: initialText);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  initialText == null ? 'Add idea' : 'Edit idea',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter idea',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  onChanged: (value) => newIdea = value.trim(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (newIdea.isNotEmpty) onSave(newIdea);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showAddIdeaDialog(BuildContext context, Function(String) onSave) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 150),
    pageBuilder: (_, _, _) {
      return Scaffold(
        backgroundColor: Colors.black45,
        resizeToAvoidBottomInset: false,
        body: AddIdeaDialog(onSave: onSave),
      );
    },
  );
}
