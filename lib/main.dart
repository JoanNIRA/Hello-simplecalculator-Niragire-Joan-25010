import 'package:assignment1/battery_service.dart';
import 'package:assignment1/internet_connectivity_service.dart';
import 'package:assignment1/signin_screen.dart';
import 'package:assignment1/signup_screen.dart';
import 'package:assignment1/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBHPBjBX87TiFihJmgVwnBUhfIn_Z-aOZg",
      appId: "1:632312362517:ANDROID:eae820c26902480691001c",
      messagingSenderId: "632312362517",
      projectId: "sign-f49de",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<InternetConnectivityService>(create: (_) => InternetConnectivityService()),
        ChangeNotifierProvider<BatteryService>(create: (_) => BatteryService()),
        ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          title: 'Simple Calculator App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            brightness: themeService.themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: themeService.themeMode,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SignInScreen(),
    SignUpScreen(),
    CalculatorScreen(),
  ];

  @override
  void initState() {
    super.initState();
    print("HomePage initialized");

    // Delay the initialization of BatteryService to avoid errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final batteryService = Provider.of<BatteryService>(context, listen: false);
      batteryService.initialize(context);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator App'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Sign In'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text('Sign Up'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Calculator'),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.brightness_4),
              title: Text('Appearance'),
              onTap: () {
                Provider.of<ThemeService>(context, listen: false).toggleTheme();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}