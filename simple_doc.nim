import std/[strformat, os, strutils, times]

# 简单的 HTML 文档生成器
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
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }}
        h1 {{
            color: #333;
            border-bottom: 3px solid #667eea;
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
        .footer {{
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 0.9em;
        }}
    </style>
</head>
<body>
    <div class="container">
        <h1>{title}</h1>
        <div class="content">
            {content}
        </div>
        <div class="footer">
            生成时间: {now().format("yyyy-MM-dd HH:mm:ss")} | 使用 Simple Nim Doc 生成
        </div>
    </div>
</body>
</html>
"""
  writeFile(filename, html)
  echo fmt"✅ 文档已生成: {filename}"

# 代码块生成器
proc codeBlock*(code: string): string =
  fmt"<pre class='code'><code>{code.escape}</code></pre>"

# 文本段落生成器
proc textBlock*(text: string): string =
  fmt"<p>{text}</p>"

# 标题生成器
proc heading*(level: int, text: string): string =
  fmt"<h{level}>{text}</h{level}>"

when isMainModule:
  # 示例用法
  var content = ""
  
  # 添加标题
  content &= heading(2, "欢迎使用 Simple Nim Doc")
  
  # 添加文本
  content &= textBlock("这是一个简单易用的文档生成工具，完全离线工作！")
  
  # 添加代码块
  content &= codeBlock("""
echo "Hello, World!"

proc add(a, b: int): int =
    result = a + b

let x = add(5, 3)
echo "5 + 3 = ", x
""")
  
  # 添加更多内容
  content &= heading(3, "功能特点")
  content &= textBlock("✅ 完全离线工作")
  content &= textBlock("✅ 无需网络连接")  
  content &= textBlock("✅ 简单的 API")
  content &= textBlock("✅ 美观的样式")
  
  # 生成文档
  generateDoc("我的第一个文档", content, "my_document.html")
