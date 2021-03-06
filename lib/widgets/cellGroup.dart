import 'package:flutter/material.dart';

class CellGroup extends StatelessWidget {
  // 分组标题
  final String title;
  // 是否显示外边框
  final bool border;
  // 自定义边框样式
  final BoxDecoration decoration;
  // 默认插槽
  final List<Widget> children;

  CellGroup({
    Key key,
    this.title,
    this.children,
    this.border: true,
    this.decoration
  }) : super(key: key);

  buildItems (List list) {
    List<Widget> widgets = [];
    for(int i = 0; i < list.length; i++) {
      widgets.add(list[i]);
      if (i < list.length - 1) widgets.add(Container(
        height: 1,
        margin: EdgeInsets.symmetric(horizontal: 16),
        color: Color(0xffebedf0),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title != null ? Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
          child: Text(title, style: TextStyle(
            fontSize: 14,
            color: Colors.grey
          )),
        ) : Container(),
        Container(
          decoration: decoration??BoxDecoration(
            border: border ? Border(
              top: BorderSide(width: 1.0, color: Color(0xffebedf0)),
              bottom: BorderSide(width: 1.0, color: Color(0xffebedf0)),
            ) : null,
            color: Colors.white
          ),
          child: Column(
            children: buildItems(children),
          ),
        )
      ],
    );
  }
}