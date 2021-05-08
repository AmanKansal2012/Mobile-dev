import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toDoIt/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> todo =List<String>();
  List<bool> listCheck = List.generate(10000, (index) => false);
  List<String> onPress =List<String>();

  String listKey = "listKey";

  void storeStringList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(listKey, list);
  }

  Future<List<String>> getStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getStringList(listKey);
  }


  @override
  void initState() {
    getList();
    super.initState();
  }

  getList() {
    getStringList().then((value) {
      Provider.of<ListProvider>(context, listen: false).getList(value);
    });
  }

  @override
  Widget build(BuildContext context) {

    todo = Provider.of<ListProvider>(context, listen: true).toDo;

    getList();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        elevation: 5,
        centerTitle: true,
        title: Text(
          "TO-DO List",
          style: kTitle1.copyWith(color: Colors.black),
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          heroTag: 'fabTodoScreen',
          backgroundColor: kPrimary,
          child: const Icon(
            Icons.add,
            color: kBlack,
            size: 24.0,
            semanticLabel: 'Create a todo',
          ),
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return toDoSheet();
              },
            );
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          "Daily Tasks",
                          textAlign: TextAlign.center,
                          style: kTitle2.copyWith(
                              fontSize: 20,
                              color: kBlack.withOpacity(0.7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: todo!=null?todo.length:0,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: kPrimary.withOpacity(0.3)),
                            height: 75,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kPrimary, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      checkColor: kWhite,
                                      activeColor: kPrimary,
                                      value: listCheck[index],
                                      onChanged: (bool newValue) {
                                        listCheck[index]=newValue;

                                        },

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      todo[index],
                                      style: kTitle1.copyWith(
                                          color: kBlack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1,
                            color: kBlack,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget toDoSheet() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.transparent,
        child: Container(
          height: 180.0,
          decoration: const BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: kPrimary,
                ),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 50.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        style: kTitle2.copyWith(
                            color: kBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        maxLength: 60,
                        maxLines: 2,
                        maxLengthEnforced: true,
                        controller: _controller,
                        onSubmitted: null,
                        cursorColor: kPrimary,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixStyle: const TextStyle(color: Colors.white),
                          counterText: "",
                          border: InputBorder.none,
                          hintText: 'Add a todo',
                          hintStyle: kTitle1.copyWith(
                              color: kBlack,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: kWhite,
                    onPressed: () {
                      _controller.text.trim().isNotEmpty
                          ? onPress.add(_controller.text.trim())
                          : null;
                      _controller.clear();
                      listCheck.add(false);

                      storeStringList(onPress);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Add",
                          style: kTitle2.copyWith(color: kBlack),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
