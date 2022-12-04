import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/screena.dart';
import 'package:flutter_application/screenb.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "meohyun",
      theme: ThemeData(primarySwatch: Colors.blue // 주요 음영을 blue로 설정
          ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/a': (context) => ScreenA(),
        '/b': (context) => ScreenB()
      },
      debugShowCheckedModeBanner: false, // custom widget
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Authentication());
  }
}

class MySnackBar extends StatelessWidget {
  MySnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "hello",
              style: TextStyle(color: Colors.teal),
            ),
            duration: Duration(microseconds: 1000),
          ));
        },
        child: Text(
          "snackbar",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class MyToast extends StatelessWidget {
  const MyToast({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: () {
          toast();
        },
        child: Text(
          "toastbutton",
          style: TextStyle(color: Colors.white),
        ));
  }
}

class ScreenPage extends StatelessWidget {
  const ScreenPage({super.key, required this.user_name});

  final AsyncSnapshot<User> user_name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("플러터 예제"),
          leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app))),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$user_name",
              style: TextStyle(
                  fontSize: 20, color: Colors.amberAccent, letterSpacing: 2.0)),
          SizedBox(
            height: 10,
            width: 10,
          ),
          ScreenButtonA(),
        ],
      )),
    );
  }
}

void toast() {
  Fluttertoast.showToast(
      msg: "hello",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 20.0);
}

class ScreenButtonA extends StatelessWidget {
  const ScreenButtonA({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: () {
          Navigator.pushNamed(context, '/a');
        },
        child: Text(
          "ScreenA",
          style: TextStyle(color: Colors.white),
        ));
  }
}

class ScreenButtonB extends StatelessWidget {
  const ScreenButtonB({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: () {
          Navigator.pushNamed(context, '/b');
        },
        child: Text(
          "ScreenB",
          style: TextStyle(color: Colors.white),
        ));
  }
}

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: signInWithGoogle, child: Text("구글 로그인"))
                ],
              ),
            );
          }
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.logout)),
              Text("안녕",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.amberAccent,
                      letterSpacing: 2.0)),
              SizedBox(
                height: 10,
                width: 10,
              ),
              ScreenButtonA(),
            ],
          ));
        });
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/odong.png'),
            backgroundColor: Colors.blue[200],
          ),
          otherAccountsPictures: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/odong2.png'),
              backgroundColor: Colors.white,
            )
          ],
          onDetailsPressed: () {
            print("detail button is pressed");
          },
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
          ),
          accountName: Text("대현"),
          accountEmail: Text("eogus1954@gmail.com"),
        ),
        ListTile(
          leading: Icon(Icons.home),
          iconColor: Colors.black,
          title: Text("Home"),
          trailing: Icon(Icons.add),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          iconColor: Colors.black,
          title: Text("Setting"),
          trailing: Icon(Icons.add),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          iconColor: Colors.black,
          title: Text("QnA"),
          trailing: Icon(Icons.add),
        ),
      ],
    ));
  }
}
