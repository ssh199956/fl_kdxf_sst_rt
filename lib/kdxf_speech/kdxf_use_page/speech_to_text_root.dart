import 'dart:async';
import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';
import '../kdxf_plugins/utils/base_kdxf.dart';

class SpeechToTextKF extends StatefulWidget {
  const SpeechToTextKF({super.key, required this.isShowCheck});

  final bool isShowCheck;

  @override
  State<SpeechToTextKF> createState() => _SpeechToTextKFState();
}

class _SpeechToTextKFState extends State<SpeechToTextKF>
    with KDXFBaseSpeechRecognitionMixin {
  final _controller = SiriWaveController();
  final _showSupportBar = true;
  final _isSelected = [false, true];
  bool isDown = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    KDXFDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isDown
        ? Container()
        : Container(
            width: 375,
            height: 200,
            color: const Color(0xFF292A34),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                !isDown
                    ? Container()
                    : SiriWave(
                        controller: _controller,
                        options: SiriWaveOptions(
                          height: 150,
                          showSupportBar: _showSupportBar,
                          width: 375,
                        ),
                        style: _isSelected[0]
                            ? SiriWaveStyle.ios_7
                            : SiriWaveStyle.ios_9,
                      ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF383945),
                  ),
                  child: Text(
                    showMsg,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: InkWell(
                    onTapDown: (de) async {
                      bool isTure = await checkPermission();
                      setState(() {
                        if (isTure) {
                          isDown = true;
                          KDXFInit();
                        }
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        isDown = false;
                        KDXFStopListening();
                        postUpdateUI();
                      });
                    },
                    onTapUp: (de) {
                      setState(() {
                        isDown = false;
                        KDXFStopListening();
                        postUpdateUI();
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                          color: const Color(0xFF73747E),
                          borderRadius: BorderRadius.circular(40)),
                      child: isDown
                          ? const Text(
                              "输入中",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          : const Text("按住说话",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                ),
                widget.isShowCheck == false
                    ? Container()
                    : Positioned(
                        right: 73,
                        bottom: 38,
                        child: GestureDetector(
                          onTap: () {
                            isDown = false;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xFF73747E),
                                borderRadius: BorderRadius.circular(20)),
                            width: 35,
                            height: 35,
                            child: const Text(
                              "切换\n文本",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ))
              ],
            ),
          );
  }

  void postUpdateUI() {
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        updateMsg = '开始问我问题吧！';
      });
    });
  }
}
