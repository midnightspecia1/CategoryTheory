#include <tuple>
#include <utility>
#include <string>
#include <iterator>
#include <algorithm>
#include <vector>

using namespace std;

string logger;

// here impure function that chages global state
// bool negate(bool b)
// {
//     logger += "Not so! ";
//     return !b;
// }

// pair<bool, string> negatee(bool b, string logger)
// {
//     return make_pair(!b, logger + "Not so! ");
// }

// the thing with this version is that the log would be agregated between calls
// pair<bool, string> negate(bool b) 
// {
//     return make_pair(!b, "Not so! ");
// }

// vector<string> toWords(string s)
// {
//     return words(s);
// }

vector<string> words(string s)
{
    vector<string> result{""};
    for (auto i = begin(s); i != end(s); ++i)
    {
        if(isspace(*i))
            result.push_back(" ");
        else
            result.back() += *i;
    }
    return result;
    
}

//making Writer that encapsulates pair with an arbitrary A and a string
//this notation is kinda simmilar to type synonyms
template<class A>
using Writer = pair<A, string>;

Writer<string> toUpper(string s)
{
    string result;
    int (*toupperp)(int) = &toupper;
    transform(begin(s), end(s), back_inserter(result), toupperp);
    return make_pair(result, "toUpper ");
}

Writer<vector<string>> toWords(string s)
{
    return make_pair(words(s), "toWords ");
}

Writer<vector<string>> process(string s)
{
    auto p1 = toUpper(s);
    auto p2 = toWords(p1.first);
    return make_pair(p2.first, p1.second + p2.second);
}

//this is the morphism int -> bool even thought it returns pair !!
pair<bool, string> isEven(int n)
{
    return make_pair(n % 2 == 0, "isEven ");
}

pair<bool, string> negatee(bool b)
{
    return make_pair(!b, "Not so! ");
}

//composition
// pair<bool, string> isOdd(int n)
// {
//     pair<bool, string> p1 = isEven(n);
//     pair<bool, string> p2 = negatee(p1.first);
//     return make_pair(p2.first, p1.second + p2.second);
// }

//abstracting out the composition
template<class A, class B, class C>
function<Writer<C>(A)> compose(function<Writer<B>(A)> m1, 
                               function<Writer<C>(B)> m2)
{
    return [m1, m2](A x)
    {
        auto p1 = m1(x);
        auto p2 = m2(p1.first);
        return make_pair(p2.first, p1.first + p2.first);
    }
}

template<class A>
Writer<A> identity(A x)
{
    return make_pair(x, "");
}

//in c++14 type deduction we can write compose like this
auto composee = [](auto m1, auto m2)
{
    return [m1, m2](auto x)
    {
        auto p1 = m1(x);
        auto p2 = m2(p1.first);
        return make_pair(p2.first, p1.second + p2.second);
    }
};

//now we can rewrite process
Writer<vector<string>> process(string s)
{
    return compose<string, string, vector<string>>(toUpper, toWords)(s);
}

Writer<bool> isOdd(int n)
{
    return compose<int, bool, bool>(isEven, negatee)(n);
}

int main()
{
    //negatee(true, "something");
    //negatee(true, "and something");
    
    return 0;
}

//1. so Writer is a ligitimate category because of associativity
//   and identity
//2. we can use mappend inside compose (in place of +)
//   and use mempty inside identity (in place of "") 
//   to generalize this construction to any monoid
//3. We can make Writer with all different types that resposdes some constraints
//   not only string