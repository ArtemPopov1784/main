import 'package:diplome/features/my_event/presentation/ui/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:diplome/features/my_event/presentation/controller/home_screen_code.dart';
import 'package:diplome/features/my_event/presentation/ui/auth_screen.dart';
import 'package:diplome/features/my_event/presentation/widget/custom_bot_nav_bar.dart';
import 'package:diplome/features/my_event/presentation/widget/event_card.dart';

final TextEditingController searchController = TextEditingController();

int clientID = 0;

bool showOnlyMyEvents = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBotNavBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    query: null,
                  ),
                ),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ),
            );
          },
          icon: const Icon(Icons.keyboard_return),
        ),
        title: const Text("Мероприятия"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {
                      searchController.text = "1";
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear)),
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      eventInit();
                      setState(() {});
                    },
                  ),
                ),
                label: const Text("Поиск по мероприятию"),
              ),
              controller: searchController,
              onChanged: (value) {},
              onSubmitted: (value) {
                setState(() {});
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: eventInit(),
                builder: (context, snapshot) {
                  eventInit();
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return EventCard(
                          index: index,
                          eventParticipantModel: snapshot.data![index],
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
