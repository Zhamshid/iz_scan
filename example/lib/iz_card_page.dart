import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iz_scan/iz_scan.dart';
import 'package:iz_scan/models/card_info_model.dart';

class IZScanExampleScreen extends StatefulWidget {
  const IZScanExampleScreen({super.key});

  @override
  State<IZScanExampleScreen> createState() => _IZScanExampleScreenState();
}

class _IZScanExampleScreenState extends State<IZScanExampleScreen> {
  final ValueNotifier<CardInfoModel?> _cardInfo = ValueNotifier(null);
  late StreamSubscription<CardInfoModel?> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = IZScan.cardScanStream.listen(
      (cardStreamInfo) {
        if (cardStreamInfo != null) {
          _cardInfo.value = cardStreamInfo;
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('Error during card scan: $error');
        }
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('IZ Card Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async => await IZScan.startCardScan(),
                child: const Text(
                  'Scan Card',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ValueListenableBuilder(
              valueListenable: _cardInfo,
              builder: (context, cardInfo, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardInfoWidget(
                      infoTitle: 'Card Info: ${cardInfo?.number}',
                    ),
                    CardInfoWidget(
                      infoTitle: 'Cardholder Name: ${cardInfo?.cardholderName}',
                    ),
                    CardInfoWidget(
                      infoTitle: 'Expiry Date: ${cardInfo?.expiryDate}',
                    ),
                    CardInfoWidget(
                      infoTitle: 'Expiry Month: ${cardInfo?.expiryMonth}',
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardInfoWidget extends StatelessWidget {
  final String infoTitle;

  const CardInfoWidget({
    super.key,
    required this.infoTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      child: Text(
        infoTitle,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}
