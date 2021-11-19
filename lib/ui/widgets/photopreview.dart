import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  String url;

  PhotoPreview(this.url);

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.black45),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: devicesize.width * .9,
                    height: devicesize.height * .6,
                    child: Image.network(
                      url,
                      fit: BoxFit.fill,
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
