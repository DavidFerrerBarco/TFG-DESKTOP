import 'package:flutter/material.dart';

class HomeDrawerItem extends StatefulWidget {

  final String content;
  final Color color;
  final Color borderColor;
  final String lockedOption;
  final Function onLockedChange;
  final double offsetX;
  final double offsetY;


  const HomeDrawerItem({
    super.key, 
    required this.content, 
    required this.color, 
    required this.borderColor, 
    required this.lockedOption, 
    required this.onLockedChange, 
    required this.offsetX, 
    required this.offsetY,
  });

  @override
  State<HomeDrawerItem> createState() => _HomeDrawerItemState();
}

class _HomeDrawerItemState extends State<HomeDrawerItem> {

  bool isHovered = false;
  void onHovered(bool hovered) => setState(() {
    isHovered = hovered;
  });

  @override
  Widget build(BuildContext context) {

    Offset setOffsetValue(){
      return widget.content == widget.lockedOption || isHovered
        ? const Offset(0, 0)
        : Offset(widget.offsetX, widget.offsetY);
    }
    
    Offset offset = setOffsetValue();

    return TextButton(
      onPressed: () => widget.onLockedChange(widget.content),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
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
