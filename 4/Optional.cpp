#include <math.h>
#include <functional>
#include <iostream>

//using namespace std

template<class A> 
class optional 
{
    bool _isValid;
    A _value;
public:
    optional() : _isValid(false) {};
    optional(A v) : _isValid(true), _value(v) {};
    bool isValid() const { return _isValid; };
    A value() { return _value; };
};

template<class A>
using o = optional<A>;

o<double> safe_root(double x)
{
    if(x >= 0) return optional<double>{ sqrt(x) };
    else return optional<double>();
};

template<class A>
using o = optional<A>;

//Composition for partial functions
//(A -> o<B>) -> (B -> o<C>) -> (A -> o<C>)
template<class A, class B, class C>
std::function<o<C> (A)> compose(std::function<o<B> (A)> f1,
                               std::function<o<C> (B)> f2)
{
    return [f1, f2](A x)
    {
        auto result1 = f1(x);
        if(result1.isValid() == true)
        {
            return f2(result1.value());
        }
        else
        {
            return o<C>();
        }
    };
};

template<class A>
o<A> identity(A a)
{
    return optional(a);
}

o<double> safe_reciprocal(double x)
{
    if(x != 0.0f){ return optional<double>(1.0f / x); }
    else { return optional<double>(); }
}

o<double> safe_root_reciprocal(double a)
{
    return compose<double, double, double>(safe_reciprocal, safe_root)(a);
}

int main()
{ 
    auto idX = identity<double>(5.0f);
    auto compo = compose<double, double, double>(identity<double>, safe_root);
    auto compo2 = compose<double, double, double>(safe_root, identity<double>);
    std::cout << "composition result: " << compo(16).value();
    std::cout << "composition two result: " << compo2(16).value();
    
    return 0;
}