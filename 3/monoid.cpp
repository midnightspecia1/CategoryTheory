#include <string>
#include <concepts>
#include <iostream>


template<class T>
T mempty;

template<class T>
T mappend(T, T);

template<class M>
concept Monoid = requires (M m)
{
     mempty<M> -> M;
     mappend(m, m) -> M;
};

template<>
std::string mempty<std::string> = {""};

std::string mappend(std::string s1, std::string s2) 
{
    return s1 + s2;
}

int main()
{
   std::cout << mappend("Hello", "world!") << std::endl;
   return 0; 
}