import 'package:flutter/material.dart';
import 'package:my_desktop_app/provider/home_provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class CardContractType extends StatelessWidget {
  const CardContractType({
    super.key,
    required this.homeProvider,
    required this.name,
    required this.address, 
    required this.snapshot,
    required this.index,
  });

  final HomeProvider homeProvider;
  final TextEditingController name;
  final TextEditingController address;
  final AsyncSnapshot<List<int>> snapshot;
  final int index; 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            snapshot.data![index].toString(),
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            iconSize: 18,
            splashRadius: 18,
            onPressed: () => homeProvider.removeHourToTheList(
              name.text, 
              address.text,
              snapshot.data![index],
            ), 
            icon: const Icon(
              Icons.highlight_remove_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}