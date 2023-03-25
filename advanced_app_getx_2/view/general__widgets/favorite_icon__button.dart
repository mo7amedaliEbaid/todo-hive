import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/favorites__controller/extensions/add_to_favorites.dart';
import '../../controllers/favorites__controller/favorites__controller.dart';

class FavoriteIconButton extends StatefulWidget {
  FavoriteIconButton({
    Key? key,
    required this.isChecked,
    required this.passedIndex,
    this.size = 26,
  }) : super(key: key);
  bool isChecked;
  final double size;
  final int passedIndex;
  static final FavoritesController favoritesController =
      Get.put(FavoritesController());

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController favIconController;
  late Animation<double> scale;

  animate(bool isChecked) {
    // card icon animation
    isChecked == true
        ? favIconController.forward()
        : favIconController.reverse();
  }

  @override
  void initState() {
    favIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    scale = Tween(begin: 1.0, end: 1.25)
        .chain(CurveTween(
          curve: Curves.elasticInOut,
        ))
        .animate(favIconController);
    favIconController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        favIconController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    favIconController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // hide ink effect
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: GetBuilder<FavoritesController>(
        init: FavoritesController(),
        builder: (favoritesController) {
          return AnimatedBuilder(
              animation: scale,
              builder: (context, __) {
                return Transform.scale(
                  scale: scale.value,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isChecked = !widget.isChecked;
                      });
                      favoritesController.addToFavorites(widget.passedIndex);

                      animate(widget.isChecked);
                      // favoritesController.update();
                    },
                    icon: Icon(
                      widget.isChecked
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.red[800],
                      size: widget.size,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
