#include <string>
#include <concepts>
#include <type_traits>



template<class T>
T mempty;

template<class T>
T mappend(T, T) = delete;

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
   return 0; 
}