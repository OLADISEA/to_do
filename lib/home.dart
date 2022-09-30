import 'package:flutter/material.dart';
import 'package:to_do/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  String newTodo = '';
  List<MyToDos> toDoItem = [];
  List<MyToDos> foundSearchItem = [];
  // List<MyToDos> reverseList = [];
  bool addButton = false;


  @override
  void initState() {
    super.initState();
    foundSearchItem = toDoItem;
  }


  void locateSearchWord(String input){
    List<MyToDos> output = [];
    if(input.isEmpty){
      output = toDoItem;
    }else{
      output = toDoItem.where((element) => element.text
          .toLowerCase()
          .contains(input.toLowerCase()))





          .toList();
    }
    setState(() {
      foundSearchItem = output;
      addButton = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Icon(
                  Icons.menu,
                  color: Colors.white
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/actors-wallpapers.jpg'),
              )
            ]
        ),
        backgroundColor: Colors.grey[400],
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: TextField(
                onChanged: (value) => locateSearchWord(value),
                showCursor: true,
                textAlign: TextAlign.center ,

                decoration: InputDecoration(
                    hoverColor: Colors.deepPurple,
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search,color: Colors.grey,),
                    prefixIconConstraints: BoxConstraints(
                        maxWidth: 25.0,
                        maxHeight: 18.0
                    ),
                    hintText: 'search',
                    hintStyle: TextStyle(fontSize: 20.0,color: Colors.black12,fontWeight: FontWeight.bold) ,
                    border: InputBorder.none

                )

            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: ListView.builder(

                  itemCount: foundSearchItem.length,
                  itemBuilder: (BuildContext context,int  index){

                    return Container(
                      height: 90,
                      margin: EdgeInsets.only(bottom: 13.0,left:17.0,right:17.0),
                      child: ListTile(
                        tileColor: toDoItem[index].isDone?Colors.red:Colors.white60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 15.0),
                        title: Text(foundSearchItem[index].text,
                            style: TextStyle(
                              decoration: toDoItem[index].isDone? TextDecoration.lineThrough: null,
                              color: Colors.grey[500],
                              fontSize: 25.0,
                            )),
                        leading: IconButton(
                          onPressed: () {
                            toDoItem[index].isDone = !toDoItem[index].isDone;
                            setState(() {
                              foundSearchItem.add(foundSearchItem[index]);
                              foundSearchItem.removeAt(index);

                            });

                            // icon1 = Icon(Icons.check_box);
                          },
                          icon: toDoItem[index].isDone? Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
                          //     icon: AnimatedIcon(
                          //     icon: AnimatedIcons.close_menu,
                          //     progress: _controller ,
                          // )
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {

                              toDoItem.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );

                  }
              ),
            ),
          ),

          FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Add new Todo'),
                      content: TextField(
                        onChanged: (String value) {
                          newTodo = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              addButton = true;
                              foundSearchItem.insert(0,MyToDos(text: newTodo));
                            });

                            Navigator.of(context).pop();
                            FocusScope.of(context).unfocus();
                          },
                          child: Text('Add'),
                        )
                      ],
                    );
                  }
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          )

        ],
      ),
    );
  }
}
