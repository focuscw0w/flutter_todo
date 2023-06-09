import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Todo APP")),
      ),
      body: TodoTasks(),
    ));
  }
}

class TodoTasks extends StatefulWidget {
  const TodoTasks({Key? key}) : super(key: key);

  @override
  State<TodoTasks> createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  List<String> todoTasks = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                    hintText: 'Type your task...',
                  ),
                  validator: (String? task) {
                    if (task == null || task.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        todoTasks.add(myController.text);
                        myController.text = "";
                      });
                    }
                  },
                  child: const Text(
                    "Add your task",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: todoTasks.length,
              itemBuilder: (context, task) {
                return Card(
                  color: Colors.blue[400],
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          todoTasks[task],
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              todoTasks.remove(todoTasks[task]);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ],
    );
  }
}
