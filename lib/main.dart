import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<ListElement> _list = <ListElement>[];
  bool _userRound = true; // true => 1 player, false => 2 player
  bool _showButton = false;
  bool _endGame = false;
  String _showMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tic Tac Toe'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.height,
            child: GridView.count(
              padding: const EdgeInsets.all(5.0),
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              crossAxisCount: 3,
              children: List<Widget>.generate(9, (int index) {
                final ListElement? element = _list.firstWhereOrNull((ListElement item) => item.index == index);
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black87),
                  ),
                  child: ListTile(
                    tileColor: element != null && element.firstplayer
                        ? Colors.blue
                        : element != null && element.secondplayer
                            ? Colors.red
                            : Colors.white,
                    onTap: () {
                      setState(() {
                        if (element == null && _userRound && !_endGame) {
                          _list.add(ListElement(index, true, false));
                          _userRound = !_userRound;
                        } else if (element == null && !_userRound && !_endGame) {
                          _list.add(ListElement(index, false, true));
                          _userRound = !_userRound;
                        }
                        if (_list.length >= 9) {
                          _showButton = true;
                          _endGame = true;
                          _showMessage = 'game over';
                        }
                        final List<int> _list1 = <int>[];
                        _list
                            .expand((ListElement data) => <void>[if (data.firstplayer) _list1.add(data.index)])
                            .toList();
                        if (<int>[0, 1, 2].every((int element) => _list1.contains(element)) ||
                            <int>[3, 4, 5].every((int element) => _list1.contains(element)) ||
                            <int>[6, 7, 8].every((int element) => _list1.contains(element)) ||
                            <int>[0, 3, 6].every((int element) => _list1.contains(element)) ||
                            <int>[1, 4, 7].every((int element) => _list1.contains(element)) ||
                            <int>[2, 5, 8].every((int element) => _list1.contains(element)) ||
                            <int>[0, 4, 8].every((int element) => _list1.contains(element)) ||
                            <int>[2, 4, 6].every((int element) => _list1.contains(element))) {
                          _showButton = true;
                          _endGame = true;
                          _showMessage = 'first player win';
                        }
                        final List<int> _list2 = <int>[];
                        _list
                            .expand((ListElement data) => <void>[if (data.secondplayer) _list2.add(data.index)])
                            .toList();
                        if (<int>[0, 1, 2].every((int element) => _list2.contains(element)) ||
                            <int>[3, 4, 5].every((int element) => _list2.contains(element)) ||
                            <int>[6, 7, 8].every((int element) => _list2.contains(element)) ||
                            <int>[0, 3, 6].every((int element) => _list2.contains(element)) ||
                            <int>[1, 4, 7].every((int element) => _list2.contains(element)) ||
                            <int>[2, 5, 8].every((int element) => _list2.contains(element)) ||
                            <int>[0, 4, 8].every((int element) => _list2.contains(element)) ||
                            <int>[2, 4, 6].every((int element) => _list2.contains(element))) {
                          _showButton = true;
                          _endGame = true;
                          _showMessage = 'second player win';
                        }
                      });
                    },
                  ),
                );
              }),
            ),
          ),
          Visibility(
            visible: _showButton,
            child: Column(
              children: <Widget>[
                Text(
                  _showMessage,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _list.clear();
                      _endGame = false;
                      _showButton = false;
                    });
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListElement {
  ListElement(this.index, this.firstplayer, this.secondplayer);

  final int index;
  final bool firstplayer;
  final bool secondplayer;
}
