import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:url_launcher/url_launcher.dart';

////TODO: fix leading empty space

class ExpandableText extends StatefulWidget {
  const ExpandableText(this.text, {this.maxLines = 3});

//  final double maxWidth;
  final String text;
  final int maxLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  void _onTapLink() => setState(() => _readMore = !_readMore);
  final colorClickableText = Colors.green.shade700;
  final widgetColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
        text: _readMore ? " ... read more" : " read less",
        style: TextStyle(color: colorClickableText),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          //children: linkify(widget.text.trim())
          text: widget.text,
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,
          //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.maxLines,
          ellipsis: '...',
        );

        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);

        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = _readMore
              ? TextSpan(
                  text: widget.text.substring(0, endIndex),
                  style: TextStyle(color: widgetColor),
                  children: <TextSpan>[link],
                )
              : TextSpan(
                  style: TextStyle(color: widgetColor),
                  children: [...linkify(widget.text.trim()), link],
                );
        } else {
          textSpan = TextSpan(
              // text: widget.text,
              style: TextStyle(color: widgetColor),
              children: linkify(widget.text.trim()));
        }
        return Text.rich(
          textSpan,
          //style: TextStyle(color: Colors.white),
          softWrap: true,
          overflow: TextOverflow.clip,
        );
      },
    );
    return result;
  }
}

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

const String urlPattern = r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
const String emailPattern = r'\S+@\S+';
const String phonePattern = r'[\d-]{9,}';
final RegExp linkRegExp = RegExp('($urlPattern)|($emailPattern)|($phonePattern)', caseSensitive: false);

WidgetSpan buildLinkComponent(String text, String linkToOpen) => WidgetSpan(
      child: InkWell(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.red,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () => openUrl(linkToOpen),
      ),
    );

List<InlineSpan> linkify(String text) {
  final List<InlineSpan> list = [];
  final RegExpMatch match = linkRegExp.firstMatch(text);
  if (match == null) {
    list.add(TextSpan(text: text));
    return list;
  }

  if (match.start > 0) {
    list.add(TextSpan(text: text.substring(0, match.start)));
  }

  final String linkText = match.group(0);
  if (linkText.contains(RegExp(urlPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, linkText));
  } else if (linkText.contains(RegExp(emailPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'mailto:$linkText'));
  } else if (linkText.contains(RegExp(phonePattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'tel:$linkText'));
  } else {
    throw 'Unexpected match: $linkText';
  }

  list.addAll(linkify(text.substring(match.start + linkText.length)));

  return list;
}
