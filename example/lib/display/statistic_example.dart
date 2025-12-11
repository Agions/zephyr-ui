import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 统计数值
class StatisticExample extends StatelessWidget {
  const StatisticExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistic 统计数值'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicStatistic()),
            _buildSection('带前后缀', _buildPrefixSuffixStatistic()),
            _buildSection('趋势显示', _buildTrendStatistic()),
            _buildSection('倒计时', _buildCountdown()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: VelocityColors.gray800,
            ),
          ),
        ),
        content,
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }

  Widget _buildBasicStatistic() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        VelocityStatistic(
          title: '活跃用户',
          value: 112893,
        ),
        VelocityStatistic(
          title: '账号余额 (CNY)',
          value: 112893,
          precision: 2,
        ),
      ],
    );
  }

  Widget _buildPrefixSuffixStatistic() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        VelocityStatistic(
          title: 'Feedback',
          value: 1128,
          prefix: Icon(Icons.thumb_up),
        ),
        VelocityStatistic(
          title: 'Unmerged',
          value: 93,
          suffix: '/ 100',
        ),
      ],
    );
  }

  Widget _buildTrendStatistic() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        VelocityStatistic(
          title: '周同比',
          value: 11.28,
          precision: 2,
          suffix: '%',
          trend: VelocityStatisticTrend.up,
          trendValue: '1.2%',
        ),
        VelocityStatistic(
          title: '日同比',
          value: 9.30,
          precision: 2,
          suffix: '%',
          trend: VelocityStatisticTrend.down,
          trendValue: '0.5%',
        ),
      ],
    );
  }

  Widget _buildCountdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        VelocityCountdown(
          endTime: DateTime.now().add(const Duration(hours: 2, minutes: 30)),
          format: 'HH:mm:ss',
        ),
        VelocityCountdown(
          endTime: DateTime.now().add(const Duration(days: 2)),
          format: 'dd天 HH:mm:ss',
        ),
      ],
    );
  }
}
