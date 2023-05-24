#include "functional"
#include "utility"
#include "string"
#include "iostream"
#include <map>
#include <iomanip>

//8.9.4
//defining bimap for the std::pair
template<class A, class B, class C, class D>
std::pair<B,D> bimap(std::function<B(A)> f,
                    std::function<D(C)> g,
                    std::pair<A,C> m)
{
    return std::pair<B,D>(f(m.first), g(m.second));
} 

template<class T>
T id(T t)
{
    return t;
}

//8.9.5 should std::map consider a bifunctor or profunctor
//I think std::map is the functor because it is list of the pairs
//so basicly it's a functor and bifunctor inside
//somehow we need to put inside the list functor f and g to apply them to the pair binfunctor
 

int main()
{
    std::pair<int, std::string> p{20, "hello"};

    auto f = [](int a){ return static_cast<float>(a); };
    auto g = [](std::string s){ return s.empty(); };
    auto p2 = bimap<int, float, std::string, bool>(f, g, p);
    //std::cout << p2.first << " <- float, " << p2.second << " <- bool" << std::endl;

    //test that bimap preserve identity
    auto idI = id<int>;
    auto idS = id<std::string>;
    auto p3 = bimap<int, int, std::string, std::string>(idI, idS, p);
    if(p == p3){ std::cout << "Identity preserved, bimap(id, id, p) == p" << std::endl;}

    //test that bimap preserves composition
    auto f2 = [](float f){return static_cast<double>(f);};
    auto g2 = [](bool b){return static_cast<int>(b); };

    auto fComp = [&](int i){ return f2(f(i));};
    auto gComp = [&](std::string s){return g2(g(s)); };
    
    auto composed = bimap<int, double, std::string, int>(fComp, gComp, p);

    auto bimapFirst = bimap<int, float, std::string, bool>(f, g, p);
    auto bimapSecond = bimap<float, double, bool, int>(f2, g2, bimapFirst);
    if(composed == bimapSecond){ std::cout << "Composition preserved, bimap((f2 . f), (g2 . g), p) == (bimap(f2, g2) . bimap(f, g)) p" << std::endl;}
}
