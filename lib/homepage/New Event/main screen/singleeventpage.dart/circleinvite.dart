import 'package:common_user/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AmountDial extends StatefulWidget {
  const AmountDial({super.key});

  @override
  State<AmountDial> createState() => _AmountDialState();
}

class _AmountDialState extends State<AmountDial> {
  double value = 234; // starting amount

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.225,
      width: MediaQuery.of(context).size.width *0.425 ,
      child: SleekCircularSlider(
        min: 0,
        max: 500,
        initialValue: value,
        appearance: CircularSliderAppearance(
          size: 170,
          startAngle:0, // where the arc starts
          angleRange: 345, // arc length (creates the "gap")
          customWidths: CustomSliderWidths(
            trackWidth: 14,
            progressBarWidth: 14,
            handlerSize: 10,
          ),
          customColors: CustomSliderColors(
            trackColor: Colors.black12,
            dotColor: Colors.white,
            progressBarColors:   const [ Color(0xFF9A2143),  Color(0xFF9A2143)],
            shadowMaxOpacity: 0.0,
          ),
        ),
        innerWidget: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(" 234 / 500",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900,color: AppColors.buttoncolor),),
            // Text(money.format(value.round()), style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
            const Text('Invite People', style: TextStyle(color: Colors.black)),
          ],
        ),
        onChange: (v) => setState(() => value = v),
      ),
    );
  }
}
