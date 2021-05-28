import 'package:flutter/material.dart';

///used in drawer menu and settings

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final bool divider;

  const MenuTile({this.icon, this.onTap, this.divider = true, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(icon, size: 22, color: Colors.white),
              ),
              Flexible(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      title,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              )
            ],
          ),
        ),
        divider
            ? Divider(
                height: 0,
                color: Colors.grey.shade600,
                indent: 5,
                endIndent: 5,
              )
            : SizedBox(height: 0),
      ],
    );
  }
}
