#include <iostream>
#include <stack>
#include <string>
#include <sstream>
#include <vector>
#include <cmath>
#include <stdexcept>
#include <map>
#include <iomanip>

class RPNCalculator {
private:
    std::stack<double> stack;
    std::vector<std::string> history;
    
    // 斐波那契数列计算
    double fibonacci(int n) {
        if (n < 0) throw std::invalid_argument("斐波那契数不能为负数");
        if (n == 0) return 0;
        if (n == 1) return 1;
        
        double a = 0, b = 1;
        for (int i = 2; i <= n; i++) {
            double temp = a + b;
            a = b;
            b = temp;
        }
        return b;
    }
    
    // 杨辉三角计算
    double pascal(int row, int col) {
        if (row < 0 || col < 0 || col > row) {
            throw std::invalid_argument("杨辉三角坐标无效");
        }
        
        double result = 1;
        for (int i = 1; i <= col; i++) {
            result = result * (row - i + 1) / i;
        }
        return result;
    }

public:
    // 压入数值到栈
    void push(double value) {
        stack.push(value);
    }
    
    // 弹出栈顶元素
    double pop() {
        if (stack.empty()) {
            throw std::runtime_error("错误: 栈为空");
        }
        double value = stack.top();
        stack.pop();
        return value;
    }
    
    // 查看栈顶元素
    double peek() const {
        if (stack.empty()) {
            throw std::runtime_error("错误: 栈为空");
        }
        return stack.top();
    }
    
    // 清空栈
    void clear() {
        while (!stack.empty()) {
            stack.pop();
        }
    }
    
    // 获取栈大小
    size_t size() const {
        return stack.size();
    }
    
    // 显示当前栈内容
    void displayStack() const {
        if (stack.empty()) {
            std::cout << "栈: [空]" << std::endl;
            return;
        }
        
        std::stack<double> temp = stack;
        std::vector<double> elements;
        
        while (!temp.empty()) {
            elements.push_back(temp.top());
            temp.pop();
        }
        
        std::cout << "栈: ";
        for (auto it = elements.rbegin(); it != elements.rend(); ++it) {
            std::cout << *it << " ";
        }
        std::cout << std::endl;
    }
    
    // 执行计算
    void calculate(const std::string& operation) {
        history.push_back(operation);
        
        if (operation == "+") {
            if (stack.size() < 2) throw std::runtime_error("错误: 需要两个操作数进行加法");
            double b = pop();
            double a = pop();
            push(a + b);
        }
        else if (operation == "-") {
            if (stack.size() < 2) throw std::runtime_error("错误: 需要两个操作数进行减法");
            double b = pop();
            double a = pop();
            push(a - b);
        }
        else if (operation == "*") {
            if (stack.size() < 2) throw std::runtime_error("错误: 需要两个操作数进行乘法");
            double b = pop();
            double a = pop();
            push(a * b);
        }
        else if (operation == "/") {
            if (stack.size() < 2) throw std::runtime_error("错误: 需要两个操作数进行除法");
            double b = pop();
            double a = pop();
            if (b == 0) throw std::runtime_error("错误: 除零错误");
            push(a / b);
        }
        else if (operation == "sqrt") {
            if (stack.empty()) throw std::runtime_error("错误: 需要操作数进行平方根运算");
            double a = pop();
            if (a < 0) throw std::runtime_error("错误: 不能对负数求平方根");
            push(std::sqrt(a));
        }
        else if (operation == "pow") {
            if (stack.size() < 2) throw std::runtime_error("错误: 需要两个操作数进行幂运算");
            double exponent = pop();
            double base = pop();
            push(std::pow(base, exponent));
        }
        else if (operation == "sin") {
            if (stack.empty()) throw std::runtime_error("错误: 需要操作数进行正弦运算");
            double a = pop();
            push(std::sin(a * M_PI / 180.0)); // 转换为弧度
        }
        else if (operation == "cos") {
            if (stack.empty()) throw std::runtime_error("错误: 需要操作数进行余弦运算");
            double a = pop();
            push(std::cos(a * M_PI / 180.0));
        }
        else if (operation == "tan") {
            if (stack.empty()) throw std::runtime_error("错误: 需要操作数进行正切运算");
            double a = pop();
            double rad = a * M_PI / 180.0;
            if (std::cos(rad) == 0) throw std::runtime_error("错误: 正切值不存在");
            push(std::tan(rad));
        }
        else if (operation == "fib") {
            if (stack.empty()) throw std::runtime_error("错误: 需要操作数进行斐波那契运算");
            double n = pop();
            if (n != std::floor(n)) throw std::runtime_error("错误: 斐波那契数必须为整数");
            push(fibonacci(static_cast<int>(n)));
        }
        else if (operation == "pascal") {
            if (stack.size() < 2) throw std::runtime_error("错误: 需要两个操作数进行杨辉三角运算");
            double col = pop();
            double row = pop();
            if (row != std::floor(row) || col != std::floor(col)) {
                throw std::runtime_error("错误: 杨辉三角坐标必须为整数");
            }
            push(pascal(static_cast<int>(row), static_cast<int>(col)));
        }
        else if (operation == "dup") {
            if (stack.empty()) throw std::runtime_error("错误: 栈为空，无法复制");
            push(peek());
        }
        else if (operation == "swap") {
            if (stack.size() < 2) throw std::runtime_error("错误: 需要两个操作数进行交换");
            double b = pop();
            double a = pop();
            push(b);
            push(a);
        }
        else {
            // 尝试解析为数字
            try {
                double value = std::stod(operation);
                push(value);
            }
            catch (const std::invalid_argument&) {
                throw std::runtime_error("错误: 未知的操作符或数字: " + operation);
            }
        }
    }
    
    // 批量计算表达式
    void evaluateExpression(const std::string& expression) {
        std::istringstream iss(expression);
        std::string token;
        
        while (iss >> token) {
            calculate(token);
        }
    }
    
    // 获取计算历史
    void showHistory() const {
        if (history.empty()) {
            std::cout << "计算历史: [空]" << std::endl;
            return;
        }
        
        std::cout << "计算历史:" << std::endl;
        for (size_t i = 0; i < history.size(); i++) {
            std::cout << "  " << (i + 1) << ": " << history[i] << std::endl;
        }
    }
    
    // 获取帮助信息
    static void showHelp() {
        std::cout << "=== RPN计算器帮助 ===" << std::endl;
        std::cout << "基本操作:" << std::endl;
        std::cout << "  +, -, *, /  : 四则运算" << std::endl;
        std::cout << "  sqrt        : 平方根" << std::endl;
        std::cout << "  pow         : 幂运算" << std::endl;
        std::cout << "  sin, cos, tan: 三角函数（角度制）" << std::endl;
        std::cout << std::endl;
        std::cout << "高级操作:" << std::endl;
        std::cout << "  fib n       : 计算第n个斐波那契数" << std::endl;
        std::cout << "  pascal r c  : 计算杨辉三角第r行第c列的值" << std::endl;
        std::cout << "  dup         : 复制栈顶元素" << std::endl;
        std::cout << "  swap        : 交换栈顶两个元素" << std::endl;
        std::cout << std::endl;
        std::cout << "栈操作:" << std::endl;
        std::cout << "  stack       : 显示当前栈" << std::endl;
        std::cout << "  clear       : 清空栈" << std::endl;
        std::cout << "  history     : 显示计算历史" << std::endl;
        std::cout << "  help        : 显示此帮助" << std::endl;
        std::cout << "  q/quit      : 退出程序" << std::endl;
        std::cout << std::endl;
        std::cout << "示例:" << std::endl;
        std::cout << "  5 5 +        → 10" << std::endl;
        std::cout << "  2 3 pow      → 8" << std::endl;
        std::cout << "  5 fib        → 5" << std::endl;
        std::cout << "  3 2 pascal   → 3" << std::endl;
    }
};

int main() {
    RPNCalculator calc;
    std::string input;
    
    std::cout << "=== C++ RPN 计算器 ===" << std::endl;
    std::cout << "输入 'help' 查看帮助, 'q' 退出程序" << std::endl;
    
    while (true) {
        std::cout << "> ";
        std::getline(std::cin, input);
        
        if (input == "q" || input == "quit") {
            break;
        }
        else if (input == "help") {
            RPNCalculator::showHelp();
        }
        else if (input == "stack") {
            calc.displayStack();
        }
        else if (input == "clear") {
            calc.clear();
            std::cout << "栈已清空" << std::endl;
        }
        else if (input == "history") {
            calc.showHistory();
        }
        else if (input.empty()) {
            continue;
        }
        else {
            try {
                calc.evaluateExpression(input);
                if (calc.size() > 0) {
                    std::cout << "结果: " << calc.peek() << std::endl;
                }
            }
            catch (const std::exception& e) {
                std::cout << e.what() << std::endl;
            }
        }
    }
    
    std::cout << "感谢使用RPN计算器！" << std::endl;
    return 0;
}
