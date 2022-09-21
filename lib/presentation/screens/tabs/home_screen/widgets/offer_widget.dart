import 'package:flutter/material.dart';
import 'package:zee_palm/export.dart';

class OfferWidget extends StatelessWidget {
  final JobOfferModel data;

  OfferWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizes.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: colors.colorGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.colorGrey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description:',
            style: textStyles.bodySmall,
          ),
          Text(
            data.description,
            style: textStyles.bodyRegular,
          ),
          verticalSpacer(20),
          Text(
            'Delivery Time: ${data.deliveryTime} days',
            style: textStyles.bodySmall,
          ),
          verticalSpacer(5),
          Row(
            children: [
              Text(
                'Budget: \$${data.budget}',
                style: textStyles.bodySmall,
              ),
              horizontalSpacer(50),
              const Expanded(
                  child: LargeButton(
                text: 'Apply',
                height: 26,
              )),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
