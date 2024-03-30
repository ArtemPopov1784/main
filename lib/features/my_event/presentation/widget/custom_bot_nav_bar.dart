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
          // print(value);
          id = value;
          switch (value) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
              break;
            case 1:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => EventInfoScreen(
              //         car: EventModel(
              //             city_mpg: 1,
              //             car_class: "car_class",
              //             combination_mpg: 1,
              //             cylinders: 1,
              //             displacement: 1,
              //             drive: "drive",
              //             fuel_type: "fuel_type",
              //             highway_mpg: 1,
              //             make: "make",
              //             model: "model",
              //             transmission: "transmission",
              //             year: 1),
              //         index: 0),
              //   ),
              // );
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
