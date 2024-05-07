// Импорт необходимых библиотек
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/presentation/ui/admin_screen.dart';
import 'package:diplome/features/my_event/presentation/ui/home_screen.dart';
import 'package:diplome/features/my_event/presentation/widget/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mssql_connection/mssql_connection.dart';

// Определение класса AuthScreen, который является StatefulWidget
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

// Определение класса _AuthScreenState, который является State<AuthScreen>
class _AuthScreenState extends State<AuthScreen> {
  // Определение переменных для хранения состояния виджетов
  bool isPassHide = true;

  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  // клиент
  // final _addressController =
  //     TextEditingController(text: "Moscow, st. Pushkina, 2");
  // final _loginController = TextEditingController(text: "user");
  // final _mailController = TextEditingController(text: "user@example.org");
  // final _passwordController = TextEditingController(text: "87654321");
  // final _phoneController = TextEditingController(text: "89987654321");
  // int _rolesId = 1;

  // admin
  final _addressController = TextEditingController(text: "-");

  final _loginController = TextEditingController(text: "admin");
  final _mailController = TextEditingController(text: "admin@gmail.com");
  final _passwordController = TextEditingController(text: "admin12345");
  final _phoneController = TextEditingController(text: "88888888888");
  List<RoleModel> _roles = [];
  int _rolesId = 3;
  RoleModel? _selectedRole;

  @override
  void initState() {
    super.initState();
    _loadRoles();
    setState(() {});
  }

  Future<void> _loadRoles() async {
    String query =
        await mssqlConnection.getData("SELECT ID_Roles, Name_Roles FROM Roles");
    List<dynamic> rolesJson = jsonDecode(query);
    setState(() {
      _roles =
          rolesJson.map<RoleModel>((role) => RoleModel.fromJson(role)).toList();
      // _selectedRole = _roles.first;
      _selectedRole = _roles[_rolesId - 1];
      _rolesId = _selectedRole!.idRoles;
    });
  }

  // Определение метода build, который строит виджет AuthScreen
  @override
  Widget build(BuildContext context) {
    // Определение виджетов, которые будут отображаться на экране
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
                      // Определение текстового поля для ввода логина
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
                      // Определение текстового поля для ввода пароля
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
                      // Определение текстового поля для ввода адреса
                      TextFormField(
                        decoration: const InputDecoration(label: Text("Адрес")),
                        controller: _addressController,
                      ),
                      // Определение текстового поля для ввода телефона
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
                      // Определение текстового поля для ввода email
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
                      // Определение выпадающего списка для выбора роли

                      DropdownButtonFormField<RoleModel>(
                        decoration: const InputDecoration(labelText: "Роль"),
                        value: _selectedRole,
                        items: _roles.map<DropdownMenuItem<RoleModel>>((role) {
                          return DropdownMenuItem<RoleModel>(
                            value: role,
                            child: Text(role.nameRoles),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _rolesId = value!.idRoles;
                            _selectedRole = value;
                          });
                        },
                      ),

                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Определение кнопки "Вход"
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
                                switch (_rolesId) {
                                  case 1:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Home(),
                                      ),
                                    );
                                    break;
                                  case 2:
                                    break;
                                  case 3:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminScreen(),
                                      ),
                                    );
                                    break;
                                  default:
                                }
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
                          // Определение кнопки "Регистрация"
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
