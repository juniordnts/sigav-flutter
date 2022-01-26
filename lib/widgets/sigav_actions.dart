// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sigav_app/screens/meet_add_page.dart';
import 'package:sigav_app/widgets/sigav_button.dart';

class SigavPresence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.lock_open,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Presença de aula",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: SigavButton(
                    title: "Aberta",
                    action: () {},
                  ),
                ),
                Container(
                  width: 10,
                ),
                Expanded(
                  child: SigavButton(
                    title: "Fechada",
                    action: () {},
                    secondary: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//

class SigavPresenceList extends StatelessWidget {
  const SigavPresenceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.format_list_numbered,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Lista de presença",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.blue.shade400,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("João Fulano Pereira",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black54)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.blue.shade400,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Luiza Batista",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black54)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.remove_circle,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Felipe Coisinha",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black54)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.remove_circle,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Maria Fulana da Silva",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black54)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//

class SigavSurvey extends StatelessWidget {
  const SigavSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.ballot,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Enquete",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Pergunta",
                  hintStyle: TextStyle(color: Colors.black26),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black26)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black38))),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Resposta",
                        hintStyle: TextStyle(color: Colors.black26),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black26)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black38))),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SigavCircleIcon(
                    blue: true,
                    action: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Resposta",
                      hintStyle: TextStyle(color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black38))),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SigavCircleIcon(
                  blue: true,
                  action: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: SigavButton(
                title: "Adicionar",
                action: () {
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}

//
//
//

class SigavQuestion extends StatelessWidget {
  const SigavQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.note,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Adicionar quetão",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Questão",
                  hintStyle: TextStyle(color: Colors.black26),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black26)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black38))),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Data de entrega",
                  hintStyle: TextStyle(color: Colors.black26),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black26)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black38))),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: SigavButton(
                    title: "Inserir arquivo",
                    action: () {},
                    small: true,
                    secondary: true,
                  ),
                ),
                Container(
                  width: 10,
                ),
                Expanded(
                  child: SigavButton(
                    title: "Inserir imagem",
                    action: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MeetAddPage()));
                    },
                    small: true,
                    secondary: true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: SigavButton(
                title: "Adicionar",
                action: () {
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}

//
//
//

class SigavNote extends StatelessWidget {
  const SigavNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Row(
              children: [
                Icon(
                  Icons.note,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Adicionar nota de aula",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Nota",
                  hintStyle: TextStyle(color: Colors.black26),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black26)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black38))),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: SigavButton(
                title: "Adicionar",
                action: () {
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}
