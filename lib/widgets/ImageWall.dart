import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

typedef void ImagesChangeCallback(List<String> newImages);
typedef Future<String> UploadImageCallback(List<Asset> file);

/// 点击删除按钮时的回调
typedef RemoveImageCallback(String removedUrl);

//照片墙
class ImageWall extends StatefulWidget {
  // 图片文件数组
  final List<String> images;
  // 是否可以多选图片
  final bool multiple;
  // 单行的图片数量	
  final int length;
  // 最多可以选择的图片张数
  final int count;
  // 图片预览样式
  final BoxFit imageFit;
  // 自定义 button
  final Widget uploadBtn;
  // 上传后返回全部图片信息
  final ImagesChangeCallback onChange;
  // 监听图片上传
  final UploadImageCallback onUpload;
  // 删除图片后的回调
  final RemoveImageCallback onRemove;

  const ImageWall({
    Key key,
    this.multiple: false,
    this.length: 4,
    this.count: 9,
    this.images,
    this.uploadBtn,
    this.imageFit: BoxFit.contain,
    @required this.onChange,
    @required this.onUpload,
    this.onRemove,
  }) : super(key: key);

  @override
  _ImageWall createState() => _ImageWall();
}

class _ImageWall extends State<ImageWall> {
  List<String> images = [];
  GlobalKey _key = GlobalKey();
  double space = 10.0;
  double size;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }

  _onLayoutDone(_) {
    RenderBox test = _key.currentContext.findRenderObject();
    setState(() {
      double itemSize = (test.size.width - (space * (widget.length - 1))) / widget.length;
      size = itemSize.toInt().toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 1,
      ),
      key: _key,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: space,
        runSpacing: space,
        children: buildImages(),
      )
    );
  }

  List<Widget> buildImages() {
    List<Widget> widgets = [];
    images = widget.images??[];
    for (int i = 0; i < images.length; i++) {
      widgets.add(_buildImageItem(i));
    }
    if (widget.count == null || images.length < widget.count) {
      widgets.add(_buildAddImageButton());
    }
    return widgets;
  }

  Widget _buildImageItem(int index) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Image.network(
          images[index],
          fit: widget.imageFit,
          width: size,
          height: size,
        ),
        Positioned(
          right: 4.0,
          top: 4.0,
          child: InkWell(
            child: Icon(Icons.cancel, color: Colors.grey.withOpacity(.8), size: 16),
            onTap: () {
              String removedUrl;
              setState(() {
                removedUrl = images.removeAt(index);
              });
              widget.onChange(images);
              if (widget.onRemove != null) {
                widget.onRemove(removedUrl);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildAddImageButton() {
    Widget btn = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffebedf0),
        ),
      ),
      child: Icon(Icons.add, color: Colors.grey),
    );

    return InkWell(
      child: widget.uploadBtn ?? btn,
      onTap: () async {
        List<Asset> resultList = List<Asset>();
         try {
          resultList = await MultiImagePicker.pickImages(
            maxImages: widget.multiple ? widget.count - images.length : 1,
            enableCamera: true,
            cupertinoOptions: CupertinoOptions(
              takePhotoIcon: "chat"
            ),
            materialOptions: MaterialOptions(
              startInAllView: true,
              useDetailsView: true,
              selectCircleStrokeColor: "#000000",
              actionBarColor: "#000000"
            ),
          );
        } on Exception catch (e) {}
        String url = await widget.onUpload(resultList);
        if (url == null || url.isEmpty) {
          return;
        }
        setState(() {
          images.add(url);
        });
        widget.onChange(images);
      },
    );
  }
}
