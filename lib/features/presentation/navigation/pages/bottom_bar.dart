import 'package:flutter/material.dart';
import 'package:my_restaurant/common/hex_color.dart';
import 'package:my_restaurant/features/presentation/account/pages/account_page.dart';
import 'package:my_restaurant/features/presentation/home/pages/restaurant_page.dart';
import 'package:my_restaurant/features/presentation/livenear/pages/live_near_page.dart';
import 'package:my_restaurant/features/presentation/offline/pages/offline_page.dart';

import '../../home/pages/hospital_page.dart';

class BottomBar extends StatelessWidget {
  BottomBar({Key? key}) : super(key: key);

  static ValueNotifier listen = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final List<Widget> tab = [
      HospitalPage(),
      RestaurantPage(),
      LiveNearPage(),
      OfflinePage(),
      AccountPage()
    ];
    return ValueListenableBuilder(
      valueListenable: listen,
      builder: (_, value, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: tab[value],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: getColorFromHex(bgColorBlack),
            unselectedItemColor: Colors.blue,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_hospital_rounded,
                  ),
                  label: 'Hospital'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.restaurant_menu,
                  ),
                  label: 'Restaurant'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.location_on,
                  ),
                  label: 'Livenear'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.catching_pokemon_sharp), label: 'Offline'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Account')
            ],
            currentIndex: value,
            onTap: (select) {
              listen.value = select;
            },
          ),
        );
      },
    );
  }
}
