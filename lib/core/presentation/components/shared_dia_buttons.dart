import 'package:flutter/material.dart';

class SharedDiaButtons extends StatelessWidget {

  final void Function()? onCancel;
  final void Function()? onApprove;
  final String? cancelLabel;
  final String? approveLabel;
  final bool enabledCancel;
  final bool enabledApprove;

  const SharedDiaButtons({
    Key? key,
    this.approveLabel,
    this.cancelLabel,
    this.enabledApprove = true,
    this.enabledCancel = true,
    this.onApprove,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: enabledCancel ? onCancel : null,
            child: Text(cancelLabel ?? "Iptal")
        ),
        const SizedBox(width: 16,),
        FilledButton.tonal(
            onPressed: enabledApprove ? onApprove : null,
            child: Text(approveLabel ?? "Onayla")
        ),
        const SizedBox(width: 16,),
      ],
    );
  }
}
