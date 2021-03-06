import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_kit/widgets/button.dart';
import 'package:flutter_kit/widgets/dialog.dart';

class demoDialog extends StatefulWidget {
  @override
  _demoDialog createState() => _demoDialog();
}

class _demoDialog extends State<demoDialog> {
  void _showDialog1 (BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: '标题',
          message: "代码是写出来给人看的，附带能在机器上运行",
        );
      },
    );
  }
  
  void _showDialog2 (BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          message: "代码是写出来给人看的，附带能在机器上运行",
        );
      },
    );
  }

  void _showDialog3 (BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: "标题",
          message: "代码是写出来给人看的，附带能在机器上运行",
          showCancelButton: true,
        );
      },
    );
  }

  void _showDialog4 (BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: "标题",
          message: "代码是写出来给人看的，附带能在机器上运行",
          showCancelButton: true,
          confirmButtonColor: Colors.blueAccent,
          confirmTextColor: Colors.white,
          confirmButtonText: "OK",
          cancelButtonColor: Colors.red,
          cancelTextColor: Colors.white,
          cancelButtonText: "CANCEL",
          titleAlign: AlignmentDirectional.centerStart,
          messageAlign: TextAlign.start
        );
      },
    );
  }

  void _showDialog5 (BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: "标题",
          message: "代码是写出来给人看的，附带能在机器上运行",
          showCancelButton: true,
          beforeClose: () {
            return Future.delayed(Duration(seconds: 1), () {});
          },
        );
      },
    );
  }

  void _showDialog6 (BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: "标题",
          child: Container(
            padding: EdgeInsets.all(24),
            child: Image.network("https://img.yzcdn.cn/vant/apple-1.jpg"),
          ),
          showCancelButton: true,
          beforeClose: () {
            return Future.delayed(Duration(seconds: 1), () {});
          },
        );
      },
    );
  }

  Widget Title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title, 
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Title("基础用法"),
          Row(
            children: <Widget>[
              CustomButton(
                text: "提示弹窗",
                onClick: () {
                  _showDialog1(context);
                },
              ),
              SizedBox(width: 10),
              CustomButton(
                text: "提示弹窗(无标题)",
                onClick: () {
                  _showDialog2(context);
                },
              ),
            ],
          ),
          Title("确认弹窗"),
          Row(
            children: <Widget>[
              CustomButton(
                text: "确认弹窗",
                onClick: () {
                  _showDialog3(context);
                },
              ),
              SizedBox(width: 10),
              CustomButton(
                text: "自定义确认弹窗",
                onClick: () {
                  _showDialog4(context);
                },
              ),
            ],
          ),
          Title("异步调用"),
          Row(
            children: <Widget>[
              CustomButton(
                text: "异步调用",
                onClick: () {
                  _showDialog5(context);
                },
              ),
            ],
          ),
          Title("自定义内容"),
          Row(
            children: <Widget>[
              CustomButton(
                text: "自定义内容",
                onClick: () {
                  _showDialog6(context);
                },
              ),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}