import 'package:GreenHexagon/features/listening/unit/widgets/pagination_button.dart';
import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';

import 'exit_button.dart';

class PaginationRow extends StatelessWidget {
  final List<Map<String, dynamic>> pagination;
  final TtsService ttsService;
  final VoidCallback onExit;
  final void Function(String? newPath, String actionText) onNavigate;

  const PaginationRow({
    super.key,
    required this.pagination,
    required this.ttsService,
    required this.onExit,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PaginationButton(
          text: pagination[0].keys.first.toUpperCase(),
          ttsService: ttsService,
          onDoubleTap: () => _onPaginationTap(pagination[0]),
        ),
        ExitButton(text: pagination[2].keys.first.toUpperCase(), ttsService: ttsService, onDoubleTap: onExit),
        PaginationButton(
          text: pagination[1].keys.first.toUpperCase(),
          ttsService: ttsService,
          onDoubleTap: () => _onPaginationTap(pagination[1]),
        ),
      ],
    );
  }

  void _onPaginationTap(Map<String, dynamic> item) {
    final actionText = item.keys.first;
    final dynamic value = item.values.first;

    String? rawValue;
    if (value is String && value.isNotEmpty && value != "false") {
      rawValue = value;
    } else if (value == false) {
      rawValue = null;
    }

    onNavigate(rawValue, actionText);
  }
}
