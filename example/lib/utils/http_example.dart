import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// HTTP客户端使用示例
class HttpExample extends StatefulWidget {
  const HttpExample({super.key});

  @override
  State<HttpExample> createState() => _HttpExampleState();
}

class _HttpExampleState extends State<HttpExample> {
  String _response = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _setupInterceptors();
  }

  /// 设置请求和响应拦截器
  void _setupInterceptors() {
    // 添加请求拦截器 - 示例：添加认证token
    velocityHttpClient.addRequestInterceptor((request) async {
      print('请求拦截器 - URL: ${request.url}');

      // 在请求头中添加认证token
      final authenticatedHeaders = {
        ...request.headers,
        'Authorization': 'Bearer your-auth-token',
        'X-Request-Time': DateTime.now().millisecondsSinceEpoch.toString(),
      };

      return request.copyWith(headers: authenticatedHeaders);
    });

    // 添加响应拦截器 - 示例：统一处理错误
    velocityHttpClient.addResponseInterceptor((response) async {
      print('响应拦截器 - 状态码: ${response.statusCode}');

      // 统一处理错误响应
      if (!response.isSuccess) {
        print('请求失败: ${response.statusCode}');
        // 可以在这里添加统一的错误处理逻辑
      }

      return response;
    });

    // 添加错误拦截器 - 示例：记录错误日志
    velocityHttpClient.addErrorInterceptor((error, request) async {
      print('错误拦截器 - 错误: $error');
      // 可以在这里添加错误日志记录或上报
    });
  }

  /// 发送GET请求示例
  Future<void> _sendGetRequest() async {
    setState(() {
      _isLoading = true;
      _response = '发送GET请求...';
    });

    try {
      final response = await velocityHttpClient.get(
        'https://jsonplaceholder.typicode.com/posts',
        {'_limit': '5'}, // 查询参数
        {'Content-Type': 'application/json'},
      );

      setState(() {
        _isLoading = false;
        _response = 'GET请求成功: ${response.statusCode}\n\n响应数据: ${response.json}';
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _response = 'GET请求失败: $error';
      });
    }
  }

  /// 发送POST请求示例
  Future<void> _sendPostRequest() async {
    setState(() {
      _isLoading = true;
      _response = '发送POST请求...';
    });

    try {
      final response = await velocityHttpClient.post(
        'https://jsonplaceholder.typicode.com/posts',
        {
          'title': '测试标题',
          'body': '这是测试内容',
          'userId': 1,
        }, // 请求体
        {'Content-Type': 'application/json'},
        {}, // 查询参数
      );

      setState(() {
        _isLoading = false;
        _response =
            'POST请求成功: ${response.statusCode}\n\n响应数据: ${response.json}';
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _response = 'POST请求失败: $error';
      });
    }
  }

  /// 重置响应
  void _resetResponse() {
    setState(() {
      _response = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP客户端示例'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HTTP客户端使用示例',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: VelocityColors.gray800,
              ),
            ),
            const SizedBox(height: 20),

            // 拦截器说明
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: VelocityColors.withOpacity(
                    VelocityColors.primaryLight, 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: VelocityColors.primaryLight),
              ),
              child: const Text(
                '已设置拦截器：\n1. 请求拦截器：添加认证token和请求时间\n2. 响应拦截器：统一处理错误响应\n3. 错误拦截器：记录错误日志',
                style: TextStyle(
                  color: VelocityColors.primaryDark,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 请求按钮
            Row(
              children: [
                Expanded(
                  child: VelocityButton.text(
                    text: '发送GET请求',
                    onPressed: _sendGetRequest,
                    disabled: _isLoading,
                    type: VelocityButtonType.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: VelocityButton.text(
                    text: '发送POST请求',
                    onPressed: _sendPostRequest,
                    disabled: _isLoading,
                    type: VelocityButtonType.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 重置按钮
            VelocityButton.text(
              text: '重置',
              onPressed: _resetResponse,
              disabled: _isLoading,
            ),
            const SizedBox(height: 20),

            // 响应结果
            const Text(
              '响应结果：',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: VelocityColors.gray800,
              ),
            ),
            const SizedBox(height: 8),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: VelocityColors.gray50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: VelocityColors.gray200),
                    ),
                    child: Text(
                      _response,
                      style: const TextStyle(
                        fontSize: 14,
                        color: VelocityColors.gray800,
                        fontFamily: 'Courier New',
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
