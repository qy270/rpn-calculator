import std/[strformat, os, strutils, times]

# 简单的 HTML 文档生成器（复制 simple_doc 的功能）
proc generateDoc*(title, content: string, filename = "output.html") =
  let html = fmt"""
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
    <style>
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }}
        .container {{
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }}
        h1, h2, h3 {{
            color: #333;
            border-bottom: 2px solid #667eea;
            padding-bottom: 10px;
        }}
        .content {{
            margin: 20px 0;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }}
        .code {{
            background: #2d3748;
            color: #e2e8f0;
            padding: 15px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            overflow-x: auto;
            margin: 15px 0;
        }}
        .feature-list {{ background: #f0f9ff; padding: 15px; border-radius: 8px; }}
        .footer {{ text-align: center; margin-top: 30px; color: #666; }}
    </style>
</head>
<body>
    <div class="container">
        <h1>{title}</h1>
        <div class="content">
            {content}
        </div>
        <div class="footer">
            生成时间: {now().format("yyyy-MM-dd HH:mm:ss")} | Nimib 风格文档
        </div>
    </div>
</body>
</html>
"""
  writeFile(filename, html)
  echo fmt"✅ 文档已生成: {filename}"

proc codeBlock*(code: string): string =
  fmt"<pre class='code'><code>{code.escape}</code></pre>"

proc textBlock*(text: string): string =
  fmt"<p>{text}</p>"

proc heading*(level: int, text: string): string =
  fmt"<h{level}>{text}</h{level}>"

when isMainModule:
  # 开始构建 nimib 风格文档
  var docContent = ""

  # 标题和介绍
  docContent &= heading(1, "RPN 计算器使用手册 - Nimib 风格")
  docContent &= textBlock("一个基于逆波兰表示法（Reverse Polish Notation）的命令行计算器，使用 C++ 编写。")

  # 功能特性
  docContent &= heading(2, "🚀 功能特性")
  docContent &= textBlock("✅ <strong>四则运算</strong>: 加法(+), 减法(-), 乘法(*), 除法(/)")
  docContent &= textBlock("✅ <strong>栈操作</strong>: 清空栈, 显示栈状态, 连续运算")
  docContent &= textBlock("✅ <strong>错误处理</strong>: 除零错误, 栈空错误, 输入格式错误")
  docContent &= textBlock("✅ <strong>高级功能</strong>: 斐波那契数列计算")
  docContent &= textBlock("✅ <strong>数字支持</strong>: 整数和浮点数")

  # 安装指南
  docContent &= heading(2, "📦 安装和编译指南")
  docContent &= codeBlock("""
# 编译 C++ 程序
g++ rpn_calc.cpp -o rpn_calc -std=c++11

# 运行程序
./rpn_calc
""")

  # 基本使用示例
  docContent &= heading(2, "🎯 基本使用示例")
  docContent &= codeBlock("""
$ ./rpn_calc
C++ RPN 计算器
输入表达式（例，'5 5 +'），或 'q' 退出，'c' 清空栈，'s' 显示栈
> 5 5 +
结果: 10
> 1 2 + 3 *
结果: 9
> 10 5 - 2 /
结果: 2.5
""")

  # 操作符说明
  docContent &= heading(2, "🔧 操作符说明")
  docContent &= codeBlock("""
数学运算符:
+ : 加法    (a b + → a+b)
- : 减法    (a b - → a-b) 
* : 乘法    (a b * → a*b)
/ : 除法    (a b / → a/b)
fib : 斐波那契 (n fib → fib(n))

栈操作命令:
c 或 clear : 清空栈
s 或 show  : 显示当前栈内容  
q 或 quit  : 退出程序
""")

  # 错误处理
  docContent &= heading(2, "⚠️ 错误代码和异常说明")
  docContent &= codeBlock("""
错误: 栈为空          - 尝试从空栈弹出元素
错误: 除零错误        - 除数为零
错误: 需要两个操作数  - 运算符缺少足够操作数
错误: 未知操作符      - 输入无法识别的操作符
错误: 表达式不完整    - 计算后栈中不止一个元素
""")

  # 斐波那契功能
  docContent &= heading(2, "🧮 斐波那契数列功能")
  docContent &= codeBlock("""
> 5 fib
结果: 5
> 6 fib  
结果: 8
> 10 fib
结果: 55
""")

  # 项目结构
  docContent &= heading(2, "🗂️ 项目结构")
  docContent &= codeBlock("""
rpn_calculator/
├── rpn_calc.cpp      # C++ 源代码
├── rpn_calc          # 编译后的可执行文件
├── rpn_manual.html   # 详细使用手册
├── generate_doc.nim  # 文档生成脚本
└── README.md         # 项目说明
""")

  # 生成文档
  generateDoc("RPN 计算器使用手册 - Nimib 风格", docContent, "rpn_nimib_style.html")
