import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

DropdownButtonFormField<String> customDropdownButtonFormField(
  String hour,
  int index,
  IconData icon,
  Function onSelected,
) {
  return DropdownButtonFormField(
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        borderSide: BorderSide(
          width: 1,
          color: AppTheme.primary,
        ),
      ),
    ),
    isExpanded: true,
    value: listahorasdefault.contains(hour) ? hour : listahorasdefault[index],
    onChanged: (item) => onSelected(item),
    items: listahorasdefault
        .map(
          (item) => DropdownMenuItem<String>(
            value: item,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  item.toString(),
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        )
        .toList(),
  );
}
