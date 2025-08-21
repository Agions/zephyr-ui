/// 枚举测试
///
/// 测试枚举类型的正确性和扩展方法。
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';

void main() {
  group('ZephyrSize', () {
    test('应该包含所有尺寸选项', () {
      expect(ZephyrSize.values.length, 5);
      expect(ZephyrSize.values, [
        ZephyrSize.xs,
        ZephyrSize.sm,
        ZephyrSize.md,
        ZephyrSize.lg,
        ZephyrSize.xl,
      ]);
    });

    test('扩展方法应该返回正确的值', () {
      expect(ZephyrSize.xs.value, 24.0);
      expect(ZephyrSize.sm.value, 32.0);
      expect(ZephyrSize.md.value, 40.0);
      expect(ZephyrSize.lg.value, 48.0);
      expect(ZephyrSize.xl.value, 56.0);
    });

    test('扩展方法应该返回正确的内边距', () {
      expect(ZephyrSize.xs.padding, 8.0);
      expect(ZephyrSize.sm.padding, 12.0);
      expect(ZephyrSize.md.padding, 16.0);
      expect(ZephyrSize.lg.padding, 20.0);
      expect(ZephyrSize.xl.padding, 24.0);
    });

    test('值应该递增', () {
      const sizes = ZephyrSize.values;
      for (int i = 1; i < sizes.length; i++) {
        expect(sizes[i].value > sizes[i - 1].value, true);
        expect(sizes[i].padding > sizes[i - 1].padding, true);
      }
    });
  });

  group('ZephyrVariant', () {
    test('应该包含所有变体选项', () {
      expect(ZephyrVariant.values.length, 10);
      expect(ZephyrVariant.values, [
        ZephyrVariant.primary,
        ZephyrVariant.secondary,
        ZephyrVariant.success,
        ZephyrVariant.warning,
        ZephyrVariant.error,
        ZephyrVariant.info,
        ZephyrVariant.neutral,
        ZephyrVariant.outline,
        ZephyrVariant.ghost,
        ZephyrVariant.link,
      ]);
    });
  });

  group('ZephyrState', () {
    test('应该包含所有状态选项', () {
      expect(ZephyrState.values.length, 7);
      expect(ZephyrState.values, [
        ZephyrState.normal,
        ZephyrState.hover,
        ZephyrState.focus,
        ZephyrState.active,
        ZephyrState.disabled,
        ZephyrState.loading,
        ZephyrState.error,
      ]);
    });
  });

  group('ZephyrAlignment', () {
    test('应该包含所有对齐选项', () {
      expect(ZephyrAlignment.values.length, 4);
      expect(ZephyrAlignment.values, [
        ZephyrAlignment.left,
        ZephyrAlignment.center,
        ZephyrAlignment.right,
        ZephyrAlignment.justify,
      ]);
    });
  });

  group('ZephyrDirection', () {
    test('应该包含所有方向选项', () {
      expect(ZephyrDirection.values.length, 2);
      expect(ZephyrDirection.values, [
        ZephyrDirection.horizontal,
        ZephyrDirection.vertical,
      ]);
    });
  });

  group('ZephyrPosition', () {
    test('应该包含所有位置选项', () {
      expect(ZephyrPosition.values.length, 8);
      expect(ZephyrPosition.values, [
        ZephyrPosition.top,
        ZephyrPosition.right,
        ZephyrPosition.bottom,
        ZephyrPosition.left,
        ZephyrPosition.topLeft,
        ZephyrPosition.topRight,
        ZephyrPosition.bottomLeft,
        ZephyrPosition.bottomRight,
      ]);
    });
  });

  group('ZephyrDensity', () {
    test('应该包含所有密度选项', () {
      expect(ZephyrDensity.values.length, 3);
      expect(ZephyrDensity.values, [
        ZephyrDensity.compact,
        ZephyrDensity.standard,
        ZephyrDensity.comfortable,
      ]);
    });
  });

  group('ZephyrBreakpoint', () {
    test('应该包含所有断点选项', () {
      expect(ZephyrBreakpoint.values.length, 6);
      expect(ZephyrBreakpoint.values, [
        ZephyrBreakpoint.xs,
        ZephyrBreakpoint.sm,
        ZephyrBreakpoint.md,
        ZephyrBreakpoint.lg,
        ZephyrBreakpoint.xl,
        ZephyrBreakpoint.xxl,
      ]);
    });

    test('扩展方法应该返回正确的断点值', () {
      expect(ZephyrBreakpoint.xs.value, 0);
      expect(ZephyrBreakpoint.sm.value, 576);
      expect(ZephyrBreakpoint.md.value, 768);
      expect(ZephyrBreakpoint.lg.value, 992);
      expect(ZephyrBreakpoint.xl.value, 1200);
      expect(ZephyrBreakpoint.xxl.value, 1400);
    });

    test('断点值应该递增', () {
      const breakpoints = ZephyrBreakpoint.values;
      for (int i = 1; i < breakpoints.length; i++) {
        expect(breakpoints[i].value > breakpoints[i - 1].value, true);
      }
    });
  });

  group('ZephyrThemeMode', () {
    test('应该包含所有主题模式选项', () {
      expect(ZephyrThemeMode.values.length, 3);
      expect(ZephyrThemeMode.values, [
        ZephyrThemeMode.light,
        ZephyrThemeMode.dark,
        ZephyrThemeMode.system,
      ]);
    });
  });

  group('ZephyrInputType', () {
    test('应该包含所有输入类型选项', () {
      expect(ZephyrInputType.values.length, 8);
      expect(ZephyrInputType.values, [
        ZephyrInputType.text,
        ZephyrInputType.password,
        ZephyrInputType.email,
        ZephyrInputType.number,
        ZephyrInputType.phone,
        ZephyrInputType.url,
        ZephyrInputType.search,
        ZephyrInputType.textarea,
      ]);
    });
  });

  group('ZephyrButtonType', () {
    test('应该包含所有按钮类型选项', () {
      expect(ZephyrButtonType.values.length, 5);
      expect(ZephyrButtonType.values, [
        ZephyrButtonType.filled,
        ZephyrButtonType.outlined,
        ZephyrButtonType.text,
        ZephyrButtonType.icon,
        ZephyrButtonType.fab,
      ]);
    });
  });

  group('ZephyrIconPosition', () {
    test('应该包含所有图标位置选项', () {
      expect(ZephyrIconPosition.values.length, 4);
      expect(ZephyrIconPosition.values, [
        ZephyrIconPosition.left,
        ZephyrIconPosition.right,
        ZephyrIconPosition.top,
        ZephyrIconPosition.bottom,
      ]);
    });
  });

  group('ZephyrLoadingState', () {
    test('应该包含所有加载状态选项', () {
      expect(ZephyrLoadingState.values.length, 4);
      expect(ZephyrLoadingState.values, [
        ZephyrLoadingState.idle,
        ZephyrLoadingState.loading,
        ZephyrLoadingState.success,
        ZephyrLoadingState.error,
      ]);
    });
  });

  group('ZephyrSortDirection', () {
    test('应该包含所有排序方向选项', () {
      expect(ZephyrSortDirection.values.length, 3);
      expect(ZephyrSortDirection.values, [
        ZephyrSortDirection.ascending,
        ZephyrSortDirection.descending,
        ZephyrSortDirection.none,
      ]);
    });
  });

  group('ZephyrNotificationType', () {
    test('应该包含所有通知类型选项', () {
      expect(ZephyrNotificationType.values.length, 4);
      expect(ZephyrNotificationType.values, [
        ZephyrNotificationType.success,
        ZephyrNotificationType.warning,
        ZephyrNotificationType.error,
        ZephyrNotificationType.info,
      ]);
    });
  });

  group('ZephyrModalType', () {
    test('应该包含所有模态框类型选项', () {
      expect(ZephyrModalType.values.length, 4);
      expect(ZephyrModalType.values, [
        ZephyrModalType.dialog,
        ZephyrModalType.drawer,
        ZephyrModalType.bottomSheet,
        ZephyrModalType.fullscreen,
      ]);
    });
  });

  group('ZephyrStepState', () {
    test('应该包含所有步骤状态选项', () {
      expect(ZephyrStepState.values.length, 5);
      expect(ZephyrStepState.values, [
        ZephyrStepState.waiting,
        ZephyrStepState.active,
        ZephyrStepState.completed,
        ZephyrStepState.error,
        ZephyrStepState.disabled,
      ]);
    });
  });
}
