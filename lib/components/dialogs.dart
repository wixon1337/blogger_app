import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static const Color barrierColor = Colors.black54;

  static Future<bool> openAlertDialog({
    required BuildContext context,
    required String message,
    String? title,
    double height = 200.0,
  }) async {
    var result = await showDialog(
        context: context,
        barrierColor: Dialogs.barrierColor,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: const BorderSide(color: Colors.transparent, width: 1.0),
            ),
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(0.0),
            content: SizedBox(
              height: height,
              width: MediaQuery.of(context).size.width > 300.0 ? 300.0 : MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      topRight: Radius.circular(6.0),
                    )),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 13.0),
                            child: Text(
                              title ?? 'error'.tr(),
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150.0,
                        height: 70.0,
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text(
                            'ok'.tr(),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }
}
