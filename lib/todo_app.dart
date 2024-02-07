import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> tasks = [];
  String text = "";

  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: t1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Baslik',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    tasks.add(t1.text);
                    t1.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds:1),
                      content:const Text('Görev eklendi'),
                      action: SnackBarAction(
                        label:'Undo',
                        onPressed: () {
                          
                        },),
                      ),

                  );
                },
                child: const Text('Ekle')),
            tasks.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Görev Yok',
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  )
                : Expanded(
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.cyanAccent,
                            child: ListTile(
                              leading: Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                text = value;
                                              });
                                            },
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                tasks[index] = text;
                                              });
                                            },
                                            child: const Text('update'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                              trailing: IconButton(
                                tooltip: 'Görevi sil',
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    tasks.removeAt(index);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds:1),
                                      content:Text("görev silindi"),
                                      action:SnackBarAction(
                                        label:'Undo',
                                        onPressed:() {
                                          
                                        },)
                                    ),

                                  );
                                },
                              ),
                              title: Text(tasks[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}