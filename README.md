# RPN 计算器

一个基于逆波兰表示法（Reverse Polish Notation）的命令行计算器，使用 C++ 编写。

## 🚀 功能特性

- ✅ 四则运算支持（+、-、*、/）
- ✅ 栈操作功能（清空、显示栈）
- ✅ 完整的错误处理
- ✅ 支持整数和浮点数运算

## 📦 快速开始

### 编译程序
\`\`\`bash
g++ rpn_calc.cpp -o rpn_calc -std=c++11
\`\`\`

### 运行计算器
\`\`\`bash
./rpn_calc
\`\`\`

### 使用示例
\`\`\`
C++ RPN 计算器
输入表达式（例，'5 5 +'），或 'q' 退出，'c' 清空栈，'s' 显示栈
> 5 5 +
结果: 10
> 1 2 + 3 *
结果: 9
\`\`\`

## 📚 详细文档

[查看完整使用手册](rpn_manual.html)

## 🗂️ 项目结构

\`\`\`
rpn_calculator/
├── rpn_calc.cpp     # C++ 源代码
├── rpn_calc         # 编译后的可执行文件
├── rpn_manual.html  # 详细使用手册
├── generate_doc.nim # 文档生成脚本
└── README.md        # 项目说明（本文件）
\`\`\`

## 🛠️ 技术栈

- **编程语言**: C++
- **文档工具**: Nim + simple_doc
- **版本控制**: Git

## 📄 许可证

MIT License
