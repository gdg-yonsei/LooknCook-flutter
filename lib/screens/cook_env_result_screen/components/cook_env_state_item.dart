import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/dtos/enums.dart';

class CookEnvStateItem extends Card {
  final CookEnvState envState;

  const CookEnvStateItem({
    super.key,
    required this.envState,
  });

  static const Map<CookEnvType, String> recipeLevelLabels = {
    CookEnvType.fire: "Fire",
    CookEnvType.knife: "Knife",
    CookEnvType.rotten: "Rotten Ingredient",
    CookEnvType.cookery: "Cookery",
  };

  static const Map<CookEnvType, String> recipeLevelIcons = {
    CookEnvType.fire: "🔥",
    CookEnvType.knife: "🔪",
    CookEnvType.rotten: "🍖",
    CookEnvType.cookery: "🫕",
  };

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      titleAlignment: ListTileTitleAlignment.threeLine,
      leading: Container(
        clipBehavior: Clip.hardEdge,
        width: 40,
        height: 40,
        alignment: Alignment.center,
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: Text(
          "${recipeLevelIcons[envState.type]}",
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
      title: Text("${recipeLevelLabels[envState.type]}"),
      subtitle: Text(envState.content),
    );
  }
}
