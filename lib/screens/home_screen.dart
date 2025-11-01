import 'package:flutter/material.dart';
import 'package:ideas_list_flutter/services/shared_prefs.dart';
import '../widgets/add_button.dart';
import '../widgets/add_idea_dialog.dart';
import '../widgets/idea_card.dart';

class IdeasScreen extends StatefulWidget {
  const IdeasScreen({super.key});

  @override
  State<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _ideas = [];

  @override
  void initState() {
    super.initState();
    _ideas = SharedPrefsService.loadIdeas();
  }

  void _addIdea(String idea) {
    setState(() {
      _ideas.add(idea);
      _listKey.currentState?.insertItem(_ideas.length - 1);
    });
    SharedPrefsService.saveIdeas(_ideas);
  }

  void _editIdea(String idea, int index) {
    setState(() {
      _ideas[index] = idea;
    });
    SharedPrefsService.saveIdeas(_ideas);
  }

  void _deleteIdea(int index) {
    final removed = _ideas.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => FadeTransition(
        opacity: animation,
        child: IdeaCard(text: removed, onEdit: () {}, onDelete: () {}),
      ),
    );
    SharedPrefsService.saveIdeas(_ideas);
  }

  void _openAddDialog([int? index]) {
    showDialog(
      context: context,
      builder: (_) => AddIdeaDialog(
        initialText: index != null ? _ideas[index] : null,
        onSave: (text) {
          if (index != null) {
            _editIdea(text, index);
          } else {
            _addIdea(text);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/idea.jpeg', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 23),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'My ideas',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: _ideas.length,
                      itemBuilder: (context, index, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: IdeaCard(
                            text: _ideas[index],
                            onEdit: () => _openAddDialog(index),
                            onDelete: () => _deleteIdea(index),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () => _openAddDialog(),
      ),
    );
  }
}
