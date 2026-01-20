import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../model/article_response.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/network_img_fallback.dart';

class ArticleDetails extends StatefulWidget {
  final ArticleResponse article;

  const ArticleDetails({super.key, required this.article});

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            verticalSpace(context, 0.08),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomHeader(
                    title: 'Articles',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stripHtmlTags(widget.article.title!),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        tiny5Space(),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: formatDate(widget.article.publishedDate!),
                                style: const TextStyle(
                                    color: Color(0xff3C3B3B),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              TextSpan(
                                text: formatTimeAgo(
                                    widget.article.publishedDate!),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorConstant
                                        .primaryColor), // Change color here
                              ),
                            ],
                          ),
                        ),
                        smallSpace(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       ReactionButtons(),
            //     ],
            //   ),
            // ),
            smallSpace(),

            NetworkImageWithFallback(
              imageUrl: widget.article.featuredImagePath ?? '',
              height: 250,
              width: width(context),
              borderRadius: 0,
              fallbackAsset: 'assets/images/article_1.png',
            ),
            smallSpace(),
            // Figma Flutter Generator Group1000005328Widget - GROUP
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: width(context),
                    height: 68,
                    child: Stack(children: <Widget>[
                      // Positioned(
                      //     top: 0,
                      //     left: 39,
                      //     child: Container(
                      //         width: 52,
                      //         height: 52,
                      //         decoration: const BoxDecoration(
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(8),
                      //             topRight: Radius.circular(8),
                      //             bottomLeft: Radius.circular(8),
                      //             bottomRight: Radius.circular(8),
                      //           ),
                      //           image: DecorationImage(
                      //               image: AssetImage(
                      //                   'assets/images/article_1.png'),
                      //               fit: BoxFit.fitWidth),
                      //         ))),
                      Positioned(
                          top: 7,
                          left: 109,
                          child: Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  widget.article.category!.name!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(60, 58, 58, 1),
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1.4285714285714286),
                                ),
                                SizedBox(
                                  width: width(context),
                                  height: 12,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Text(
                                          widget.article.category!.description!,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(96, 95, 95, 1),
                                              fontFamily: 'Inter',
                                              fontSize: 10,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1.2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ])),
              ],
            ),
            const Divider(),
            tiny5Space(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                stripHtmlTags(
                    widget.article.fullDescription!), // Use dynamic description
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  height: 1.8,
                  color: Color(0xff595959),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            mediumSpace(),
          ],
        ),
      ),
    );
  }
}
