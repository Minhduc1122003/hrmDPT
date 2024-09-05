import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget buildAssetCard({
  required String title,
  required String status,
  required String personInCharge,
  required String usageUntil,
  required String imagePath,
  VoidCallback? onEditPressed,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(bottom: BorderSide(color: Colors.grey)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Image.asset(
          imagePath,
          height: 100,
          width: 150,
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          'Tình trạng:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4), // Space between text
                      Flexible(
                        child: AutoSizeText(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Align text to the start (top) of the Column
                    children: [
                      Align(
                        alignment: Alignment.topRight, // Align to the top right
                        child: AutoSizeText(
                          'Người bàn giao:',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4), // Space between text
                      Flexible(
                        child: AutoSizeText(
                          personInCharge,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2, // Cho phép tối đa 2 dòng
                          minFontSize: 10,
                          overflow: TextOverflow.ellipsis,
                          textAlign:
                              TextAlign.left, // Căn chỉnh văn bản sang trái
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align to the right
                    children: [
                      Text(
                        'Sử dụng đến:',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(width: 4),
                      Text(
                        usageUntil,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
