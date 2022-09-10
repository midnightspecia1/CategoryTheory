#include <functional>
#include <iostream>
#include <map>

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

int main()
{
    auto newFunc = memoize<int>(square);
    std::cout << "newFunc answer: " << newFunc(4) << std::endl;
    std::cout << "newFunc answer: " << newFunc(16) << std::endl;
    std::cout << "newFunc answer: " << newFunc(4) << std::endl;
    return 0;
}