import 'package:flutter/material.dart';
import 'package:makingfriends/widgets/image_setting.dart';

/// @description： 选择图片
/// @author：liuzhidong
/// @date：2020/4/24 18:46
/// @version：1.0

class PhotoItem extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  final Function del;

  const PhotoItem({
    Key key,
    this.path,
    this.height,
    this.width,
    this.del,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: HttpImage(
              borderRadius: 5,
              url: path,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: GestureDetector(
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                onTap: del,
              ),
            ),
          )
        ],
      ),
    );
  }
}
