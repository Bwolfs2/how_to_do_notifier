import 'package:flutter/material.dart';

class AnimatedToggleButton extends StatefulWidget {
  final double heigth;
  final List<ToggleData> toggleData;
  final ValueChanged<ToggleData> onValueChange;
  const AnimatedToggleButton({Key? key, this.heigth = 40, required this.toggleData, required this.onValueChange}) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<AnimatedToggleButton> {
  var selectedIndex = ValueNotifier(0);
  var animating = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heigth,
      child: LayoutBuilder(builder: (context, layout) {
        return Stack(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (context, index, child) {
                return AnimatedContainer(
                  margin: EdgeInsets.only(left: layout.maxWidth / widget.toggleData.length * index),
                  onEnd: () => animating.value = false,
                  width: layout.maxWidth / widget.toggleData.length,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(100)),
                  child: child,
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: animating,
                builder: (context, isAnimating, child) {
                  return Row(
                    children: List.generate(widget.toggleData.length, (index) {
                      return InkWell(
                        onTap: () {
                          if (selectedIndex.value != index) {
                            selectedIndex.value = index;
                            animating.value = true;
                            widget.onValueChange(widget.toggleData[index]);
                          }
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          alignment: Alignment.center,
                          width: layout.maxWidth / widget.toggleData.length,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.toggleData[index].description,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  color: selectedIndex.value == index && !isAnimating ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
          ],
        );
      }),
    );
  }
}

class ToggleData {
  final int id;
  final String description;

  ToggleData(this.id, this.description);
}
