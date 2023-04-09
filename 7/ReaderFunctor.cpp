#include <functional>
#include <string>
#include <iostream>

//READER FUNCTOR
template<class A, class B, class R>
std::function<B(R)> fmap(std::function<B(A)> f, std::function<A(R)> a){
    return [&](R r){
        return f(a(r));
    };
}

std::string test1(int t){ return std::to_string(t);}
int test2(bool b){ return b ? 1 : 0;}


int main()
{
    auto resultR = fmap<int, std::string, bool>(test1, test2);
    std::cout << resultR(false) << std::endl;
    return 0;
}