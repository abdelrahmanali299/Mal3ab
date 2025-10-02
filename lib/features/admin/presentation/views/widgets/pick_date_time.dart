import 'package:flutter/material.dart';

class PickDateTime extends StatefulWidget {
  const PickDateTime({
    super.key,
    required this.onDateSelected,
    required this.lastMatchDate,
  });
  final ValueChanged<DateTime> onDateSelected;
  final DateTime lastMatchDate;
  @override
  State<PickDateTime> createState() => _PickDateTimeState();
}

class _PickDateTimeState extends State<PickDateTime> {
  DateTime? selectedDate;
  @override
  void initState() {
    selectedDate = widget.lastMatchDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        selectedDate = await showDatePicker(
          context: context,
          firstDate: widget.lastMatchDate,
          lastDate: widget.lastMatchDate.add(const Duration(days: 365)),
          initialDate: selectedDate ?? widget.lastMatchDate,
        );
        widget.onDateSelected(selectedDate!);
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue.withValues(alpha: .3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text(
              '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year} ${selectedDate?.hour}:${selectedDate?.minute}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
