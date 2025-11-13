#!/bin/bash

echo "=== 编译RPN计算器 ==="
echo "编译命令: g++ -std=c++11 rpn_calc.cpp -o rpn_calc -lm"
g++ -std=c++11 rpn_calc.cpp -o rpn_calc -lm

if [ $? -eq 0 ]; then
    echo "✓ 编译成功！"
    echo ""
    echo "=== 运行RPN计算器 ==="
    echo "输入 'help' 查看使用说明"
    echo "输入 'q' 或 'quit' 退出程序"
    echo "=========================="
    ./rpn_calc
else
    echo "✗ 编译失败！请检查错误信息"
    exit 1
fi
