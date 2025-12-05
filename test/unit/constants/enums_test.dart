/// 枚举测试
///
/// 测试枚举类型的正确性和扩展方法。
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/core/constants/enums.dart';

void main() {
  group('VelocitySize', () {
    test('应该包含所有尺寸选项', () {
      expect(VelocitySize.values.length, 5);
      expect(VelocitySize.values, [
        VelocitySize.xs,
        VelocitySize.sm,
        VelocitySize.md,
        VelocitySize.lg,
        VelocitySize.xl,
      ]);
    });

    test('扩展方法应该返回正确的值', () {
      expect(VelocitySize.xs.value, 24.0);
      expect(VelocitySize.sm.value, 32.0);
      expect(VelocitySize.md.value, 40.0);
      expect(VelocitySize.lg.value, 48.0);
      expect(VelocitySize.xl.value, 56.0);
    });

    test('扩展方法应该返回正确的内边距', () {
      expect(VelocitySize.xs.padding, 8.0);
      expect(VelocitySize.sm.padding, 12.0);
      expect(VelocitySize.md.padding, 16.0);
      expect(VelocitySize.lg.padding, 20.0);
      expect(VelocitySize.xl.padding, 24.0);
    });

    test('值应该递增', () {
      const sizes = VelocitySize.values;
      for (var i = 1; i < sizes.length; i++) {
        expect(sizes[i].value > sizes[i - 1].value, true);
        expect(sizes[i].padding > sizes[i - 1].padding, true);
      }
    });
  });

  group('VelocityVariant', () {
    test('应该包含所有变体选项', () {
      expect(VelocityVariant.values.length, 10);
      expect(VelocityVariant.values, [
        VelocityVariant.primary,
        VelocityVariant.secondary,
        VelocityVariant.success,
        VelocityVariant.warning,
        VelocityVariant.error,
        VelocityVariant.info,
        VelocityVariant.neutral,
        VelocityVariant.outline,
        VelocityVariant.ghost,
        VelocityVariant.link,
      ]);
    });
  });

  group('VelocityState', () {
    test('应该包含所有状态选项', () {
      expect(VelocityState.values.length, 7);
      expect(VelocityState.values, [
        VelocityState.normal,
        VelocityState.hover,
        VelocityState.focus,
        VelocityState.active,
        VelocityState.disabled,
        VelocityState.loading,
        VelocityState.error,
      ]);
    });
  });

  group('VelocityAlignment', () {
    test('应该包含所有对齐选项', () {
      expect(VelocityAlignment.values.length, 4);
      expect(VelocityAlignment.values, [
        VelocityAlignment.left,
        VelocityAlignment.center,
        VelocityAlignment.right,
        VelocityAlignment.justify,
      ]);
    });
  });

  group('VelocityDirection', () {
    test('应该包含所有方向选项', () {
      expect(VelocityDirection.values.length, 2);
      expect(VelocityDirection.values, [
        VelocityDirection.horizontal,
        VelocityDirection.vertical,
      ]);
    });
  });

  group('VelocityPosition', () {
    test('应该包含所有位置选项', () {
      expect(VelocityPosition.values.length, 8);
      expect(VelocityPosition.values, [
        VelocityPosition.top,
        VelocityPosition.right,
        VelocityPosition.bottom,
        VelocityPosition.left,
        VelocityPosition.topLeft,
        VelocityPosition.topRight,
        VelocityPosition.bottomLeft,
        VelocityPosition.bottomRight,
      ]);
    });
  });

  group('VelocityDensity', () {
    test('应该包含所有密度选项', () {
      expect(VelocityDensity.values.length, 3);
      expect(VelocityDensity.values, [
        VelocityDensity.compact,
        VelocityDensity.standard,
        VelocityDensity.comfortable,
      ]);
    });
  });

  group('VelocityBreakpoint', () {
    test('应该包含所有断点选项', () {
      expect(VelocityBreakpoint.values.length, 6);
      expect(VelocityBreakpoint.values, [
        VelocityBreakpoint.xs,
        VelocityBreakpoint.sm,
        VelocityBreakpoint.md,
        VelocityBreakpoint.lg,
        VelocityBreakpoint.xl,
        VelocityBreakpoint.xxl,
      ]);
    });

    test('扩展方法应该返回正确的断点值', () {
      expect(VelocityBreakpoint.xs.value, 0);
      expect(VelocityBreakpoint.sm.value, 576);
      expect(VelocityBreakpoint.md.value, 768);
      expect(VelocityBreakpoint.lg.value, 992);
      expect(VelocityBreakpoint.xl.value, 1200);
      expect(VelocityBreakpoint.xxl.value, 1400);
    });

    test('断点值应该递增', () {
      const breakpoints = VelocityBreakpoint.values;
      for (var i = 1; i < breakpoints.length; i++) {
        expect(breakpoints[i].value > breakpoints[i - 1].value, true);
      }
    });
  });

  group('VelocityThemeMode', () {
    test('应该包含所有主题模式选项', () {
      expect(VelocityThemeMode.values.length, 3);
      expect(VelocityThemeMode.values, [
        VelocityThemeMode.light,
        VelocityThemeMode.dark,
        VelocityThemeMode.system,
      ]);
    });
  });

  group('VelocityInputType', () {
    test('应该包含所有输入类型选项', () {
      expect(VelocityInputType.values.length, 8);
      expect(VelocityInputType.values, [
        VelocityInputType.text,
        VelocityInputType.password,
        VelocityInputType.email,
        VelocityInputType.number,
        VelocityInputType.phone,
        VelocityInputType.url,
        VelocityInputType.search,
        VelocityInputType.textarea,
      ]);
    });
  });

  group('VelocityButtonType', () {
    test('应该包含所有按钮类型选项', () {
      expect(VelocityButtonType.values.length, 5);
      expect(VelocityButtonType.values, [
        VelocityButtonType.filled,
        VelocityButtonType.outlined,
        VelocityButtonType.text,
        VelocityButtonType.icon,
        VelocityButtonType.fab,
      ]);
    });
  });

  group('VelocityIconPosition', () {
    test('应该包含所有图标位置选项', () {
      expect(VelocityIconPosition.values.length, 4);
      expect(VelocityIconPosition.values, [
        VelocityIconPosition.left,
        VelocityIconPosition.right,
        VelocityIconPosition.top,
        VelocityIconPosition.bottom,
      ]);
    });
  });

  group('VelocityLoadingState', () {
    test('应该包含所有加载状态选项', () {
      expect(VelocityLoadingState.values.length, 4);
      expect(VelocityLoadingState.values, [
        VelocityLoadingState.idle,
        VelocityLoadingState.loading,
        VelocityLoadingState.success,
        VelocityLoadingState.error,
      ]);
    });
  });

  group('VelocitySortDirection', () {
    test('应该包含所有排序方向选项', () {
      expect(VelocitySortDirection.values.length, 3);
      expect(VelocitySortDirection.values, [
        VelocitySortDirection.ascending,
        VelocitySortDirection.descending,
        VelocitySortDirection.none,
      ]);
    });
  });

  group('VelocityNotificationType', () {
    test('应该包含所有通知类型选项', () {
      expect(VelocityNotificationType.values.length, 4);
      expect(VelocityNotificationType.values, [
        VelocityNotificationType.success,
        VelocityNotificationType.warning,
        VelocityNotificationType.error,
        VelocityNotificationType.info,
      ]);
    });
  });

  group('VelocityModalType', () {
    test('应该包含所有模态框类型选项', () {
      expect(VelocityModalType.values.length, 4);
      expect(VelocityModalType.values, [
        VelocityModalType.dialog,
        VelocityModalType.drawer,
        VelocityModalType.bottomSheet,
        VelocityModalType.fullscreen,
      ]);
    });
  });

  group('VelocityStepState', () {
    test('应该包含所有步骤状态选项', () {
      expect(VelocityStepState.values.length, 5);
      expect(VelocityStepState.values, [
        VelocityStepState.waiting,
        VelocityStepState.active,
        VelocityStepState.completed,
        VelocityStepState.error,
        VelocityStepState.disabled,
      ]);
    });
  });
}
