#!/bin/bash

echo "=== RPN计算器完整测试 ==="
echo ""

# 编译程序
echo "1. 编译程序..."
g++ -std=c++11 rpn_calc.cpp -o rpn_calc -lm
if [ $? -ne 0 ]; then
    echo "编译失败!"
    exit 1
fi
echo "✓ 编译成功"
echo ""

# 测试基本功能
echo "2. 测试基本功能..."
echo "测试用例: 5 5 +"
echo "5 5 +" | timeout 5 ./rpn_calc | grep "结果: 10" && echo "✓ 加法测试通过" || echo "✗ 加法测试失败"

echo "测试用例: 10 2 -" 
echo "10 2 -" | timeout 5 ./rpn_calc | grep "结果: 8" && echo "✓ 减法测试通过" || echo "✗ 减法测试失败"
echo ""

# 测试错误处理
echo "3. 测试错误处理..."
echo "测试用例: 5 0 /"
echo "5 0 /" | timeout 5 ./rpn_calc | grep "除零错误" && echo "✓ 除零错误处理通过" || echo "✗ 除零错误处理失败"
echo ""

# 生成文档
echo "4. 生成文档..."
nim r rpn_manual.nim 2>/dev/null
if [ -f "rpn_manual.html" ]; then
    echo "✓ 文档生成成功"
    echo "文档文件: rpn_manual.html"
else
    echo "✗ 文档生成失败（需要安装Nim和nimib）"
fi
echo ""

echo "=== 测试完成 ==="
