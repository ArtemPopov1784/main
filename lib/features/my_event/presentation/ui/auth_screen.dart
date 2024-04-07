// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:diplome/features/my_event/presentation/ui/home_screen.dart';
import 'package:diplome/features/my_event/presentation/widget/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mssql_connection/mssql_connection.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isPassHide = true;
  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  final _addressController =
      TextEditingController(text: "Moscow, st. Pushkina, 2");

  final _loginController = TextEditingController(text: "user");
  final _mailController = TextEditingController(text: "user@example.org");
  final _passwordController = TextEditingController(text: "87654321");
  final _phoneController = TextEditingController(text: "89987654321");
  int _rolesId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Авторизация',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    // fields (oh shit)
                    children: [
                      // Login field
                      TextFormField(
                        decoration: const InputDecoration(label: Text("Логин")),
                        controller: _loginController,
                        validator: (value) {
                          if (value!.isEmpty || value.length > 50) {
                            return 'Login must be between 1 and 50 characters long';
                          }
                          return null;
                        },
                      ),
                      // Password field
                      TextFormField(
                        decoration: InputDecoration(
                            label: const Text("Пароль"),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  isPassHide = !isPassHide;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.password))),
                        controller: _passwordController,
                        obscureText: isPassHide,
                        validator: (value) {
                          if (value!.length < 8 || value.length > 128) {
                            return 'Password must be between 8 and 128 characters long';
                          }
                          return null;
                        },
                      ),
                      // Address field
                      TextFormField(
                        decoration: const InputDecoration(label: Text("Адрес")),
                        controller: _addressController,
                      ),
                      // Phone field
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text("Телефон")),
                        controller: _phoneController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (value) {
                          if (value!.length != 11) {
                            return 'Phone number must be 11 digits long';
                          }
                          return null;
                        },
                      ),
                      // Mail field
                      TextFormField(
                        decoration: const InputDecoration(label: Text("Почта")),
                        controller: _mailController,
                        validator: (value) {
                          if (!RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z]+\.[a-zA-Z]+$')
                              .hasMatch(value!)) {
                            return 'Invalid email address';
                          }
                          return null;
                        },
                      ),
                      // Roles dropdown
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: "Роль"),
                        value: _rolesId,
                        items: const [
                          DropdownMenuItem<int>(
                              value: 1, child: Text('Частник')),
                          DropdownMenuItem<int>(
                              value: 2, child: Text('Организация')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _rolesId = value!;
                          });
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              side: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            onPressed: () async {
                              String query = await mssqlConnection.getData("""
                                SELECT * FROM Account WHERE Login = '${_loginController.text}' 
                                AND Password = '${_passwordController.text}' 
                                AND Address = '${_addressController.text}' 
                                AND Phone = '${_phoneController.text}' 
                                AND Mail = '${_mailController.text}' 
                                AND Roles_ID = $_rolesId
                                """);
                              clientID = jsonDecode(query)[0]['ID_Account'];
                              if (query != "[]") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              } else {
                                showErrorDialog(
                                    context, "Авторизация неудачна ☹");
                              }
                            },
                            child: const Text(
                              "Вход",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              side: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            onPressed: () async {
                              try {
                                await mssqlConnection.writeData(
                                    """INSERT INTO Account (Login, Password, Address, Phone, Mail, Roles_ID) VALUES
                                  ('${_loginController.text}', 
                                  '${_passwordController.text}', 
                                  '${_addressController.text}', 
                                  '${_phoneController.text}', 
                                  '${_mailController.text}', 
                                  $_rolesId)""");
                              } catch (e) {
                                showErrorDialog(context, "Регистрация Faild ☹");
                              }
                            },
                            child: const Text(
                              "Регистрация",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
