#include <optional>
#include <functional>
//for dafining a functor type class we need to template template param F - we cannot do it in c++
// template<template<class> F, class A, class B>
// F<B> fmap(std::function<B(A)>, F<A>);

// template<class A, class B>
// optional<B> fmap<optional>(std::function<B(A)>, optional<A> opt)

template<class A, class B>
std::optional<B> fmap(std::function<B(A)> f, std::optional<A> opt)
{
    if(!opt.isValid())
    {
        return std::optional<B>{};
    }
    else
    {
        return std::optional<B>{ f(opt.val()) };
    }
}

struct Absurd
{
private:
    Absurd();
    
}; 


//VECTOR FUNCTOR
template<class A, class B>
std::vector<B> fmap (std::function<B(A)> f, std::vector<A> vecA)
{
    std::vector<B> w;
    std::transform( std::begin(vecA),
                    std::end(vecA),
                    std::back_inserter(w),
                    f);
    return w;
};

// CONST FUNCTOR
template<class C, class A>
struct Const
{
    Const(C v) : _v(v){};
    C _v;
};

template<class C, class A, class B>
Const<C, B> fmap(std::function<B(A)> f, Const<C, A> c)
{
    return Const<C, B>(c._v);
};

int main()
{
    return 0;
}