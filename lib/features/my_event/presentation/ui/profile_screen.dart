import 'package:flutter/material.dart';
import 'package:mssql_connection/mssql_connection.dart';

import 'package:diplome/features/my_event/presentation/ui/home_screen.dart';

int clientID = 0;

final TextEditingController firstName = TextEditingController();
final TextEditingController middleName = TextEditingController();
final TextEditingController lastName = TextEditingController();
final TextEditingController login = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController address = TextEditingController();
final TextEditingController phone = TextEditingController();
final TextEditingController mail = TextEditingController();
final TextEditingController role = TextEditingController();

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required query});

  final String query = "";

  final MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          },
          icon: const Icon(Icons.keyboard_return),
        ),
        title: const Text("Личный кабинет"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ФИО
            Text(""),
            Text(""),
            Text(""),
            //  логин
            Text(""),
            // пароль
            Text(""),
            // адрес
            Text(""),
            // телефон
            Text(""),
            // почта
            Text(""),
            // роль
            Text(""),

            IconButton(
              onPressed: () {
                mssqlConnection.writeData("""
                DELETE a, eh, ep, o, c
                FROM Account a
                LEFT JOIN Events_History eh ON a.ID_Account = eh.Account_ID
                LEFT JOIN Event_Participants ep ON a.ID_Account = ep.ID_Client
                LEFT JOIN Organisation o ON a.ID_Account = o.Account_ID
                LEFT JOIN Client c ON a.ID_Account = c.Account_ID
                WHERE a.ID_Client = '$clientID';
                """);
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }
}

void init() {}
