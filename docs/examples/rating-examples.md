# ZephyrRating Component Examples

## Overview

The ZephyrRating component provides a comprehensive star rating system with interactive selection, half-star support, and customizable styling. This example demonstrates various use cases and configurations.

## Basic Examples

### 1. Simple Rating

```dart
class SimpleRatingExample extends StatefulWidget {
  @override
  _SimpleRatingExampleState createState() => _SimpleRatingExampleState();
}

class _SimpleRatingExampleState extends State<SimpleRatingExample> {
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Simple Rating',
      content: Column(
        children: [
          ZephyrRating(
            value: _rating,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Current Rating: $_rating',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 2. Half Rating Support

```dart
class HalfRatingExample extends StatefulWidget {
  @override
  _HalfRatingExampleState createState() => _HalfRatingExampleState();
}

class _HalfRatingExampleState extends State<HalfRatingExample> {
  double _rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Half Rating Support',
      content: Column(
        children: [
          ZephyrRating(
            value: _rating,
            allowHalfRating: true,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Current Rating: $_rating',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap once for full star, tap again for half star',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3. Read-only Rating Display

```dart
class ReadOnlyRatingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Read-only Rating Display',
      content: Column(
        children: [
          const ZephyrRatingDisplay(
            value: 4.5,
            allowHalfRating: true,
            showValue: true,
          ),
          const SizedBox(height: 16),
          const ZephyrRatingDisplay(
            value: 3.0,
            size: 20,
          ),
          const SizedBox(height: 16),
          const ZephyrRatingDisplay(
            value: 5.0,
            size: 16,
            showValue: true,
            valueStyle: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
```

## Customization Examples

### 4. Custom Icons and Colors

```dart
class CustomRatingExample extends StatefulWidget {
  @override
  _CustomRatingExampleState createState() => _CustomRatingExampleState();
}

class _CustomRatingExampleState extends State<CustomRatingExample> {
  double _rating = 4.0;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Custom Icons and Colors',
      content: Column(
        children: [
          ZephyrRating(
            value: _rating,
            customIcons: [
              Icons.favorite,
              Icons.favorite_border,
            ],
            selectedColor: Colors.red,
            unselectedColor: Colors.grey[300],
            hoverColor: Colors.red[200],
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Rating with custom heart icons',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 5. Custom Theme

```dart
class ThemedRatingExample extends StatefulWidget {
  @override
  _ThemedRatingExampleState createState() => _ThemedRatingExampleState();
}

class _ThemedRatingExampleState extends State<ThemedRatingExample> {
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Custom Theme',
      content: Column(
        children: [
          ZephyrRating(
            value: _rating,
            theme: ZephyrRatingTheme(
              selectedColor: Colors.purple,
              unselectedColor: Colors.grey[300],
              hoverColor: Colors.purple[200],
              selectedIcon: Icons.star,
              unselectedIcon: Icons.star_border,
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            showLabels: true,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Custom purple theme with labels',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 6. Vertical Layout

```dart
class VerticalRatingExample extends StatefulWidget {
  @override
  _VerticalRatingExampleState createState() => _VerticalRatingExampleState();
}

class _VerticalRatingExampleState extends State<VerticalRatingExample> {
  double _rating = 4.0;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Vertical Layout',
      content: Column(
        children: [
          ZephyrRating(
            value: _rating,
            direction: Axis.vertical,
            showLabels: true,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Vertical rating with labels',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Interactive Examples

### 7. Rating with Clear Functionality

```dart
class ClearableRatingExample extends StatefulWidget {
  @override
  _ClearableRatingExampleState createState() => _ClearableRatingExampleState();
}

class _ClearableRatingExampleState extends State<ClearableRatingExample> {
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Clearable Rating',
      content: Column(
        children: [
          ZephyrRating(
            value: _rating,
            allowClear: true,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Current Rating: $_rating',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Click on the selected star again to clear the rating',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 8. Rating with Hover Feedback

```dart
class HoverRatingExample extends StatefulWidget {
  @override
  _HoverRatingExampleState createState() => _HoverRatingExampleState();
}

class _HoverRatingExampleState extends State<HoverRatingExample> {
  double _rating = 3.0;
  double _hoverRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Rating with Hover Feedback',
      content: Column(
        children: [
          ZephyrRating(
            value: _rating,
            onHover: (value) {
              setState(() {
                _hoverRating = value;
              });
            },
            onChanged: (value) {
              setState(() {
                _rating = value;
                _hoverRating = 0.0;
              });
            },
          ),
          const SizedBox(height: 16),
          if (_hoverRating > 0)
            Text(
              'Hovering over: $_hoverRating stars',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          Text(
            'Current Rating: $_rating',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 9. Disabled Rating States

```dart
class DisabledRatingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Disabled States',
      content: Column(
        children: [
          const Text(
            'Read Only',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const ZephyrRating(
            value: 4.0,
            readOnly: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'Disabled',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const ZephyrRating(
            value: 3.0,
            disabled: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'Disabled with custom color',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ZephyrRating(
            value: 2.0,
            disabled: true,
            unselectedColor: Colors.grey[100],
            selectedColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
```

## Advanced Examples

### 10. Product Rating System

```dart
class ProductRatingExample extends StatefulWidget {
  @override
  _ProductRatingExampleState createState() => _ProductRatingExampleState();
}

class _ProductRatingExampleState extends State<ProductRatingExample> {
  double _userRating = 0.0;
  final double _averageRating = 4.2;
  final int _totalReviews = 156;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Product Rating',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Average rating display
          Row(
            children: [
              ZephyrRatingDisplay(
                value: _averageRating,
                allowHalfRating: true,
                showValue: true,
                valueStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_averageRating out of 5',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$_totalReviews reviews',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // User rating
          const Text(
            'Rate this product',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ZephyrRating(
            value: _userRating,
            allowHalfRating: true,
            showLabels: true,
            tooltipPrefix: 'Rate',
            onChanged: (value) {
              setState(() {
                _userRating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          
          // Rating feedback
          if (_userRating > 0)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getRatingFeedback(_userRating),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _getRatingFeedback(double rating) {
    if (rating >= 4.5) return 'Excellent! Thank you for your feedback!';
    if (rating >= 4.0) return 'Great! We appreciate your rating!';
    if (rating >= 3.0) return 'Good! Thank you for your feedback!';
    if (rating >= 2.0) return 'Thanks! We\'ll work to improve!';
    return 'Thank you for your feedback!';
  }
}
```

### 11. Rating Statistics

```dart
class RatingStatisticsExample extends StatelessWidget {
  final Map<int, int> _ratingDistribution = {
    5: 89,
    4: 45,
    3: 12,
    2: 7,
    1: 3,
  };

  @override
  Widget build(BuildContext context) {
    final totalReviews = _ratingDistribution.values.fold(0, (a, b) => a + b);
    final averageRating = _ratingDistribution.entries.fold<double>(
      0.0,
      (sum, entry) => sum + (entry.key * entry.value),
    ) / totalReviews;

    return ZephyrCard(
      title: 'Rating Statistics',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall rating
          Row(
            children: [
              Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ZephyrRatingDisplay(
                    value: averageRating,
                    allowHalfRating: true,
                    size: 16,
                  ),
                  Text(
                    '$totalReviews reviews',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: _ratingDistribution.entries
                      .toList()
                      .reversed
                      .map((entry) => _buildRatingBar(entry.key, entry.value, totalReviews))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, int count, int total) {
    final percentage = (count / total) * 100;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$stars',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 8),
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
```

### 12. Multi-Criteria Rating

```dart
class MultiCriteriaRatingExample extends StatefulWidget {
  @override
  _MultiCriteriaRatingExampleState createState() => _MultiCriteriaRatingExampleState();
}

class _MultiCriteriaRatingExampleState extends State<MultiCriteriaRatingExample> {
  final Map<String, double> _ratings = {
    'Quality': 0.0,
    'Value': 0.0,
    'Shipping': 0.0,
    'Service': 0.0,
  };

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      title: 'Multi-Criteria Rating',
      content: Column(
        children: [
          ..._ratings.entries.map((entry) => _buildRatingRow(entry.key, entry.value)),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          _buildOverallRating(),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String criteria, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              criteria,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ZephyrRating(
              value: rating,
              allowHalfRating: true,
              size: 20,
              onChanged: (value) {
                setState(() {
                  _ratings[criteria] = value;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    final overallRating = _ratings.values.fold(0.0, (a, b) => a + b) / _ratings.length;
    
    return Column(
      children: [
        const Text(
          'Overall Rating',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ZephyrRatingDisplay(
          value: overallRating,
          allowHalfRating: true,
          showValue: true,
          valueStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
```

## Complete Example App

Here's a complete example app that demonstrates all the rating components:

```dart
class RatingDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrApp(
      title: 'ZephyrUI Rating Demo',
      theme: ZephyrTheme.light(),
      home: const RatingDemoHome(),
    );
  }
}

class RatingDemoHome extends StatelessWidget {
  const RatingDemoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Rating Components'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rating Component Examples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore different rating configurations and use cases',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            
            // Basic Examples
            const SimpleRatingExample(),
            const SizedBox(height: 16),
            const HalfRatingExample(),
            const SizedBox(height: 16),
            const ReadOnlyRatingExample(),
            const SizedBox(height: 32),
            
            // Customization Examples
            const CustomRatingExample(),
            const SizedBox(height: 16),
            const ThemedRatingExample(),
            const SizedBox(height: 16),
            const VerticalRatingExample(),
            const SizedBox(height: 32),
            
            // Interactive Examples
            const ClearableRatingExample(),
            const SizedBox(height: 16),
            const HoverRatingExample(),
            const SizedBox(height: 16),
            const DisabledRatingExample(),
            const SizedBox(height: 32),
            
            // Advanced Examples
            const ProductRatingExample(),
            const SizedBox(height: 16),
            const RatingStatisticsExample(),
            const SizedBox(height: 16),
            const MultiCriteriaRatingExample(),
          ],
        ),
      ),
    );
  }
}
```

## Best Practices

1. **Use appropriate size**: Choose icon sizes based on context (16px for compact, 24px for standard, 32px for prominent)
2. **Provide clear feedback**: Use tooltips and labels to help users understand the rating system
3. **Consider read-only displays**: Use `ZephyrRatingDisplay` for static ratings to improve performance
4. **Handle edge cases**: Always validate rating values and handle error conditions
5. **Use semantic labels**: Provide meaningful semantic labels for accessibility
6. **Test thoroughly**: Test on different devices and screen sizes

## Performance Tips

- Use `ZephyrRatingDisplay` for read-only ratings
- Enable `allowHalfRating` only when needed
- Use custom icons sparingly
- Consider using `const` constructors for static displays
- Test performance with large numbers of rating components

## Accessibility Guidelines

- Always provide semantic labels
- Support keyboard navigation
- Ensure proper contrast ratios
- Provide text alternatives for visual information
- Test with screen readers

This comprehensive example demonstrates the versatility and power of the ZephyrRating component. Each example can be used as a starting point for your own implementations.