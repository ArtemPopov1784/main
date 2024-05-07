// ignore_for_file: type_literal_in_constant_pattern

import 'dart:developer';

import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/account_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/client_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/event_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/organisation_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/role_card.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/type_event_card.dart';
import 'package:flutter/material.dart';

abstract class BaseCard<T> extends StatefulWidget {
  const BaseCard({
    super.key,
    required this.data,
    required this.onDeleted,
    required this.onUpdated,
    required this.title,
  });

  final T data;
  final Function(T) onDeleted;
  final Function(T) onUpdated;
  final String title;

  @override
  BaseCardState<T> createState() => BaseCardState<T>();

  void onUpdatePressed();

  List<Widget> getFields(BuildContext context);
}

class BaseCardState<T> extends State<BaseCard<T>> {
  late String title;

  late T _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            // title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.getFields(context),
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('Изменить'),
                onPressed: () {
                  switch (widget.runtimeType) {
                    case RoleCard:
                      (widget as RoleCard).updateData();
                      setState(() {});
                      break;
                    case AccountCard:
                      (widget as AccountCard).updateData();
                      setState(() {});
                      break;
                    case ClientCard:
                      (widget as ClientCard).updateData();
                      setState(() {});
                      break;
                    case EventCard:
                      (widget as EventCard).updateData();
                      setState(() {});
                      break;
                    case OrganisationCard:
                      (widget as OrganisationCard).updateData();
                      setState(() {});
                      break;
                    case TypeEventCard:
                      (widget as TypeEventCard).updateData();
                      setState(() {});
                      break;
                    default:
                      log("error");
                      break;
                  }
                },
              ),
              TextButton(
                child: const Text('Удалить'),
                onPressed: () {
                  widget.onDeleted(_data);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
