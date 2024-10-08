import 'package:bhinder_internet/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

class IconTextContainer extends StatefulWidget {
  double? height;
  double? width;
  // double? imgheight;
  double? imgwidth;
  String? text;
  Color? color;
  Color? textColor;
  double? fontSize;
  FontWeight? fontWeight;
  String? leftimage;
  String? rightimage;
  Color? borderColor;
  Color? boxcolor;
  Function? onPress;
  double margin;
  double? padding;
  double? topHorizentalPadding;
  double? horizental;
  double? vertical = 0.0;
  double? radius;
  double? topLeftRadius;
  double? topRightRadius;
  double? btmLeftRadius;
  double? btmRightRadius;
  IconTextContainer(
      {super.key,
      this.color,
      this.borderColor,
      this.textColor,
      this.height,
      this.text,
      this.radius,
      this.width,
      this.fontSize,
      this.fontWeight,
      this.leftimage,
      this.imgwidth,
      this.rightimage,
      this.boxcolor,
      this.onPress,
      this.margin = 0.0,
      this.padding,
      this.horizental,
      this.topLeftRadius,
      this.topRightRadius,
      this.btmLeftRadius,
      this.btmRightRadius,
      this.vertical,
      this.topHorizentalPadding});

  @override
  State<IconTextContainer> createState() => _IconTextContainerState();
}

class _IconTextContainerState extends State<IconTextContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPress != null) {
          widget.onPress!();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 0, horizontal: widget.topHorizentalPadding ?? 0),
        child: Container(
          height: widget.height,
          width: widget.width,
          margin: EdgeInsets.all(widget.margin),
          padding: EdgeInsets.symmetric(
              horizontal: widget.horizental ?? 00,
              vertical: widget.vertical ?? 00),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: widget.borderColor ?? Colors.black),
              color: widget.boxcolor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(widget.radius ?? 30)
              //  BorderRadius.only(
              //     topLeft: Radius.circular(widget.topLeftRadius ?? 30),
              //     topRight: Radius.circular(widget.topRightRadius ?? 30),
              //     bottomLeft: Radius.circular(widget.btmLeftRadius ?? 30),
              //     bottomRight: Radius.circular(widget.btmRightRadius ?? 30)),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.leftimage != null
                  ? Row(
                      children: [
                        Image.asset(
                          widget.leftimage ?? "",
                          width: widget.imgwidth ?? 20,
                        ),
                        horizontalSpaceSmall,
                      ],
                    )
                  : Container(),
              widget.text != null
                  ? Row(
                      children: [
                        Text(
                          widget.text ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: widget.fontSize ?? 14,
                                  color: widget.textColor),
                        )
                        // .tr(),
                      ],
                    )
                  : Container(),
              widget.rightimage != null
                  ? Row(
                      children: [
                        horizontalSpaceTiny,
                        Image.asset(
                          color: Colors.black,
                          widget.rightimage ?? "",
                          width: widget.imgwidth ?? 25,
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
