import 'package:flutter/material.dart';
import 'package:teameat/3_domain/core/i_widget_view_count_repository.dart';
import 'package:teameat/4_infra/core/widget_view_count_repository_mixin.dart';

class WidgetViewCountRepository<T extends Widget>
    extends IWidgetViewCountRepository<T>
    with WidgetViewCountRepositoryMixin<T> {}
