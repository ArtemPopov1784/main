import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/client_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/event_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/organisation_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/type_event_card.dart';
import 'package:flutter/material.dart';

import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/client_model.dart';
import 'package:diplome/features/my_event/data/model/event_model.dart';
import 'package:diplome/features/my_event/data/model/organisation_model.dart';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/data/model/type_events_model.dart';
import 'package:diplome/features/my_event/presentation/controller/admin_screen_code.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/account_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/role_card.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  List<AccountModel> accounts = [];
  AdminDataSource adminDataSource = AdminDataSource();
  List<ClientModel> clients = [];
  List<EventModel> events = [];
  List<OrganisationModel> organisations = [];
  List<RoleModel> roles = [];
  List<TypeEventModel> typeEvents = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final rolesData = await adminDataSource.getRoles();
    final accountsData = await adminDataSource.getAccounts();
    final organisationsData = await adminDataSource.getOrganisations();
    final typeEventsData = await adminDataSource.getTypeEvents();
    final clientsData = await adminDataSource.getClients();
    final eventsData = await adminDataSource.getEvents();

    setState(() {
      roles = rolesData;
      accounts = accountsData;
      organisations = organisationsData;
      typeEvents = typeEventsData;
      clients = clientsData;
      events = eventsData;
    });
  }

  void updateRole(RoleModel updatedRole) {
    setState(() {
      final index =
          roles.indexWhere((role) => role.idRoles == updatedRole.idRoles);
      if (index != -1) {
        roles[index] = updatedRole;
      }
      adminDataSource.updateRole(updatedRole);
      fetchData();
    });
  }

  void deleteRole(RoleModel role) {
    setState(() {
      roles.removeWhere((r) => r.idRoles == role.idRoles);
      adminDataSource.deleteRole(role.idRoles);
      fetchData();
    });
  }

  void updateAccount(AccountModel updatedAccount) {
    setState(() {
      final index = accounts.indexWhere(
          (account) => account.idAccount == updatedAccount.idAccount);
      if (index != -1) {
        accounts[index] = updatedAccount;
      }
      adminDataSource.updateAccount(updatedAccount);
      fetchData();
    });
  }

  void deleteAccount(AccountModel account) {
    setState(() {
      accounts.removeWhere((a) => a.idAccount == account.idAccount);
      adminDataSource.deleteAccount(account.idAccount);
      fetchData();
    });
  }

  void updateOrganisation(OrganisationModel updatedOrganisation) {
    setState(() {
      final index = organisations.indexWhere((organisation) =>
          organisation.idOrganisation == updatedOrganisation.idOrganisation);
      if (index != -1) {
        organisations[index] = updatedOrganisation;
      }
      adminDataSource.updateOrganisation(updatedOrganisation);
      fetchData();
    });
  }

  void deleteOrganisation(OrganisationModel organisation) {
    setState(() {
      organisations
          .removeWhere((o) => o.idOrganisation == organisation.idOrganisation);
      adminDataSource.deleteOrganisation(organisation.idOrganisation);
      fetchData();
    });
  }

  void updateTypeEvent(TypeEventModel updatedTypeEvent) {
    setState(() {
      final index = typeEvents.indexWhere((typeEvent) =>
          typeEvent.idTypeEvents == updatedTypeEvent.idTypeEvents);
      if (index != -1) {
        typeEvents[index] = updatedTypeEvent;
      }
      adminDataSource.updateTypeEvent(updatedTypeEvent);
      fetchData();
    });
  }

  void deleteTypeEvent(TypeEventModel typeEvent) {
    setState(() {
      typeEvents.removeWhere((t) => t.idTypeEvents == typeEvent.idTypeEvents);
      adminDataSource.deleteTypeEvent(typeEvent.idTypeEvents);
      fetchData();
    });
  }

  void updateClient(ClientModel updatedClient) {
    setState(() {
      final index = clients
          .indexWhere((client) => client.idClient == updatedClient.idClient);
      if (index != -1) {
        clients[index] = updatedClient;
      }
      adminDataSource.updateClient(updatedClient);
      fetchData();
    });
  }

  void deleteClient(ClientModel client) {
    setState(() {
      clients.removeWhere((c) => c.idClient == client.idClient);
      adminDataSource.deleteClient(client.idClient);
      fetchData();
    });
  }

  void updateEvent(EventModel updatedEvent) {
    setState(() {
      final index =
          events.indexWhere((event) => event.idEvents == updatedEvent.idEvents);
      if (index != -1) {
        events[index] = updatedEvent;
      }
      adminDataSource.updateEvent(updatedEvent);
      fetchData();
    });
  }

  void deleteEvent(EventModel event) {
    setState(() {
      events.removeWhere((e) => e.idEvents == event.idEvents);
      adminDataSource.deleteEvent(event.idEvents);
      fetchData();
    });
  }

  void addRole(RoleModel newRole) {
    setState(() {
      final newId = roles.length + 1;
      final roleWithId =
          RoleModel(idRoles: newId, nameRoles: newRole.nameRoles);
      roles.add(roleWithId);
      adminDataSource.addRole(roleWithId);
      fetchData();
    });
  }

  void addAccount(AccountModel newAccount) {
    setState(() {
      accounts.add(newAccount);
      adminDataSource.addAccount(newAccount);
      fetchData();
    });
  }

  void addOrganisation(OrganisationModel newOrganisation) {
    setState(() {
      organisations.add(newOrganisation);
      adminDataSource.addOrganisation(newOrganisation);
      fetchData();
    });
  }

  void addTypeEvent(TypeEventModel newTypeEvent) {
    setState(() {
      typeEvents.add(newTypeEvent);
      adminDataSource.addTypeEvent(newTypeEvent);
      fetchData();
    });
  }

  void addClient(ClientModel newClient) {
    setState(() {
      clients.add(newClient);
      adminDataSource.addClient(newClient);
      fetchData();
    });
  }

  void addEvent(EventModel newEvent) {
    setState(() {
      events.add(newEvent);
      adminDataSource.addEvent(newEvent);
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Администратор'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(child: FittedBox(child: Text('Роли'))),
              Tab(child: FittedBox(child: Text('Аккаунты'))),
              Tab(child: FittedBox(child: Text('Организации'))),
              Tab(child: FittedBox(child: Text('Типы мероприятий'))),
              Tab(child: FittedBox(child: Text('Клиенты'))),
              Tab(child: FittedBox(child: Text('Мероприятия'))),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RoleTab(
              roles: roles,
              onUpdated: updateRole,
              onDeleted: deleteRole,
              onAddRole: addRole,
              adminDataSource: AdminDataSource(),
            ),
            AccountTab(
              accounts: accounts,
              onUpdated: updateAccount,
              onDeleted: deleteAccount,
              onAddAccount: addAccount,
              roles: roles,
            ),
            OrganisationTab(
              organisations: organisations,
              onUpdated: updateOrganisation,
              onDeleted: deleteOrganisation,
              accounts: accounts,
              onAddOrganisation: addOrganisation,
            ),
            TypeEventTab(
              typeEvents: typeEvents,
              onUpdated: updateTypeEvent,
              onDeleted: deleteTypeEvent,
              onAddTypeEvent: addTypeEvent,
            ),
            ClientTab(
              clients: clients,
              onUpdated: updateClient,
              onDeleted: deleteClient,
              onAddClient: addClient,
              accounts: accounts,
            ),
            EventTab(
              events: events,
              onUpdated: updateEvent,
              onDeleted: deleteEvent,
              onAddEvent: addEvent,
              typeEvents: typeEvents,
              organisations: organisations,
            ),
          ],
        ),
      ),
    );
  }
}

class RoleTab extends StatefulWidget {
  const RoleTab({
    super.key,
    required this.roles,
    required this.onUpdated,
    required this.onDeleted,
    required this.onAddRole,
    required this.adminDataSource,
  });

  final AdminDataSource adminDataSource;
  final ValueChanged<RoleModel> onAddRole;
  final ValueChanged<RoleModel> onDeleted;
  final ValueChanged<RoleModel> onUpdated;
  final List<RoleModel> roles;

  @override
  RoleTabState createState() => RoleTabState();
}

class RoleTabState extends State<RoleTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.roles.map((role) => RoleCard(
                data: role,
                onUpdated: (updatedRole) {
                  setState(() {
                    final index = widget.roles
                        .indexWhere((r) => r.idRoles == updatedRole.idRoles);
                    if (index != -1) {
                      widget.roles[index] = updatedRole;
                    }
                  });
                  widget.adminDataSource.updateRole(updatedRole);
                },
                onDeleted: (role) {
                  widget.onDeleted(role);
                },
                title: role.nameRoles,
              )),
          FloatingActionButton(
            onPressed: () {
              RoleModel newRole = RoleModel(
                idRoles: widget.roles[widget.roles.length - 1].idRoles + 1,
                nameRoles:
                    "${widget.roles[widget.roles.length - 1].nameRoles}copy",
              );
              widget.onAddRole(newRole);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

//

class AccountTab extends StatefulWidget {
  const AccountTab({
    super.key,
    required this.accounts,
    required this.onUpdated,
    required this.onDeleted,
    required this.onAddAccount,
    required this.roles,
  });

  final List<AccountModel> accounts;
  final ValueChanged<AccountModel> onAddAccount;
  final ValueChanged<AccountModel> onDeleted;
  final ValueChanged<AccountModel> onUpdated;
  final List<RoleModel> roles;

  @override
  AccountTabState createState() => AccountTabState();
}

class AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.accounts.map((account) => AccountCard(
                data: account,
                onUpdated: (updatedAccount) {
                  setState(() {
                    final index = widget.accounts.indexWhere(
                        (a) => a.idAccount == updatedAccount.idAccount);
                    if (index != -1) {
                      widget.accounts[index] = updatedAccount;
                    }
                  });
                },
                onDeleted: (account) {
                  widget.onDeleted(account);
                },
                roles: widget.roles,
                onRoleChanged: (RoleModel newRole) {
                  // Update the account's role
                  final updatedAccount = AccountModel(
                    idAccount: account.idAccount,
                    login: account.login,
                    password: account.password,
                    address: account.address,
                    phone: account.phone,
                    mail: account.mail,
                    roleModel: newRole,
                  );
                  widget.onUpdated(updatedAccount);
                },
                title: account.login,
              )),
          FloatingActionButton(
            onPressed: () {
              AccountModel newAccount = AccountModel(
                idAccount:
                    widget.accounts[widget.accounts.length - 1].idAccount + 1,
                login: "${widget.accounts[widget.accounts.length - 1].login}2",
                password:
                    "${widget.accounts[widget.accounts.length - 1].password}2",
                address:
                    "${widget.accounts[widget.accounts.length - 1].address}2",
                phone: widget.accounts[widget.accounts.length - 1].phone,
                mail: "${widget.accounts[widget.accounts.length - 1].mail}2",
                roleModel:
                    widget.accounts[widget.accounts.length - 1].roleModel,
              );
              widget.onAddAccount(newAccount);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

//

class OrganisationTab extends StatefulWidget {
  const OrganisationTab({
    super.key,
    required this.organisations,
    required this.onUpdated,
    required this.onDeleted,
    required this.onAddOrganisation,
    required this.accounts,
  });

  final List<AccountModel> accounts;
  final ValueChanged<OrganisationModel> onAddOrganisation;
  final ValueChanged<OrganisationModel> onDeleted;
  final ValueChanged<OrganisationModel> onUpdated;
  final List<OrganisationModel> organisations;

  @override
  OrganisationTabState createState() => OrganisationTabState();
}

class OrganisationTabState extends State<OrganisationTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.organisations.map((organisation) => OrganisationCard(
                data: organisation,
                onUpdated: (updatedOrganisation) {
                  setState(() {
                    final index = widget.organisations.indexWhere((o) =>
                        o.idOrganisation == updatedOrganisation.idOrganisation);
                    if (index != -1) {
                      widget.organisations[index] = updatedOrganisation;
                    }
                  });
                },
                onDeleted: (organisation) {
                  widget.onDeleted(organisation);
                },
                accounts: widget.accounts,
                onAccountChanged: (AccountModel newAccount) {
                  // Update the organisation's account
                  final updatedOrganisation = OrganisationModel(
                    idOrganisation: organisation.idOrganisation,
                    nameOrganisation: organisation.nameOrganisation,
                    rating: organisation.rating,
                    account: newAccount,
                  );
                  widget.onUpdated(updatedOrganisation);
                },
                title: organisation.nameOrganisation,
              )),
          FloatingActionButton(
            onPressed: () {
              OrganisationModel newOrganisation = OrganisationModel(
                idOrganisation: widget
                        .organisations[widget.organisations.length - 1]
                        .idOrganisation +
                    1,
                nameOrganisation:
                    "${widget.organisations[widget.organisations.length - 1].nameOrganisation}2",
                rating: widget
                    .organisations[widget.organisations.length - 1].rating,
                account: widget
                    .organisations[widget.organisations.length - 1].account,
              );
              widget.onAddOrganisation(newOrganisation);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
//

class TypeEventTab extends StatefulWidget {
  const TypeEventTab({
    super.key,
    required this.typeEvents,
    required this.onUpdated,
    required this.onDeleted,
    required this.onAddTypeEvent,
  });

  final ValueChanged<TypeEventModel> onAddTypeEvent;
  final ValueChanged<TypeEventModel> onDeleted;
  final ValueChanged<TypeEventModel> onUpdated;
  final List<TypeEventModel> typeEvents;

  @override
  TypeEventTabState createState() => TypeEventTabState();
}

class TypeEventTabState extends State<TypeEventTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.typeEvents.map((typeEvent) => TypeEventCard(
                data: typeEvent,
                onUpdated: (updatedTypeEvent) {
                  setState(() {
                    final index = widget.typeEvents.indexWhere(
                        (t) => t.idTypeEvents == updatedTypeEvent.idTypeEvents);
                    if (index != -1) {
                      widget.typeEvents[index] = updatedTypeEvent;
                    }
                  });
                },
                onDeleted: (typeEvent) {
                  widget.onDeleted(typeEvent);
                },
                title: typeEvent.nameTypeEvents,
              )),
          FloatingActionButton(
            onPressed: () {
              TypeEventModel newTypeEvent = TypeEventModel(
                idTypeEvents: widget
                        .typeEvents[widget.typeEvents.length - 1].idTypeEvents +
                    1,
                nameTypeEvents:
                    "${widget.typeEvents[widget.typeEvents.length - 1].nameTypeEvents}copy",
                // Add other properties here
              );
              widget.onAddTypeEvent(newTypeEvent);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
//

class ClientTab extends StatefulWidget {
  const ClientTab({
    super.key,
    required this.clients,
    required this.onUpdated,
    required this.onDeleted,
    required this.onAddClient,
    required this.accounts,
  });

  final List<AccountModel> accounts;
  final List<ClientModel> clients;
  final ValueChanged<ClientModel> onAddClient;
  final ValueChanged<ClientModel> onDeleted;
  final ValueChanged<ClientModel> onUpdated;

  @override
  ClientTabState createState() => ClientTabState();
}

class ClientTabState extends State<ClientTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.clients.map((client) => ClientCard(
                data: client,
                onUpdated: (updatedClient) {
                  setState(() {
                    final index = widget.clients.indexWhere(
                        (c) => c.idClient == updatedClient.idClient);
                    if (index != -1) {
                      widget.clients[index] = updatedClient;
                    }
                  });
                },
                onDeleted: (client) {
                  widget.onDeleted(client);
                },
                accounts: widget.accounts,
                onAccountChanged: (AccountModel newAccount) {
                  // Update the client's account
                  final updatedClient = ClientModel(
                    idClient: client.idClient,
                    firstName: client.firstName,
                    lastName: client.lastName,
                    middleName: client.middleName,
                    account: newAccount,
                  );
                  widget.onUpdated(updatedClient);
                },
                title: '${client.firstName} ${client.lastName}',
              )),
          FloatingActionButton(
            onPressed: () {
              ClientModel newClient = ClientModel(
                idClient:
                    widget.clients[widget.clients.length - 1].idClient + 1,
                firstName:
                    "${widget.clients[widget.clients.length - 1].firstName}2",
                lastName:
                    "${widget.clients[widget.clients.length - 1].lastName}2",
                middleName:
                    "${widget.clients[widget.clients.length - 1].middleName}2",
                account: widget.clients[widget.clients.length - 1].account,
              );
              widget.onAddClient(newClient);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
//

class EventTab extends StatefulWidget {
  const EventTab({
    super.key,
    required this.events,
    required this.onUpdated,
    required this.onDeleted,
    required this.onAddEvent,
    required this.typeEvents,
    required this.organisations,
  });

  final List<EventModel> events;
  final ValueChanged<EventModel> onAddEvent;
  final ValueChanged<EventModel> onDeleted;
  final ValueChanged<EventModel> onUpdated;
  final List<OrganisationModel> organisations;
  final List<TypeEventModel> typeEvents;

  @override
  EventTabState createState() => EventTabState();
}

class EventTabState extends State<EventTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.events.map((event) => EventCard(
                data: event,
                onUpdated: (updatedEvent) {
                  setState(() {
                    final index = widget.events
                        .indexWhere((e) => e.idEvents == updatedEvent.idEvents);
                    if (index != -1) {
                      widget.events[index] = updatedEvent;
                    }
                  });
                },
                onDeleted: (event) {
                  widget.onDeleted(event);
                },
                typeEvents: widget.typeEvents,
                organisations: widget.organisations,
                onTypeEventChanged: (TypeEventModel newTypeEvent) {
                  // Обновляем тип события
                  final updatedEvent = EventModel(
                    idEvents: event.idEvents,
                    nameEvents: event.nameEvents,
                    typeEventModel: newTypeEvent,
                    dateTime: event.dateTime,
                    location: event.location,
                    description: event.description,
                    organisationModel: event.organisationModel,
                    // Добавьте другие поля по необходимости
                  );
                  widget.onUpdated(updatedEvent);
                },
                onOrganisationChanged: (OrganisationModel newOrganisation) {
                  // Обновляем организацию события
                  final updatedEvent = EventModel(
                    idEvents: event.idEvents,
                    nameEvents: event.nameEvents,
                    organisationModel: newOrganisation,
                    dateTime: event.dateTime,
                    location: '',
                    description: '',
                    typeEventModel: event.typeEventModel,
                    // Добавьте другие поля по необходимости
                  );
                  widget.onUpdated(updatedEvent);
                },
                title: event.nameEvents,
              )),
          FloatingActionButton(
            onPressed: () {
              EventModel newEvent = EventModel(
                idEvents: widget.events[widget.events.length - 1].idEvents + 1,
                nameEvents:
                    "${widget.events[widget.events.length - 1].nameEvents}2",
                dateTime:
                    "${widget.events[widget.events.length - 1].dateTime}2",
                location:
                    "${widget.events[widget.events.length - 1].location}2",
                description:
                    "${widget.events[widget.events.length - 1].description}2",
                typeEventModel:
                    widget.events[widget.events.length - 1].typeEventModel,
                organisationModel:
                    widget.events[widget.events.length - 1].organisationModel,
                // Добавьте другие поля по необходимости
              );
              widget.onAddEvent(newEvent);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
