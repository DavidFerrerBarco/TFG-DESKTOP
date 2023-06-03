import 'package:flutter/material.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class AnnouncementButton extends StatefulWidget {
  final String content;
  final Color color;
  final Color borderColor;
  final double offsetX;
  final double offsetY;
  final double width;
  final Function onOptionChanged;
  final String option;
  final AnnouncementProvider announcementProvider;

  const AnnouncementButton({
    super.key,
    required this.content,
    required this.color,
    required this.borderColor,
    required this.offsetX,
    required this.offsetY,
    required this.width,
    required this.onOptionChanged,
    required this.option,
    required this.announcementProvider,
  });

  @override
  State<AnnouncementButton> createState() => _AnnouncementButtonState();
}

class _AnnouncementButtonState extends State<AnnouncementButton> {
  bool isHovered = false;
  void onHovered(bool hovered) => setState(() {
        isHovered = hovered;
      });

  @override
  Widget build(BuildContext context) {
    Offset setOffsetValue() {
      return isHovered
          ? const Offset(0, 0)
          : Offset(widget.offsetX, widget.offsetY);
    }

    Offset offset = setOffsetValue();

    return TextButton(
      onPressed: () {
        widget.announcementProvider.isCreate(true);
        widget.announcementProvider.resetAnnouncementForm();
        widget.onOptionChanged(widget.option);
      },
      child: Container(
        height: 60,
        width: widget.width,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.shadowGreen,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: MouseRegion(
          onHover: (event) => onHovered(true),
          onExit: (event) => onHovered(false),
          child: Transform.translate(
            offset: offset,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.borderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
                color: widget.color,
              ),
              child: Center(
                child: Text(
                  widget.content,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
