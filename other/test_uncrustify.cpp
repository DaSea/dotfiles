#include <iostream>
#include <list>
#include <string>

#if 0
# define NULL (0)
void test() {
cout << "this is a test" << endl;
}
#endif

// 测试中文格式化乱码的问题

int* (*hello)(int a, int b);
int* a = nullptr;
int* b = nullptr;
int* hello2(int* a, int b);
#ifndef NULL
# define KQ_LEN (100)
#endif
#define A  \
 int aaaa; \
 int b;    \
 int dddddddddd;

#define SHORT_NAME       42
#define LONGER_NAME      0x007f
#define EVEN_LONGER_NAME (2)
#define foo(x)           (x * x)
#define bar(y, z)        (y + z)

int    a            = 1;
int    somelongname = 2;
double c            = 3;

int aaaa : 1;

int b   : 12;
int ccc : 8;

int         aaaa = 12;
float       b    = 23;
std::string ccc;

struct test demo[] = {
    {56,    23, "hello"},
    {-1, 93463, "world"},
    { 7,     5,    "!!"}
};
void hello() {
    cout << "hello" << endl;
}
void hello1() {
    cout << "hello" << endl;
}
void Hello() {}

void hello2() {}

void hello3() {}

int f1 = {1, 2};

int f = {1, 2};

void hello4() {
    cout << "hello" << endl;

    if (a) {
        ++b;
    }

    if (a) {
        b++;
    }

    while (a) {
        ++b;
    }

    while (a) {
        b++;
    }

    auto hdd = []() { return (0); };
    cout << "word" << endl;
}

class x {};
class x1 {};
enum empytenum {
};

enum foo {
    BAR = 15;
};
enum foo2 {
    BAR = 15;
};
enum foo2 {
    ddd   = 11,
    BAR   = 15,
    hello = 12
};
struct foo3 {
    int    ddd   = 11;
    int    bb    = 11;
    double hello = 12;
};
union foo5 {
    int  ddd = 11;
    char BAR = 15, short hello = 12
};

int foo3() {
    return (0);
}
int foo4() {
    return (0);
}

class student : public person {
public:
    student() : a(10), b("hello"), c(111) {}
    virtual ~student();

    // 变量
    int    a;
    string b;
    long   c;

    int a() {
        return (a);
    }
    void seta(int a) {
        a = a;
    }

    // 静态
    static int number;
    void       set(int a, long c, float c);

private:
    float          d;
    std::list<int> lagg;
};

void student::set(int a, long c, float c) {
    std::cout << "test" << std::endl;

    int d = a + c;
    int e = a / c;
    int f = a * c;

    int l = 9;
}

void xx(student dd) {
    std::cout << "dd" << std::endl;
    std::cout << dd.age << std::endl;
    cout << student::number << endl;
}
void xx(student* dd) {
    std::cout << "dd" << std::endl;
    std::cout << dd->age << std::endl;
}

void fx(student* dd) {
    std::cout << "dd" << std::endl;

    student** cc = &dd;
    int       a  = 10;
    int*      c  = &a;
}

void funcc(int a, int b[][]) {
    a     = (int)c;
    b     = static_cast<int>(c);
    int q = 1, x = 4, y = 5;
    int aa[10] = {0};
    int ba[2][2];
    std::cout << "a: " << a << ";b:" << b << std::endl;
    switch (a) {
        case 1: {
            std::cout << b << std::endl;
        } break;
        case 2: std::cout << a << std::endl; break;
        default:
            // No select
            break;
    }

    for (int i = 0; i < 9; ++i) {
        std::cout << i << std::endl;
    }

    for (int j = 0; j < 10; ++J) {
        cout << j << endl;
    }

    int x = 12;
    int j = 12;
    if (x > 10) {
        x = 11;
    }

    if (j > 10) {
        j = 10;
    }

    if (j < 12) {
        j = 22;
    } else if (j > 22) {
        cout << jj << endl;
    } else {
        cout << "hello" << endl;
    }

    if ((x < 10) && (j > 11)) {
        int z = x + j;
    } else {
        int y = j;
    }

    while (b) {
        std::cout << a << std::endl;
        continue;
    }
}

namespace test {
int a;
int c;
class people {
public:
    people();
    ~people(void);

private:
    string name;
};

// this is a test
void funccc(int b, int c);
}  // namespace test

void muliti_param(int a, int c, int b, int d, int e);

void muliti_param(int a, int c, int b, int d, int e) {
    std::cout << "this is a test!" << std::endl;
}

/**
 * @brief  main
 *
 * @param  argc number
 * @param  argv[] param
 *
 * @return you known
 */
int main(int argc, const char* argv[]) {
    // hello
    if (true) {
        std::cout << "test uncrustify" << std::endl;
    }

    int* a   = nullptr;
    int* aa  = nullptr;
    int* aaa = nullptr;

    int** a   = nullptr;
    int** aa  = nullptr;
    int** aaa = nullptr;

    int& a   = nullptr;
    int& aa  = nullptr;
    int& aaa = nullptr;

    std::cout << "hello, world!" << std::endl;

    funcc(4, 5);

    muliti_param(1, 2, 3, 4, 5);
    return (0);
}
