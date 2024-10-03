
import 'package:flutter/material.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

import '../../../../core/utils/my_color.dart';


class TransactionShimmer extends StatelessWidget {
  const TransactionShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 30,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: MyColor.borderColor,width: 1)
          ),
          child: const Column(
            children: [
              Row(
                children: [
                  MyShimmerEffectUI.circular(height: 30,width: 30,),
                  SizedBox(width: 12,),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                       MyShimmerEffectUI.rectangular(height: 15,width: 80,),
                        SizedBox(height: 10,),
                        MyShimmerEffectUI.rectangular(height: 15,width: 130,),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                    MyShimmerEffectUI.rectangular(height: 15,width: 80,),
                     SizedBox(height: 10,),
                     MyShimmerEffectUI.rectangular(height: 15,width: 110,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyShimmerEffectUI.rectangular(height: 15,width: 80,),
                  MyShimmerEffectUI.circular(height: 30,width: 30,)
                ],
              ),
            ],
          ),
        ));
  }
}
