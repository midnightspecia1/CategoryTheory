#include <functional>
#include <iostream>
#include <map>
#include <cstdlib>

template <typename T>
class memFunctor
{
    std::function<T(T a)> memorizedFunc;
    std::map<T,T> stored;

    public:
        memFunctor(std::function<T(T a)> f)
        {
            memorizedFunc = f;
        }

        T operator() (T a) 
        {
            auto finded = stored.find(a);
            if(finded != stored.end())
            {
               std::cout << "returned saved value ";
               return finded->second; 
            }
            else 
            {
                stored[a] = memorizedFunc(a);
                std::cout << "returned new value ";
                return stored[a];
            }
        }
};

template <typename R>
memFunctor<R> memoize(std::function<R(R a)> f)
{
    return memFunctor<R>(f);
};

int square (int a)
{
    return a*a;
}

int random(int a)
{
    std::srand(a);
    return std::rand();
}

int fact(int n)
{
    int i;
    int result = 1;
    for (i = 2; i <= n; ++i)
    {
        result *= i;
    }
    return result;
}

bool fOne()
{
    std::cout << "Hello!" << std::endl;
    return true;
}

int fTwo(int x) 
{
    static int y = 0;
    y += x;
    return y;
}

bool boolOne(bool b)
{
    return true;
}

bool boolTwo(bool b)
{
    return false;
}

bool boolThree(bool b)
{
    return b;
}

bool boolFour(bool b)
{
    return !b;
}

int main()
{
    auto newFunc = memoize<int>(fTwo);
    std::cout << "newFunc answer: " << newFunc(10) << std::endl;
    std::cout << "newFunc answer: " << newFunc(2) << std::endl;
    std::cout << "newFunc answer: " << newFunc(10) << std::endl;

    return 0;
}

//1) bool -> bool
//   t -> t, f -> t (boolOne)
//   t -> f, f -> f (boolTwo)
//   t -> t, f -> f (boolThree)
//   t -> f, f -> t (boolFour)
//2) () -> bool
//   () -> t (const True)
//   () -> f (const False)
//3) bool -> () (const ())
//4) Void -> () (absurd)
//   Void -> bool (absurd)
//   Void -> Void (absurd)

