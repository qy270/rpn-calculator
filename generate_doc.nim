import ../simple_doc

# 开始构建文档内容
var docContent = ""

# 标题和介绍
docContent &= heading(1, "RPN 计算器使用手册")
docContent &= textBlock("这是一个基于逆波兰表示法（Reverse Polish Notation）的命令行计算器。")

# 安装和编译指南
docContent &= heading(2, "1. 安装和编译指南")
docContent &= codeBlock("""
# 编译 C++ 程序
g++ rpn_calc.cpp -o rpn_calc -std=c++11

# 运行程序
./rpn_calc
""")

# 基本使用示例
docContent &= heading(2, "2. 基本使用示例")
docContent &= codeBlock("""
C++ RPN 计算器
输入表达式（例，'5 5 +'），或 'q' 退出，'c' 清空栈，'s' 显示栈
> 5 5 +
结果: 10
> 1 2 + 3 *
结果: 9
> 10 5 - 2 /
结果: 2.5
""")

# 支持的操作说明
docContent &= heading(2, "3. 支持的操作说明")
docContent &= textBlock("✅ 四则运算: +, -, *, /")
docContent &= textBlock("✅ 栈操作命令:")
docContent &= textBlock("  - c 或 clear: 清空栈")
docContent &= textBlock("  - s 或 show: 显示当前栈")
docContent &= textBlock("  - q 或 quit: 退出程序")
docContent &= textBlock("✅ 数字支持: 整数和浮点数")

# 错误处理说明
docContent &= heading(2, "4. 错误代码和异常说明")
docContent &= textBlock("🔴 栈空错误: 当尝试从空栈弹出元素时")
docContent &= textBlock("🔴 除零错误: 当除数为零时")  
docContent &= textBlock("🔴 操作数不足: 当运算缺少足够操作数时")
docContent &= textBlock("🔴 未知操作符: 当输入无法识别的操作符时")
docContent &= textBlock("🔴 表达式不完整: 当表达式计算后栈中不止一个元素时")

# 更多示例
docContent &= heading(2, "5. 示例输入输出")
docContent &= codeBlock("""
示例 1: 基础运算
输入: 3 4 + 2 *
输出: 结果: 14

示例 2: 复杂表达式  
输入: 15 7 1 1 + - / 3 * 2 1 1 + + -
输出: 结果: 5

示例 3: 错误处理
输入: 5 0 /
输出: 错误: 除零错误

示例 4: 栈操作
输入: 1 2 3
输入: s
输出: 当前栈: 1 2 3 
输入: +
输出: 结果: 5
""")

# 技术细节
docContent &= heading(2, "6. 技术实现")
docContent &= textBlock("📋 编程语言: C++")
docContent &= textBlock("📋 核心类: RPNCalculator")
docContent &= textBlock("📋 主要方法: push(), pop(), calculate(), showStack()")
docContent &= textBlock("📋 编译要求: C++11 或更高版本")

# 生成文档
generateDoc("RPN 计算器使用手册", docContent, "rpn_manual.html")
