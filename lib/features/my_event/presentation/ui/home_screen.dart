// import 'package:dio/dio.dart';
// import 'package:diplome/di/service.dart';
import 'dart:ffi';

import 'package:diplome/features/my_event/data/model/event_model.dart';
import 'package:diplome/features/my_event/presentation/widget/custom_bot_nav_bar.dart';
import 'package:diplome/features/my_event/presentation/widget/event_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mssql_connection/mssql_connection.dart';

final TextEditingController searchController = TextEditingController();

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  Future<List<EventModel>> init() async {
    try {
      searchController.text == "" ? searchController.text = "Concert1" : null;
      final data = await mssqlConnection.getData("""
                                SELECT * FROM Events WHERE Name_Events = '${searchController.text}'
                                """);
      print(data);
      // await service<Dio>()
      //     .get('cars?limit=50&model=${searchController.text}');
      return (data as List)
          .map(
            (json) => EventModel.fromJson(json),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBotNavBar(),
      appBar: AppBar(
        title: const Text("Все мероприятия"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
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
                future: init(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount:
                          // int.parse(await mssqlConnection.getData("""
                          //           SELECT * FROM Events WHERE Name_Events = '${searchController.text}'
                          //           """))
                          snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return EventCard(
                          index: index,
                          event: snapshot.data![index],
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
