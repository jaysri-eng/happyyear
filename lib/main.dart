import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happy New Year',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this)..repeat(reverse: true);
    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc),
    );
    _offsetAnimation = Tween<Offset>(begin: Offset.zero,end: Offset.fromDirection(1.5,0.0),
      ).animate(
      CurvedAnimation(parent: _controller, curve:Curves.easeInOutCirc),
    );
  }

  @override
  void dispose(){
    _controller.dispose();super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Happy New Year',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlignTransition(
              alignment: _alignAnimation,
              child: SlideTransition(
                position: _offsetAnimation,
                child: Image.asset('assets/happy-new-year.png',height: 150,width: 150,),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/balloons.png',height: 100,width: 100,),
                Image.asset('assets/party-blower.png',height: 100,width: 100,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

