import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalAmt, percentOfTotal;

  ChartBar(this.label, this.totalAmt, this.percentOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: constraint.maxHeight * 0.12,
              child: FittedBox(
                // fit: BoxFit.scaleDown,
                child: Text('₦${totalAmt.round()}'),
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(
              height: constraint.maxHeight * 0.66,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Color.fromRGBO(220, 220, 220, 1),
                          borderRadius: BorderRadius.circular(20))),
                  FractionallySizedBox(
                    heightFactor: percentOfTotal,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(height: constraint.maxHeight * 0.12, child: FittedBox(child: Text(label)))
          ],
        );
      },
    );
  }
}
