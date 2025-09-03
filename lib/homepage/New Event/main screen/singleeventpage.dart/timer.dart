import 'dart:async';
import 'package:common_user/common/colors.dart';
import 'package:flutter/material.dart';

class PremiumCountdownContainer extends StatefulWidget {
  final Duration initialDuration;

  const PremiumCountdownContainer({
    Key? key,
    required this.initialDuration,
  }) : super(key: key);

  @override
  State<PremiumCountdownContainer> createState() => _PremiumCountdownContainerState();
}

class _PremiumCountdownContainerState extends State<PremiumCountdownContainer> {
 bool eventcomplete = true;
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.initialDuration;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;

    return GestureDetector(
      onTap: () {
        setState(() {
          eventcomplete = !eventcomplete;
        });
      },
      child: eventcomplete ? Container(
      
        child: Column(
         // mainAxisSize: MainAxisSize.min,
          children: [
          //   const Text(
          //     'TIME REMAINING',
          //     style: TextStyle(
          //       color:Color(0xFF9A2143),
          //       fontSize: 12,
          //       fontWeight: FontWeight.w600,
          //       letterSpacing: 2,
          //     ),
          //   ),
          //  // const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
           //   crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _timeBlock(number: days, label: 'DAYS'),
                _colon(),
                _timeBlock(number: hours, label: 'HOURS'),
                _colon(),
                _timeBlock(number: minutes, label: 'MINUTES'),
              ],
            ),
          ],
        ),
      ) : Container(
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.share,size: 14.0,color: Colors.black,)
              ],
            ),
            SizedBox(height: 6.0,),
            Row(
          children: [
            Text("Send Gifts",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold,color: AppColors.buttoncolor),),
          SizedBox(width: 6.0,),
            Icon(Icons.card_giftcard_rounded,color: AppColors.buttoncolor,size: 16.0,)
          ],
        ),
        Text("to your guests",style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold,color:Colors.black ))
          ],
        ), 
      )
    );
  }

  Widget _timeBlock({required int number, required String label}) {
    return Column(
      children: [
        Text(
          number.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: Color(0xFF9A2143),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
       // const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9A2143),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            
          ),
        ),
      ],
    );
  }

  Widget _colon() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          ':',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
