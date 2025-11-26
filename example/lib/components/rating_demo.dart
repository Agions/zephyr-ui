import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class RatingDemo extends StatefulWidget {
  const RatingDemo({Key? key}) : super(key: key);

  @override
  State<RatingDemo> createState() => _RatingDemoState();
}

class _RatingDemoState extends State<RatingDemo> {
  double _rating = 3.0;
  double _halfRating = 2.5;
  final double _readOnlyRating = 4.0;
  double _customIconRating = 0.0;
  double _labeledRating = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Component Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Rating'),
            _buildBasicRating(),
            const SizedBox(height: 32),
            _buildSectionTitle('Half Rating'),
            _buildHalfRating(),
            const SizedBox(height: 32),
            _buildSectionTitle('Read-Only Rating'),
            _buildReadOnlyRating(),
            const SizedBox(height: 32),
            _buildSectionTitle('Custom Icons'),
            _buildCustomIconRating(),
            const SizedBox(height: 32),
            _buildSectionTitle('Labeled Rating'),
            _buildLabeledRating(),
            const SizedBox(height: 32),
            _buildSectionTitle('Rating Display'),
            _buildRatingDisplay(),
            const SizedBox(height: 32),
            _buildSectionTitle('Interactive Demo'),
            _buildInteractiveDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildBasicRating() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Rating: $_rating'),
            SizedBox(height: 16),
            ZephyrRating(
              value: _rating,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Tap on stars to rate. Current value: $_rating',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHalfRating() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Half Rating: $_halfRating'),
            SizedBox(height: 16),
            ZephyrRating(
              value: _halfRating,
              allowHalfRating: true,
              onChanged: (value) {
                setState(() {
                  _halfRating = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Click once for full star, click again for half star. Current value: $_halfRating',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyRating() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Read-Only Rating:'),
            SizedBox(height: 16),
            ZephyrRating(
              value: _readOnlyRating,
              readOnly: true,
            ),
            SizedBox(height: 16),
            Text(
              'This rating is read-only. Value: $_readOnlyRating',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomIconRating() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Custom Icons Rating: $_customIconRating'),
            SizedBox(height: 16),
            ZephyrRating(
              value: _customIconRating,
              customIcons: [Icons.favorite, Icons.favorite_border],
              selectedColor: Colors.red,
              unselectedColor: Colors.pink.shade100,
              onChanged: (value) {
                setState(() {
                  _customIconRating = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Using heart icons instead of stars. Current value: $_customIconRating',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledRating() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Labeled Rating: $_labeledRating'),
            SizedBox(height: 16),
            ZephyrRating(
              value: _labeledRating,
              allowHalfRating: true,
              showLabels: true,
              onChanged: (value) {
                setState(() {
                  _labeledRating = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Shows numeric labels below stars. Current value: $_labeledRating',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingDisplay() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rating Display (Read-Only):'),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product A: 4.5'),
                    ZephyrRatingDisplay(
                      value: 4.5,
                      allowHalfRating: true,
                      showValue: true,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product B: 3.0'),
                    ZephyrRatingDisplay(
                      value: 3.0,
                      showValue: true,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product C: 5.0'),
                    ZephyrRatingDisplay(
                      value: 5.0,
                      showValue: true,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Read-only rating displays with values',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Interactive Demo:'),
            SizedBox(height: 16),
            _buildRatingConfig(),
            SizedBox(height: 16),
            _buildPreviewRating(),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('Allow Half Rating'),
          value: true,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: const Text('Show Labels'),
          value: false,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: const Text('Show Tooltips'),
          value: true,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: const Text('Allow Clear'),
          value: true,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildPreviewRating() {
    return ZephyrRating(
      value: 3.0,
      allowHalfRating: true,
      showLabels: false,
      showTooltip: true,
      allowClear: true,
      onChanged: (value) {},
    );
  }
}
