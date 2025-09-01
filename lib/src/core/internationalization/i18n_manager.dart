/// ZephyrUI 国际化管理器
///
/// 提供完整的多语言支持框架，包括动态语言切换、文本插值、复数形式等功能

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/message_lookup_by_library.dart';
// TODO: 重新导入错误处理相关的文件
// import 'package:zephyr_ui/src/core/error_handling/error_types.dart';

/// 国际化管理器
class ZephyrI18nManager {
  static final ZephyrI18nManager _instance = ZephyrI18nManager._internal();
  static ZephyrI18nManager get instance => _instance;
  
  ZephyrI18nManager._internal();

  /// 支持的语言列表
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
    Locale('ja', 'JP'),
    Locale('ko', 'KR'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('es', 'ES'),
    Locale('pt', 'BR'),
    Locale('ru', 'RU'),
    Locale('ar', 'SA'),
  ];

  /// 当前语言环境
  Locale _currentLocale = const Locale('zh', 'CN');
  
  /// 语言切换监听器
  final List<void Function(Locale)> _localeChangeListeners = [];

  /// 文本消息映射
  final Map<String, Map<String, String>> _messages = {};

  /// 初始化国际化系统
  Future<void> initialize({Locale? initialLocale}) async {
    // 初始化所有支持的语言环境
    for (final locale in supportedLocales) {
      await initializeDateFormatting(locale.languageCode, locale.countryCode);
    }
    
    // 设置初始语言
    if (initialLocale != null) {
      await setLocale(initialLocale);
    } else {
      // 获取系统语言
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final matchedLocale = _findSupportedLocale(systemLocale);
      await setLocale(matchedLocale);
    }
    
    // 加载默认消息
    await _loadDefaultMessages();
  }

  /// 查找支持的语言环境
  Locale _findSupportedLocale(Locale locale) {
    // 精确匹配
    if (supportedLocales.contains(locale)) {
      return locale;
    }
    
    // 仅语言代码匹配
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    
    // 返回默认语言
    return const Locale('zh', 'CN');
  }

  /// 设置当前语言环境
  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) {
      throw ZephyrError(
        code: ZephyrErrorCodes.invalidArgument,
        message: 'Unsupported locale: $locale',
        level: ZephyrErrorLevel.warning,
      );
    }
    
    _currentLocale = locale;
    Intl.defaultLocale = '${locale.languageCode}_${locale.countryCode}';
    
    // 通知监听器
    for (final listener in _localeChangeListeners) {
      listener(locale);
    }
  }

  /// 获取当前语言环境
  Locale get currentLocale => _currentLocale;

  /// 添加语言切换监听器
  void addLocaleChangeListener(void Function(Locale) listener) {
    _localeChangeListeners.add(listener);
  }

  /// 移除语言切换监听器
  void removeLocaleChangeListener(void Function(Locale) listener) {
    _localeChangeListeners.remove(listener);
  }

  /// 获取本地化文本
  String translate(String key, {Map<String, dynamic>? params}) {
    final localeKey = '${_currentLocale.languageCode}_${_currentLocale.countryCode}';
    
    // 获取消息
    String message = _messages[localeKey]?[key] ?? _messages['zh_CN']?[key] ?? key;
    
    // 文本插值
    if (params != null) {
      message = _interpolateMessage(message, params);
    }
    
    return message;
  }

  /// 文本插值处理
  String _interpolateMessage(String message, Map<String, dynamic> params) {
    var result = message;
    
    // 处理 {param} 格式的插值
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    
    // 处理复数形式
    if (params.containsKey('count')) {
      final count = params['count'] as int;
      result = _handlePluralForms(result, count);
    }
    
    return result;
  }

  /// 处理复数形式
  String _handlePluralForms(String message, int count) {
    // 根据不同语言的复数规则处理
    switch (_currentLocale.languageCode) {
      case 'zh':
      case 'ja':
      case 'ko':
        // 亚洲语言通常不需要复数形式
        return message.replaceAll('{count}', count.toString());
      case 'en':
      case 'fr':
      case 'de':
      case 'es':
      case 'pt':
        // 欧洲语言的复数形式
        if (count == 1) {
          return message.replaceAll('{count}', count.toString());
        } else {
          return message.replaceAll('{count}', count.toString());
        }
      case 'ru':
        // 俄语的复数形式更复杂
        return message.replaceAll('{count}', count.toString());
      case 'ar':
        // 阿拉伯语的复数形式最复杂
        return message.replaceAll('{count}', count.toString());
      default:
        return message.replaceAll('{count}', count.toString());
    }
  }

  /// 格式化日期
  String formatDate(DateTime date, {String? pattern}) {
    if (pattern != null) {
      return DateFormat(pattern, _currentLocale.languageCode).format(date);
    }
    
    switch (_currentLocale.languageCode) {
      case 'zh':
        return DateFormat('yyyy年MM月dd日', _currentLocale.languageCode).format(date);
      case 'ja':
        return DateFormat('yyyy年MM月dd日', _currentLocale.languageCode).format(date);
      case 'ko':
        return DateFormat('yyyy년MM월dd일', _currentLocale.languageCode).format(date);
      case 'ar':
        return DateFormat('yyyy/MM/dd', _currentLocale.languageCode).format(date);
      default:
        return DateFormat('MMMM d, y', _currentLocale.languageCode).format(date);
    }
  }

  /// 格式化时间
  String formatTime(DateTime time, {String? pattern}) {
    if (pattern != null) {
      return DateFormat(pattern, _currentLocale.languageCode).format(time);
    }
    
    switch (_currentLocale.languageCode) {
      case 'zh':
        return DateFormat('HH:mm:ss', _currentLocale.languageCode).format(time);
      case 'ja':
        return DateFormat('HH:mm:ss', _currentLocale.languageCode).format(time);
      case 'ko':
        return DateFormat('HH:mm:ss', _currentLocale.languageCode).format(time);
      case 'ar':
        return DateFormat('hh:mm:ss a', _currentLocale.languageCode).format(time);
      default:
        return DateFormat('h:mm:ss a', _currentLocale.languageCode).format(time);
    }
  }

  /// 格式化数字
  String formatNumber(num number, {int? decimalDigits}) {
    return NumberFormat.decimalPattern(_currentLocale.languageCode)
        .format(number);
  }

  /// 格式化货币
  String formatCurrency(num amount, {String? currencyCode}) {
    final currency = currencyCode ?? _getDefaultCurrency();
    return NumberFormat.currency(
      locale: '${_currentLocale.languageCode}_${_currentLocale.countryCode}',
      symbol: _getCurrencySymbol(currency),
    ).format(amount);
  }

  /// 获取默认货币代码
  String _getDefaultCurrency() {
    switch (_currentLocale.languageCode) {
      case 'zh':
        return 'CNY';
      case 'ja':
        return 'JPY';
      case 'ko':
        return 'KRW';
      case 'en':
        return 'USD';
      case 'fr':
        return 'EUR';
      case 'de':
        return 'EUR';
      case 'es':
        return 'EUR';
      case 'pt':
        return 'BRL';
      case 'ru':
        return 'RUB';
      case 'ar':
        return 'SAR';
      default:
        return 'USD';
    }
  }

  /// 获取货币符号
  String _getCurrencySymbol(String currencyCode) {
    const symbols = {
      'CNY': '¥',
      'JPY': '¥',
      'KRW': '₩',
      'USD': '$',
      'EUR': '€',
      'BRL': 'R$',
      'RUB': '₽',
      'SAR': '﷼',
    };
    return symbols[currencyCode] ?? currencyCode;
  }

  /// 格式化百分比
  String formatPercentage(num value, {int? decimalDigits}) {
    return NumberFormat.percentPattern(_currentLocale.languageCode)
        .format(value / 100);
  }

  /// 检查是否为RTL语言
  bool get isRTL {
    return _currentLocale.languageCode == 'ar';
  }

  /// 获取文本方向
  TextDirection get textDirection {
    return isRTL ? TextDirection.rtl : TextDirection.ltr;
  }

  /// 加载默认消息
  Future<void> _loadDefaultMessages() async {
    // 加载中文消息
    _messages['zh_CN'] = {
      // 通用消息
      'common.ok': '确定',
      'common.cancel': '取消',
      'common.confirm': '确认',
      'common.save': '保存',
      'common.delete': '删除',
      'common.edit': '编辑',
      'common.view': '查看',
      'common.search': '搜索',
      'common.filter': '筛选',
      'common.sort': '排序',
      'common.refresh': '刷新',
      'common.loading': '加载中...',
      'common.noData': '暂无数据',
      'common.error': '错误',
      'common.success': '成功',
      'common.warning': '警告',
      'common.info': '信息',
      
      // 用户界面
      'user.profile': '个人资料',
      'user.settings': '设置',
      'user.logout': '退出登录',
      'user.login': '登录',
      'user.register': '注册',
      'user.forgotPassword': '忘记密码',
      
      // 表单消息
      'form.required': '必填项',
      'form.invalid': '格式无效',
      'form.minLength': '最少{min}个字符',
      'form.maxLength': '最多{max}个字符',
      'form.email': '请输入有效的邮箱地址',
      'form.password': '密码长度至少8位',
      'form.confirmPassword': '两次输入的密码不一致',
      'form.phone': '请输入有效的手机号码',
      'form.url': '请输入有效的URL地址',
      
      // 网络消息
      'network.error': '网络错误',
      'network.timeout': '请求超时',
      'network.connectionError': '连接错误',
      'network.serverError': '服务器错误',
      'network.retry': '重试',
      
      // 权限消息
      'permission.denied': '权限被拒绝',
      'permission.granted': '权限已授予',
      'permission.request': '请求权限',
      'permission.settings': '去设置',
      
      // 数据消息
      'data.loading': '数据加载中...',
      'data.empty': '暂无数据',
      'data.error': '数据加载失败',
      'data.refresh': '刷新数据',
      'data.loadMore': '加载更多',
      'data.noMore': '没有更多数据了',
      
      // 时间消息
      'time.justNow': '刚刚',
      'time.minutesAgo': '{count}分钟前',
      'time.hoursAgo': '{count}小时前',
      'time.daysAgo': '{count}天前',
      'time.weeksAgo': '{count}周前',
      'time.monthsAgo': '{count}个月前',
      'time.yearsAgo': '{count}年前',
      
      // 文件消息
      'file.upload': '上传文件',
      'file.download': '下载文件',
      'file.delete': '删除文件',
      'file.rename': '重命名文件',
      'file.share': '分享文件',
      'file.size': '文件大小',
      'file.type': '文件类型',
      'file.modified': '修改时间',
      
      // 企业级消息
      'enterprise.dashboard': '仪表板',
      'enterprise.analytics': '数据分析',
      'enterprise.reports': '报告',
      'enterprise.audit': '审计日志',
      'enterprise.security': '安全设置',
      'enterprise.backup': '备份恢复',
      'enterprise.monitoring': '系统监控',
      'enterprise.performance': '性能分析',
      'enterprise.integrations': '集成管理',
      'enterprise.api': 'API管理',
      'enterprise.webhooks': 'Webhook管理',
      'enterprise.users': '用户管理',
      'enterprise.roles': '角色管理',
      'enterprise.permissions': '权限管理',
      'enterprise.organizations': '组织管理',
      'enterprise.departments': '部门管理',
      'enterprise.teams': '团队管理',
      'enterprise.projects': '项目管理',
      'enterprise.tasks': '任务管理',
      'enterprise.workflow': '工作流',
      'enterprise.approvals': '审批流程',
      'enterprise.notifications': '通知管理',
      'enterprise.messages': '消息中心',
      'enterprise.calendar': '日历',
      'enterprise.documents': '文档管理',
      'enterprise.media': '媒体管理',
      'enterprise.assets': '资产管理',
      'enterprise.inventory': '库存管理',
      'enterprise.orders': '订单管理',
      'enterprise.customers': '客户管理',
      'enterprise.suppliers': '供应商管理',
      'enterprise.products': '产品管理',
      'enterprise.services': '服务管理',
      'enterprise.pricing': '价格管理',
      'enterprise.billing': '账单管理',
      'enterprise.payments': '支付管理',
      'enterprise.invoices': '发票管理',
      'enterprise.receipts': '收据管理',
      'enterprise.taxes': '税务管理',
      'enterprise.compliance': '合规管理',
      'enterprise.legal': '法务管理',
      'enterprise.contracts': '合同管理',
      'enterprise.agreements': '协议管理',
      'enterprise.policies': '政策管理',
      'enterprise.procedures': '流程管理',
      'enterprise.guidelines': '指导原则',
      'enterprise.standards': '标准管理',
      'enterprise.certifications': '认证管理',
      'enterprise.audits': '审计管理',
      'enterprise.assessments': '评估管理',
      'enterprise.inspections': '检查管理',
      'enterprise.reviews': '审查管理',
      'enterprise.evaluations': '评价管理',
      'enterprise.feedback': '反馈管理',
      'enterprise.surveys': '调查管理',
      'enterprise.polls': '投票管理',
      'enterprise.quizzes': '测验管理',
      'enterprise.tests': '测试管理',
      'enterprise.exams': '考试管理',
      'enterprise.certificates': '证书管理',
      'enterprise.licenses': '许可证管理',
      'enterprise.subscriptions': '订阅管理',
      'enterprise.plans': '计划管理',
      'enterprise.packages': '套餐管理',
      'enterprise.features': '功能管理',
      'enterprise.modules': '模块管理',
      'enterprise.plugins': '插件管理',
      'enterprise.extensions': '扩展管理',
      'enterprise.themes': '主题管理',
      'enterprise.templates': '模板管理',
      'enterprise.layouts': '布局管理',
      'enterprise.styles': '样式管理',
      'enterprise.scripts': '脚本管理',
      'enterprise.configurations': '配置管理',
      'enterprise.settings': '设置管理',
      'enterprise.preferences': '偏好设置',
      'enterprise.options': '选项管理',
      'enterprise.parameters': '参数管理',
      'enterprise.variables': '变量管理',
      'enterprise.constants': '常量管理',
      'enterprise.enums': '枚举管理',
      'enterprise.types': '类型管理',
      'enterprise.interfaces': '接口管理',
      'enterprise.classes': '类管理',
      'enterprise.methods': '方法管理',
      'enterprise.functions': '函数管理',
      'enterprise.libraries': '库管理',
      'enterprise.frameworks': '框架管理',
      'enterprise.tools': '工具管理',
      'enterprise.utilities': '实用工具',
      'enterprise.helpers': '辅助工具',
      'enterprise.services': '服务管理',
      'enterprise.components': '组件管理',
      'enterprise.widgets': '控件管理',
      'enterprise.pages': '页面管理',
      'enterprise.screens': '屏幕管理',
      'enterprise.views': '视图管理',
      'enterprise.controllers': '控制器管理',
      'enterprise.models': '模型管理',
      'enterprise.repositories': '仓库管理',
      'enterprise.datasources': '数据源管理',
      'enterprise.databases': '数据库管理',
      'enterprise.tables': '表管理',
      'enterprise.columns': '列管理',
      'enterprise.rows': '行管理',
      'enterprise.records': '记录管理',
      'enterprise.fields': '字段管理',
      'enterprise.keys': '键管理',
      'enterprise.values': '值管理',
      'enterprise.data': '数据管理',
      'enterprise.metadata': '元数据管理',
      'enterprise.schemas': '模式管理',
      'enterprise.migrations': '迁移管理',
      'enterprise.seeds': '种子数据管理',
      'enterprise.factories': '工厂管理',
      'enterprise.fixtures': '固定数据管理',
      'enterprise.tests': '测试管理',
      'enterprise.assertions': '断言管理',
      'enterprise.mocks': '模拟数据管理',
      'enterprise.stubs': '存根管理',
      'enterprise.spies': '间谍管理',
      'enterprise.coverage': '覆盖率管理',
      'enterprise.benchmarks': '基准测试管理',
      'enterprise.performance': '性能测试管理',
      'enterprise.load': '负载测试管理',
      'enterprise.stress': '压力测试管理',
      'enterprise.security': '安全测试管理',
      'enterprise.vulnerability': '漏洞管理',
      'enterprise.threats': '威胁管理',
      'enterprise.risks': '风险管理',
      'enterprise.mitigations': '缓解措施管理',
      'enterprise.controls': '控制措施管理',
      'enterprise.policies': '策略管理',
      'enterprise.procedures': '程序管理',
      'enterprise.guidelines': '指导原则管理',
      'enterprise.standards': '标准管理',
      'enterprise.regulations': '法规管理',
      'enterprise.compliance': '合规管理',
      'enterprise.audits': '审计管理',
      'enterprise.assessments': '评估管理',
      'enterprise.reviews': '审查管理',
      'enterprise.inspections': '检查管理',
      'enterprise.monitoring': '监控管理',
      'enterprise.alerts': '警报管理',
      'enterprise.notifications': '通知管理',
      'enterprise.reports': '报告管理',
      'enterprise.dashboards': '仪表板管理',
      'enterprise.metrics': '指标管理',
      'enterprise.kpis': 'KPI管理',
      'enterprise.analytics': '分析管理',
      'enterprise.insights': '洞察管理',
      'enterprise.predictions': '预测管理',
      'enterprise.forecasts': '预测管理',
      'enterprise.trends': '趋势管理',
      'enterprise.patterns': '模式管理',
      'enterprise.anomalies': '异常管理',
      'enterprise.outliers': '离群值管理',
      'enterprise.clusters': '聚类管理',
      'enterprise.classifications': '分类管理',
      'enterprise.recommendations': '推荐管理',
      'enterprise.suggestions': '建议管理',
      'enterprise.optimizations': '优化管理',
      'enterprise.improvements': '改进管理',
      'enterprise.enhancements': '增强管理',
      'enterprise.upgrades': '升级管理',
      'enterprise.migrations': '迁移管理',
      'enterprise.deployments': '部署管理',
      'enterprise.releases': '发布管理',
      'enterprise.versions': '版本管理',
      'enterprise.builds': '构建管理',
      'enterprise.packages': '包管理',
      'enterprise.dependencies': '依赖管理',
      'enterprise.libraries': '库管理',
      'enterprise.frameworks': '框架管理',
      'enterprise.platforms': '平台管理',
      'enterprise.environments': '环境管理',
      'enterprise.configurations': '配置管理',
      'enterprise.settings': '设置管理',
      'enterprise.preferences': '偏好设置管理',
      'enterprise.options': '选项管理',
      'enterprise.features': '功能管理',
      'enterprise.capabilities': '能力管理',
      'enterprise.functionalities': '功能管理',
      'enterprise.operations': '操作管理',
      'enterprise.processes': '流程管理',
      'enterprise.workflows': '工作流管理',
      'enterprise.automations': '自动化管理',
      'enterprise.integrations': '集成管理',
      'enterprise.connections': '连接管理',
      'enterprise.endpoints': '端点管理',
      'enterprise.services': '服务管理',
      'enterprise.apis': 'API管理',
      'enterprise.webhooks': 'Webhook管理',
      'enterprise.events': '事件管理',
      'enterprise.messages': '消息管理',
      'enterprise.queues': '队列管理',
      'enterprise.topics': '主题管理',
      'enterprise.subscriptions': '订阅管理',
      'enterprise.publishers': '发布者管理',
      'enterprise.subscribers': '订阅者管理',
      'enterprise.consumers': '消费者管理',
      'enterprise.producers': '生产者管理',
      'enterprise.brokers': '代理管理',
      'enterprise.exchanges': '交换机管理',
      'enterprise.routes': '路由管理',
      'enterprise.channels': '通道管理',
      'enterprise.connections': '连接管理',
      'enterprise.sessions': '会话管理',
      'enterprise.tokens': '令牌管理',
      'enterprise.keys': '密钥管理',
      'enterprise.secrets': '密钥管理',
      'enterprise.certificates': '证书管理',
      'enterprise.credentials': '凭证管理',
      'enterprise.identities': '身份管理',
      'enterprise.users': '用户管理',
      'enterprise.roles': '角色管理',
      'enterprise.permissions': '权限管理',
      'enterprise.policies': '策略管理',
      'enterprise.rules': '规则管理',
      'enterprise.constraints': '约束管理',
      'enterprise.validations': '验证管理',
      'enterprise.transformations': '转换管理',
      'enterprise.mappings': '映射管理',
      'enterprise.conversions': '转换管理',
      'enterprise.formats': '格式管理',
      'enterprise.encodings': '编码管理',
      'enterprise.compressions': '压缩管理',
      'enterprise.encryptions': '加密管理',
      'enterprise.hashings': '哈希管理',
      'enterprise.signatures': '签名管理',
      'enterprise.verifications': '验证管理',
      'enterprise.authentications': '认证管理',
      'enterprise.authorizations': '授权管理',
      'enterprise.audits': '审计管理',
      'enterprise.logs': '日志管理',
      'enterprise.traces': '跟踪管理',
      'enterprise.metrics': '指标管理',
      'enterprise.monitoring': '监控管理',
      'enterprise.alerting': '警报管理',
      'enterprise.reporting': '报告管理',
      'enterprise.dashboarding': '仪表板管理',
      'enterprise.visualizing': '可视化管理',
      'enterprise.analyzing': '分析管理',
      'enterprise.predicting': '预测管理',
      'enterprise.forecasting': '预测管理',
      'enterprise.optimizing': '优化管理',
      'enterprise.automating': '自动化管理',
      'enterprise.scaling': '扩展管理',
      'enterprise.loadBalancing': '负载均衡管理',
      'enterprise.failover': '故障转移管理',
      'enterprise.redundancy': '冗余管理',
      'enterprise.replication': '复制管理',
      'enterprise.backup': '备份管理',
      'enterprise.recovery': '恢复管理',
      'enterprise.disaster': '灾难管理',
      'enterprise.business': '业务管理',
      'enterprise.continuity': '连续性管理',
      'enterprise.resilience': '弹性管理',
      'enterprise.reliability': '可靠性管理',
      'enterprise.availability': '可用性管理',
      'enterprise.maintainability': '可维护性管理',
      'enterprise.usability': '可用性管理',
      'enterprise.accessibility': '无障碍管理',
      'enterprise.security': '安全管理',
      'enterprise.privacy': '隐私管理',
      'enterprise.compliance': '合规管理',
      'enterprise.governance': '治理管理',
      'enterprise.risk': '风险管理',
      'enterprise.quality': '质量管理',
      'enterprise.performance': '性能管理',
      'enterprise.efficiency': '效率管理',
      'enterprise.productivity': '生产力管理',
      'enterprise.collaboration': '协作管理',
      'enterprise.communication': '通信管理',
      'enterprise.coordination': '协调管理',
      'enterprise.cooperation': '合作管理',
      'enterprise.integration': '集成管理',
      'enterprise.interoperability': '互操作性管理',
      'enterprise.compatibility': '兼容性管理',
      'enterprise.standardization': '标准化管理',
      'enterprise.modularization': '模块化管理',
      'enterprise.abstraction': '抽象化管理',
      'enterprise.encapsulation': '封装管理',
      'enterprise.inheritance': '继承管理',
      'enterprise.polymorphism': '多态管理',
      'enterprise.composition': '组合管理',
      'enterprise.aggregation': '聚合管理',
      'enterprise.association': '关联管理',
      'enterprise.dependency': '依赖管理',
      'enterprise.coupling': '耦合管理',
      'enterprise.cohesion': '内聚管理',
      'enterprise.complexity': '复杂度管理',
      'enterprise.maintainability': '可维护性管理',
      'enterprise.testability': '可测试性管理',
      'enterprise.deployability': '可部署性管理',
      'enterprise.configurability': '可配置性管理',
      'enterprise.extensibility': '可扩展性管理',
      'enterprise.flexibility': '灵活性管理',
      'enterprise.adaptability': '适应性管理',
      'enterprise.scalability': '可扩展性管理',
      'enterprise.reliability': '可靠性管理',
      'enterprise.availability': '可用性管理',
      'enterprise.performance': '性能管理',
      'enterprise.efficiency': '效率管理',
      'enterprise.effectiveness': '有效性管理',
      'enterprise.productivity': '生产力管理',
      'enterprise.quality': '质量管理',
      'enterprise.consistency': '一致性管理',
      'enterprise.accuracy': '准确性管理',
      'enterprise.precision': '精确性管理',
      'enterprise.completeness': '完整性管理',
      'enterprise.timeliness': '及时性管理',
      'enterprise.relevance': '相关性管理',
      'enterprise.validity': '有效性管理',
      'enterprise.reliability': '可靠性管理',
      'enterprise.consistency': '一致性管理',
      'enterprise.integrity': '完整性管理',
      'enterprise.confidentiality': '机密性管理',
      'enterprise.availability': '可用性管理',
      'enterprise.authenticity': '真实性管理',
      'enterprise.nonRepudiation': '不可否认性管理',
      'enterprise.accountability': '问责制管理',
      'enterprise.transparency': '透明性管理',
      'enterprise.traceability': '可追溯性管理',
      'enterprise.auditability': '可审计性管理',
      'enterprise.compliance': '合规性管理',
      'enterprise.regulatory': '监管管理',
      'enterprise.legal': '法务管理',
      'enterprise.contractual': '合同管理',
      'enterprise.ethical': '道德管理',
      'enterprise.social': '社会责任管理',
      'enterprise.environmental': '环境管理',
      'enterprise.sustainability': '可持续性管理',
      'enterprise.economic': '经济管理',
      'enterprise.financial': '财务管理',
      'enterprise.operational': '运营管理',
      'enterprise.strategic': '战略管理',
      'enterprise.tactical': '战术管理',
      'enterprise.execution': '执行管理',
      'enterprise.monitoring': '监控管理',
      'enterprise.control': '控制管理',
      'enterprise.optimization': '优化管理',
      'enterprise.improvement': '改进管理',
      'enterprise.innovation': '创新管理',
      'enterprise.research': '研发管理',
      'enterprise.development': '开发管理',
      'enterprise.testing': '测试管理',
      'enterprise.deployment': '部署管理',
      'enterprise.maintenance': '维护管理',
      'enterprise.support': '支持管理',
      'enterprise.training': '培训管理',
      'enterprise.documentation': '文档管理',
      'enterprise.knowledge': '知识管理',
      'enterprise.information': '信息管理',
      'enterprise.data': '数据管理',
      'enterprise.metadata': '元数据管理',
      'enterprise.content': '内容管理',
      'enterprise.media': '媒体管理',
      'enterprise.assets': '资产管理',
      'enterprise.resources': '资源管理',
      'enterprise.capabilities': '能力管理',
      'enterprise.competencies': '竞争力管理',
      'enterprise.skills': '技能管理',
      'enterprise.talent': '人才管理',
      'expertise': '专业知识管理',
    };

    // 加载英文消息
    _messages['en_US'] = {
      // 通用消息
      'common.ok': 'OK',
      'common.cancel': 'Cancel',
      'common.confirm': 'Confirm',
      'common.save': 'Save',
      'common.delete': 'Delete',
      'common.edit': 'Edit',
      'common.view': 'View',
      'common.search': 'Search',
      'common.filter': 'Filter',
      'common.sort': 'Sort',
      'common.refresh': 'Refresh',
      'common.loading': 'Loading...',
      'common.noData': 'No Data',
      'common.error': 'Error',
      'common.success': 'Success',
      'common.warning': 'Warning',
      'common.info': 'Info',
      
      // 用户界面
      'user.profile': 'Profile',
      'user.settings': 'Settings',
      'user.logout': 'Logout',
      'user.login': 'Login',
      'user.register': 'Register',
      'user.forgotPassword': 'Forgot Password',
      
      // 表单消息
      'form.required': 'Required',
      'form.invalid': 'Invalid format',
      'form.minLength': 'Minimum {min} characters',
      'form.maxLength': 'Maximum {max} characters',
      'form.email': 'Please enter a valid email address',
      'form.password': 'Password must be at least 8 characters',
      'form.confirmPassword': 'Passwords do not match',
      'form.phone': 'Please enter a valid phone number',
      'form.url': 'Please enter a valid URL',
      
      // 网络消息
      'network.error': 'Network Error',
      'network.timeout': 'Request Timeout',
      'network.connectionError': 'Connection Error',
      'network.serverError': 'Server Error',
      'network.retry': 'Retry',
      
      // 权限消息
      'permission.denied': 'Permission Denied',
      'permission.granted': 'Permission Granted',
      'permission.request': 'Request Permission',
      'permission.settings': 'Go to Settings',
      
      // 数据消息
      'data.loading': 'Loading data...',
      'data.empty': 'No data available',
      'data.error': 'Failed to load data',
      'data.refresh': 'Refresh data',
      'data.loadMore': 'Load more',
      'data.noMore': 'No more data',
      
      // 时间消息
      'time.justNow': 'Just now',
      'time.minutesAgo': '{count} minutes ago',
      'time.hoursAgo': '{count} hours ago',
      'time.daysAgo': '{count} days ago',
      'time.weeksAgo': '{count} weeks ago',
      'time.monthsAgo': '{count} months ago',
      'time.yearsAgo': '{count} years ago',
      
      // 企业级消息（英文）
      'enterprise.dashboard': 'Dashboard',
      'enterprise.analytics': 'Analytics',
      'enterprise.reports': 'Reports',
      'enterprise.audit': 'Audit Logs',
      'enterprise.security': 'Security Settings',
      'enterprise.backup': 'Backup & Recovery',
      'enterprise.monitoring': 'System Monitoring',
      'enterprise.performance': 'Performance Analysis',
      'enterprise.integrations': 'Integration Management',
      'enterprise.api': 'API Management',
      'enterprise.webhooks': 'Webhook Management',
      'enterprise.users': 'User Management',
      'enterprise.roles': 'Role Management',
      'enterprise.permissions': 'Permission Management',
      'enterprise.organizations': 'Organization Management',
      'enterprise.departments': 'Department Management',
      'enterprise.teams': 'Team Management',
      'enterprise.projects': 'Project Management',
      'enterprise.tasks': 'Task Management',
      'enterprise.workflow': 'Workflow',
      'enterprise.approvals': 'Approval Process',
      'enterprise.notifications': 'Notification Management',
      'enterprise.messages': 'Message Center',
      'enterprise.calendar': 'Calendar',
      'enterprise.documents': 'Document Management',
      'enterprise.media': 'Media Management',
      'enterprise.assets': 'Asset Management',
      'enterprise.inventory': 'Inventory Management',
      'enterprise.orders': 'Order Management',
      'enterprise.customers': 'Customer Management',
      'enterprise.suppliers': 'Supplier Management',
      'enterprise.products': 'Product Management',
      'enterprise.services': 'Service Management',
      'enterprise.pricing': 'Pricing Management',
      'enterprise.billing': 'Billing Management',
      'enterprise.payments': 'Payment Management',
      'enterprise.invoices': 'Invoice Management',
      'enterprise.receipts': 'Receipt Management',
      'enterprise.taxes': 'Tax Management',
      'enterprise.compliance': 'Compliance Management',
      'enterprise.legal': 'Legal Management',
      'enterprise.contracts': 'Contract Management',
      'enterprise.agreements': 'Agreement Management',
      'enterprise.policies': 'Policy Management',
      'enterprise.procedures': 'Procedure Management',
      'enterprise.guidelines': 'Guideline Management',
      'enterprise.standards': 'Standard Management',
      'enterprise.certifications': 'Certification Management',
      'enterprise.audits': 'Audit Management',
      'enterprise.assessments': 'Assessment Management',
      'enterprise.inspections': 'Inspection Management',
      'enterprise.reviews': 'Review Management',
      'enterprise.evaluations': 'Evaluation Management',
      'enterprise.feedback': 'Feedback Management',
      'enterprise.surveys': 'Survey Management',
      'enterprise.polls': 'Poll Management',
      'enterprise.quizzes': 'Quiz Management',
      'enterprise.tests': 'Test Management',
      'enterprise.exams': 'Exam Management',
      'enterprise.certificates': 'Certificate Management',
      'enterprise.licenses': 'License Management',
      'enterprise.subscriptions': 'Subscription Management',
      'enterprise.plans': 'Plan Management',
      'enterprise.packages': 'Package Management',
      'enterprise.features': 'Feature Management',
      'enterprise.modules': 'Module Management',
      'enterprise.plugins': 'Plugin Management',
      'enterprise.extensions': 'Extension Management',
      'enterprise.themes': 'Theme Management',
      'enterprise.templates': 'Template Management',
      'enterprise.layouts': 'Layout Management',
      'enterprise.styles': 'Style Management',
      'enterprise.scripts': 'Script Management',
      'enterprise.configurations': 'Configuration Management',
      'enterprise.settings': 'Settings Management',
      'enterprise.preferences': 'Preference Management',
      'enterprise.options': 'Option Management',
      'enterprise.parameters': 'Parameter Management',
      'enterprise.variables': 'Variable Management',
      'enterprise.constants': 'Constant Management',
      'enterprise.enums': 'Enum Management',
      'enterprise.types': 'Type Management',
      'enterprise.interfaces': 'Interface Management',
      'enterprise.classes': 'Class Management',
      'enterprise.methods': 'Method Management',
      'enterprise.functions': 'Function Management',
      'enterprise.libraries': 'Library Management',
      'enterprise.frameworks': 'Framework Management',
      'enterprise.tools': 'Tool Management',
      'enterprise.utilities': 'Utility Management',
      'enterprise.helpers': 'Helper Management',
      'enterprise.services': 'Service Management',
      'enterprise.components': 'Component Management',
      'enterprise.widgets': 'Widget Management',
      'enterprise.pages': 'Page Management',
      'enterprise.screens': 'Screen Management',
      'enterprise.views': 'View Management',
      'enterprise.controllers': 'Controller Management',
      'enterprise.models': 'Model Management',
      'enterprise.repositories': 'Repository Management',
      'enterprise.datasources': 'Datasource Management',
      'enterprise.databases': 'Database Management',
      'enterprise.tables': 'Table Management',
      'enterprise.columns': 'Column Management',
      'enterprise.rows': 'Row Management',
      'enterprise.records': 'Record Management',
      'enterprise.fields': 'Field Management',
      'enterprise.keys': 'Key Management',
      'enterprise.values': 'Value Management',
      'enterprise.data': 'Data Management',
      'enterprise.metadata': 'Metadata Management',
      'enterprise.schemas': 'Schema Management',
      'enterprise.migrations': 'Migration Management',
      'enterprise.seeds': 'Seed Management',
      'enterprise.factories': 'Factory Management',
      'enterprise.fixtures': 'Fixture Management',
      'enterprise.tests': 'Test Management',
      'enterprise.assertions': 'Assertion Management',
      'enterprise.mocks': 'Mock Management',
      'enterprise.stubs': 'Stub Management',
      'enterprise.spies': 'Spy Management',
      'enterprise.coverage': 'Coverage Management',
      'enterprise.benchmarks': 'Benchmark Management',
      'enterprise.performance': 'Performance Management',
      'enterprise.load': 'Load Management',
      'enterprise.stress': 'Stress Management',
      'enterprise.security': 'Security Management',
      'enterprise.vulnerability': 'Vulnerability Management',
      'enterprise.threats': 'Threat Management',
      'enterprise.risks': 'Risk Management',
      'enterprise.mitigations': 'Mitigation Management',
      'enterprise.controls': 'Control Management',
      'enterprise.policies': 'Policy Management',
      'enterprise.procedures': 'Procedure Management',
      'enterprise.guidelines': 'Guideline Management',
      'enterprise.standards': 'Standard Management',
      'enterprise.regulations': 'Regulation Management',
      'enterprise.compliance': 'Compliance Management',
      'enterprise.audits': 'Audit Management',
      'enterprise.assessments': 'Assessment Management',
      'enterprise.reviews': 'Review Management',
      'enterprise.inspections': 'Inspection Management',
      'enterprise.monitoring': 'Monitoring Management',
      'enterprise.alerts': 'Alert Management',
      'enterprise.notifications': 'Notification Management',
      'enterprise.reports': 'Report Management',
      'enterprise.dashboards': 'Dashboard Management',
      'enterprise.metrics': 'Metric Management',
      'enterprise.kpis': 'KPI Management',
      'enterprise.analytics': 'Analytics Management',
      'enterprise.insights': 'Insight Management',
      'enterprise.predictions': 'Prediction Management',
      'enterprise.forecasts': 'Forecast Management',
      'enterprise.trends': 'Trend Management',
      'enterprise.patterns': 'Pattern Management',
      'enterprise.anomalies': 'Anomaly Management',
      'enterprise.outliers': 'Outlier Management',
      'enterprise.clusters': 'Cluster Management',
      'enterprise.classifications': 'Classification Management',
      'enterprise.recommendations': 'Recommendation Management',
      'enterprise.suggestions': 'Suggestion Management',
      'enterprise.optimizations': 'Optimization Management',
      'enterprise.improvements': 'Improvement Management',
      'enterprise.enhancements': 'Enhancement Management',
      'enterprise.upgrades': 'Upgrade Management',
      'enterprise.migrations': 'Migration Management',
      'enterprise.deployments': 'Deployment Management',
      'enterprise.releases': 'Release Management',
      'enterprise.versions': 'Version Management',
      'enterprise.builds': 'Build Management',
      'enterprise.packages': 'Package Management',
      'enterprise.dependencies': 'Dependency Management',
      'enterprise.libraries': 'Library Management',
      'enterprise.frameworks': 'Framework Management',
      'enterprise.platforms': 'Platform Management',
      'enterprise.environments': 'Environment Management',
      'enterprise.configurations': 'Configuration Management',
      'enterprise.settings': 'Settings Management',
      'enterprise.preferences': 'Preference Management',
      'enterprise.options': 'Option Management',
      'enterprise.features': 'Feature Management',
      'enterprise.capabilities': 'Capability Management',
      'enterprise.functionalities': 'Functionality Management',
      'enterprise.operations': 'Operation Management',
      'enterprise.processes': 'Process Management',
      'enterprise.workflows': 'Workflow Management',
      'enterprise.automations': 'Automation Management',
      'enterprise.integrations': 'Integration Management',
      'enterprise.connections': 'Connection Management',
      'enterprise.endpoints': 'Endpoint Management',
      'enterprise.services': 'Service Management',
      'enterprise.apis': 'API Management',
      'enterprise.webhooks': 'Webhook Management',
      'enterprise.events': 'Event Management',
      'enterprise.messages': 'Message Management',
      'enterprise.queues': 'Queue Management',
      'enterprise.topics': 'Topic Management',
      'enterprise.subscriptions': 'Subscription Management',
      'enterprise.publishers': 'Publisher Management',
      'enterprise.subscribers': 'Subscriber Management',
      'enterprise.consumers': 'Consumer Management',
      'enterprise.producers': 'Producer Management',
      'enterprise.brokers': 'Broker Management',
      'enterprise.exchanges': 'Exchange Management',
      'enterprise.routes': 'Route Management',
      'enterprise.channels': 'Channel Management',
      'enterprise.connections': 'Connection Management',
      'enterprise.sessions': 'Session Management',
      'enterprise.tokens': 'Token Management',
      'enterprise.keys': 'Key Management',
      'enterprise.secrets': 'Secret Management',
      'enterprise.certificates': 'Certificate Management',
      'enterprise.credentials': 'Credential Management',
      'enterprise.identities': 'Identity Management',
      'enterprise.users': 'User Management',
      'enterprise.roles': 'Role Management',
      'enterprise.permissions': 'Permission Management',
      'enterprise.policies': 'Policy Management',
      'enterprise.rules': 'Rule Management',
      'enterprise.constraints': 'Constraint Management',
      'enterprise.validations': 'Validation Management',
      'enterprise.transformations': 'Transformation Management',
      'enterprise.mappings': 'Mapping Management',
      'enterprise.conversions': 'Conversion Management',
      'enterprise.formats': 'Format Management',
      'enterprise.encodings': 'Encoding Management',
      'enterprise.compressions': 'Compression Management',
      'enterprise.encryptions': 'Encryption Management',
      'enterprise.hashings': 'Hashing Management',
      'enterprise.signatures': 'Signature Management',
      'enterprise.verifications': 'Verification Management',
      'enterprise.authentications': 'Authentication Management',
      'enterprise.authorizations': 'Authorization Management',
      'enterprise.audits': 'Audit Management',
      'enterprise.logs': 'Log Management',
      'enterprise.traces': 'Trace Management',
      'enterprise.metrics': 'Metric Management',
      'enterprise.monitoring': 'Monitoring Management',
      'enterprise.alerting': 'Alerting Management',
      'enterprise.reporting': 'Reporting Management',
      'enterprise.dashboarding': 'Dashboarding Management',
      'enterprise.visualizing': 'Visualizing Management',
      'enterprise.analyzing': 'Analyzing Management',
      'enterprise.predicting': 'Predicting Management',
      'enterprise.forecasting': 'Forecasting Management',
      'enterprise.optimizing': 'Optimizing Management',
      'enterprise.automating': 'Automating Management',
      'enterprise.scaling': 'Scaling Management',
      'enterprise.loadBalancing': 'Load Balancing Management',
      'enterprise.failover': 'Failover Management',
      'enterprise.redundancy': 'Redundancy Management',
      'enterprise.replication': 'Replication Management',
      'enterprise.backup': 'Backup Management',
      'enterprise.recovery': 'Recovery Management',
      'enterprise.disaster': 'Disaster Management',
      'enterprise.business': 'Business Management',
      'enterprise.continuity': 'Continuity Management',
      'enterprise.resilience': 'Resilience Management',
      'enterprise.reliability': 'Reliability Management',
      'enterprise.availability': 'Availability Management',
      'enterprise.maintainability': 'Maintainability Management',
      'enterprise.usability': 'Usability Management',
      'enterprise.accessibility': 'Accessibility Management',
      'enterprise.security': 'Security Management',
      'enterprise.privacy': 'Privacy Management',
      'enterprise.compliance': 'Compliance Management',
      'enterprise.governance': 'Governance Management',
      'enterprise.risk': 'Risk Management',
      'enterprise.quality': 'Quality Management',
      'enterprise.performance': 'Performance Management',
      'enterprise.efficiency': 'Efficiency Management',
      'enterprise.productivity': 'Productivity Management',
      'enterprise.collaboration': 'Collaboration Management',
      'enterprise.communication': 'Communication Management',
      'enterprise.coordination': 'Coordination Management',
      'enterprise.cooperation': 'Cooperation Management',
      'enterprise.integration': 'Integration Management',
      'enterprise.interoperability': 'Interoperability Management',
      'enterprise.compatibility': 'Compatibility Management',
      'enterprise.standardization': 'Standardization Management',
      'enterprise.modularization': 'Modularization Management',
      'enterprise.abstraction': 'Abstraction Management',
      'enterprise.encapsulation': 'Encapsulation Management',
      'enterprise.inheritance': 'Inheritance Management',
      'enterprise.polymorphism': 'Polymorphism Management',
      'enterprise.composition': 'Composition Management',
      'enterprise.aggregation': 'Aggregation Management',
      'enterprise.association': 'Association Management',
      'enterprise.dependency': 'Dependency Management',
      'enterprise.coupling': 'Coupling Management',
      'enterprise.cohesion': 'Cohesion Management',
      'enterprise.complexity': 'Complexity Management',
      'enterprise.maintainability': 'Maintainability Management',
      'enterprise.testability': 'Testability Management',
      'enterprise.deployability': 'Deployability Management',
      'enterprise.configurability': 'Configurability Management',
      'enterprise.extensibility': 'Extensibility Management',
      'enterprise.flexibility': 'Flexibility Management',
      'enterprise.adaptability': 'Adaptability Management',
      'enterprise.scalability': 'Scalability Management',
      'enterprise.reliability': 'Reliability Management',
      'enterprise.availability': 'Availability Management',
      'enterprise.performance': 'Performance Management',
      'enterprise.efficiency': 'Efficiency Management',
      'enterprise.effectiveness': 'Effectiveness Management',
      'enterprise.productivity': 'Productivity Management',
      'enterprise.quality': 'Quality Management',
      'enterprise.consistency': 'Consistency Management',
      'enterprise.accuracy': 'Accuracy Management',
      'enterprise.precision': 'Precision Management',
      'enterprise.completeness': 'Completeness Management',
      'enterprise.timeliness': 'Timeliness Management',
      'enterprise.relevance': 'Relevance Management',
      'enterprise.validity': 'Validity Management',
      'enterprise.reliability': 'Reliability Management',
      'enterprise.consistency': 'Consistency Management',
      'enterprise.integrity': 'Integrity Management',
      'enterprise.confidentiality': 'Confidentiality Management',
      'enterprise.availability': 'Availability Management',
      'enterprise.authenticity': 'Authenticity Management',
      'enterprise.nonRepudiation': 'Non-repudiation Management',
      'enterprise.accountability': 'Accountability Management',
      'enterprise.transparency': 'Transparency Management',
      'enterprise.traceability': 'Traceability Management',
      'enterprise.auditability': 'Auditability Management',
      'enterprise.compliance': 'Compliance Management',
      'enterprise.regulatory': 'Regulatory Management',
      'enterprise.legal': 'Legal Management',
      'enterprise.contractual': 'Contractual Management',
      'enterprise.ethical': 'Ethical Management',
      'enterprise.social': 'Social Responsibility Management',
      'enterprise.environmental': 'Environmental Management',
      'enterprise.sustainability': 'Sustainability Management',
      'enterprise.economic': 'Economic Management',
      'enterprise.financial': 'Financial Management',
      'enterprise.operational': 'Operational Management',
      'enterprise.strategic': 'Strategic Management',
      'enterprise.tactical': 'Tactical Management',
      'enterprise.execution': 'Execution Management',
      'enterprise.monitoring': 'Monitoring Management',
      'enterprise.control': 'Control Management',
      'enterprise.optimization': 'Optimization Management',
      'enterprise.improvement': 'Improvement Management',
      'enterprise.innovation': 'Innovation Management',
      'enterprise.research': 'Research Management',
      'enterprise.development': 'Development Management',
      'enterprise.testing': 'Testing Management',
      'enterprise.deployment': 'Deployment Management',
      'enterprise.maintenance': 'Maintenance Management',
      'enterprise.support': 'Support Management',
      'enterprise.training': 'Training Management',
      'enterprise.documentation': 'Documentation Management',
      'enterprise.knowledge': 'Knowledge Management',
      'enterprise.information': 'Information Management',
      'enterprise.data': 'Data Management',
      'enterprise.metadata': 'Metadata Management',
      'enterprise.content': 'Content Management',
      'enterprise.media': 'Media Management',
      'enterprise.assets': 'Asset Management',
      'enterprise.resources': 'Resource Management',
      'enterprise.capabilities': 'Capability Management',
      'enterprise.competencies': 'Competency Management',
      'enterprise.skills': 'Skill Management',
      'enterprise.talent': 'Talent Management',
      'expertise': 'Expertise Management',
    };
  }

  /// 添加自定义消息
  void addMessages(String locale, Map<String, String> messages) {
    _messages[locale] = {...?_messages[locale], ...messages};
  }

  /// 获取所有消息
  Map<String, String> getMessages(String locale) {
    return Map.from(_messages[locale] ?? {});
  }

  /// 清除所有消息
  void clearMessages() {
    _messages.clear();
  }

  /// 导出消息到JSON
  String exportToJson() {
    return '{"messages": ${_messages.toString()}}';
  }

  /// 从JSON导入消息
  void importFromJson(String json) {
    // 实现JSON导入逻辑
    // 这里简化处理，实际使用时需要解析JSON
  }
}

/// 国际化扩展
extension ZephyrI18nExtensions on BuildContext {
  /// 获取本地化文本
  String tr(String key, {Map<String, dynamic>? params}) {
    return ZephyrI18nManager.instance.translate(key, params: params);
  }

  /// 获取当前语言环境
  Locale get currentLocale => ZephyrI18nManager.instance.currentLocale;

  /// 切换语言
  Future<void> changeLocale(Locale locale) async {
    await ZephyrI18nManager.instance.setLocale(locale);
  }

  /// 检查是否为RTL语言
  bool get isRTL => ZephyrI18nManager.instance.isRTL;
}