import 'package:flutter/material.dart';

class DeleteDespesaDialogWidget extends StatelessWidget {
  final void Function() onPressed;

  const DeleteDespesaDialogWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 82,
              child: Container(
                width: 600,
                height: 100,
                margin: const EdgeInsets.all(10),
                child: const CircleAvatar(
                  backgroundColor: Colors.orange,
                ),
              ),
            ),
            Positioned(
              bottom: 85,
              child: Container(
                width: 1200,
                height: 95,
                margin: const EdgeInsets.all(10),
                child: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    "!",
                    style: TextStyle(fontSize: 65),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 42),
                    const Text("Deseja mesmo apagar a despesa?"),
                    // const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                        TextButton(onPressed: () => onPressed(), child: const Text("Apagar")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
