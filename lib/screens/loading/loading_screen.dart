import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/screens.loading.png'),
                    fit: BoxFit.fitWidth,
                  )
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              alignment: Alignment(0.0, 0.5),
              child: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.white54,
                child: Text(
                  'Ratatouille',
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'BerkshireSwash',
                    color: Colors.red
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
