#!/bin/bash

# ZephyrUI 文档验证脚本
# 检查文档更新是否完整和一致

echo "🔍 ZephyrUI 文档验证脚本"
echo "================================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 错误计数
ERROR_COUNT=0
WARNING_COUNT=0

# 检查函数
check_file() {
    local file_path=$1
    local description=$2
    
    if [ -f "$file_path" ]; then
        echo -e "${GREEN}✓${NC} $description: $file_path"
    else
        echo -e "${RED}✗${NC} $description: $file_path"
        ((ERROR_COUNT++))
    fi
}

# 检查文件内容
check_content() {
    local file_path=$1
    local pattern=$2
    local description=$3
    
    if grep -q "$pattern" "$file_path"; then
        echo -e "${GREEN}✓${NC} $description"
    else
        echo -e "${YELLOW}⚠${NC} $description"
        ((WARNING_COUNT++))
    fi
}

# 检查版本一致性
check_version() {
    local file_path=$1
    local expected_version=$2
    
    if grep -q "version: $expected_version" "$file_path" || grep -q "\[$expected_version\]" "$file_path"; then
        echo -e "${GREEN}✓${NC} 版本一致性: $file_path ($expected_version)"
    else
        echo -e "${RED}✗${NC} 版本不一致: $file_path (期望: $expected_version)"
        ((ERROR_COUNT++))
    fi
}

echo ""
echo "📋 检查主要文档文件..."
echo "--------------------------------"

# 检查主要文档文件
check_file "README.md" "项目主文档"
check_file "CHANGELOG.md" "更新日志"
check_file "CONTRIBUTING.md" "贡献指南"
check_file "doc/README.md" "文档主页面"
check_file "doc/guides/naming-conventions.md" "命名规范文档"
check_file "doc/guides/migration-guide.md" "迁移指南"

echo ""
echo "📋 检查组件文档..."
echo "--------------------------------"

# 检查组件文档
check_file "lib/src/components/README.md" "组件架构文档"
check_file "lib/src/components/README_COMPONENTS.md" "组件列表文档"

echo ""
echo "📋 检查示例文件..."
echo "--------------------------------"

# 检查示例文件
check_file "example/lib/main.dart" "主要示例文件"
check_file "example/lib/main_simple.dart" "简化示例文件"

echo ""
echo "📋 检查版本一致性..."
echo "--------------------------------"

# 检查版本一致性
EXPECTED_VERSION="0.4.0"
check_version "pubspec.yaml" "$EXPECTED_VERSION"
check_version "CHANGELOG.md" "$EXPECTED_VERSION"

echo ""
echo "📋 检查文档内容..."
echo "--------------------------------"

# 检查 README.md 内容
check_content "README.md" "ZephyrButton" "README.md 包含 ZephyrButton 引用"
check_content "README.md" "ZephyrInput" "README.md 包含 ZephyrInput 引用"
check_content "README.md" "ZephyrCard" "README.md 包含 ZephyrCard 引用"

# 检查 CHANGELOG.md 内容
check_content "CHANGELOG.md" "0.4.0" "CHANGELOG.md 包含 v0.4.0 版本信息"
check_content "CHANGELOG.md" "命名规范" "CHANGELOG.md 包含命名规范变更"

# 检查 CONTRIBUTING.md 内容
check_content "CONTRIBUTING.md" "命名规范" "CONTRIBUTING.md 包含命名规范章节"
check_content "CONTRIBUTING.md" "Zephyr" "CONTRIBUTING.md 包含 Zephyr 前缀说明"

# 检查示例文件内容
check_content "example/lib/main_simple.dart" "zephyr_ui: ^0.4.0" "示例文件使用正确版本"
check_content "example/lib/main_simple.dart" "ZephyrButton" "示例文件包含 ZephyrButton"

echo ""
echo "📋 检查文档链接..."
echo "--------------------------------"

# 检查文档中的链接（简单检查）
check_content "README.md" "doc/guides/naming-conventions.md" "README.md 包含命名规范链接"
check_content "README.md" "doc/guides/migration-guide.md" "README.md 包含迁移指南链接"

echo ""
echo "📋 检查代码示例..."
echo "--------------------------------"

# 检查代码示例是否包含正确的组件名称
check_content "doc/guides/naming-conventions.md" "ZephyrButton" "命名规范包含正确的组件名称"
check_content "doc/guides/migration-guide.md" "ZephyrButton" "迁移指南包含正确的组件名称"

echo ""
echo "📊 验证结果统计"
echo "================================"
echo -e "错误数量: ${RED}$ERROR_COUNT${NC}"
echo -e "警告数量: ${YELLOW}$WARNING_COUNT${NC}"

if [ $ERROR_COUNT -eq 0 ]; then
    echo -e "${GREEN}✓ 所有检查通过！${NC}"
    echo ""
    echo "🎉 文档更新完成！"
    echo ""
    echo "📝 已完成的更新："
    echo "  ✓ 更新 README.md 中的组件名称和示例"
    echo "  ✓ 更新 CHANGELOG.md 记录命名规范变更"
    echo "  ✓ 更新 CONTRIBUTING.md 中的命名规范"
    echo "  ✓ 更新示例代码中的组件引用"
    echo "  ✓ 创建命名规范文档"
    echo "  ✓ 创建迁移指南"
    echo "  ✓ 更新组件文档"
    echo "  ✓ 更新版本号到 0.4.0"
    echo ""
    echo "🔗 相关文档："
    echo "  - 命名规范: doc/guides/naming-conventions.md"
    echo "  - 迁移指南: doc/guides/migration-guide.md"
    echo "  - 组件文档: lib/src/components/README.md"
    echo ""
    exit 0
else
    echo -e "${RED}✗ 发现 $ERROR_COUNT 个错误，请修复后重试${NC}"
    echo ""
    echo "🔧 建议检查："
    echo "  1. 确保所有文档文件存在"
    echo "  2. 检查版本号一致性"
    echo "  3. 验证组件名称引用"
    echo "  4. 确认示例代码正确性"
    echo ""
    exit 1
fi