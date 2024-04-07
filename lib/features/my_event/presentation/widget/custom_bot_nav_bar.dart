import 'package:diplome/features/my_event/presentation/ui/home_screen.dart';
import 'package:flutter/material.dart';

class CustomBotNavBar extends StatefulWidget {
  const CustomBotNavBar({super.key});

  @override
  State<CustomBotNavBar> createState() => _CustomBotNavBarState();
}

int id = 0;

class _CustomBotNavBarState extends State<CustomBotNavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomNavigationBar(
        currentIndex: id,
        onTap: (value) {
          id = value;
          switch (value) {
            case 0:
              showOnlyMyEvents = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
              break;
            case 1:
              showOnlyMyEvents = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );

              break;
            default:
          }
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            label: "Все мероприятия",
            icon: Icon(Icons.event),
          ),
          BottomNavigationBarItem(
            label: "Ваши мероприятия",
            icon: Icon(Icons.event_available),
          ),
        ],
      ),
    );
  }
}
