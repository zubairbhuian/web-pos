import 'package:flutter/material.dart';
import 'package:yogo_pos/app/modules/onlineOrder/models/order_model.dart';
import 'package:yogo_pos/app/widgets/custom_textfield.dart';

class EditNotes extends StatefulWidget {
  final OrderModel order;
  final void Function(String notes) onPressed;
  const EditNotes({super.key, required this.order, required this.onPressed});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  late final TextEditingController _notesController =
      TextEditingController(text: widget.order.notes);
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _notesController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Edit Notes',
          style: theme.textTheme.displaySmall,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          maxLines: 5,
          readOnly: true,
          focusNode: _focusNode,
          controller: _notesController,
        ),
      ],
    );
  }
}
