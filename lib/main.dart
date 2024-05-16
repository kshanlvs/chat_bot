import 'package:chat_bot/app_body.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Chat BOT',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'THEBOT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];
 bool isLoading = true;

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset("assets/images/robot.png",height: 30,width: 50,),
            const SizedBox(width: 5,),

            const Padding(
              padding: EdgeInsets.only(top: 
              10),
              child: Text.rich(TextSpan(children: [
                TextSpan(text: "DOT",style: TextStyle(color: Color.fromARGB(255, 224, 219, 219,),fontWeight: FontWeight.bold)),
                TextSpan(text: "BOT", style: TextStyle(
                    color: Colors.yellowAccent, fontWeight: FontWeight.bold))
              ])),
            )
           
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(244, 220, 255, 20).withOpacity(.3), // Green neon
              Colors.black.withOpacity(.5),
              Colors.blue.withOpacity(.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(child: AppBody(messages: messages,isLoadingText: isLoading,)),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.yellow, width: 2),
                  color: Colors.black,
                ),
                child: TextField(
                     controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Ask me anything',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon:    IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                  ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
       
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {

      addMessage(
        Message(text: DialogText(text: [text])),
        true,
        true
      );
     
    });

    

    // dialogFlowtter.projectId = "deimos-apps-0905";

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;
    setState(() {
      addMessage(response.message!,false,false);
   
    });
  }

  void addMessage(Message message, bool showLoader, [bool isUserMessage = false] ) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
      "showLoader":showLoader

    });
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }
}
