#include <tuple>
#include <utility>
#include <string>
#include <iterator>
#include <algorithm>
#include <vector>

std::string logger;

// here impure function that chages global state
// bool negate(bool b)
// {
//     logger += "Not so! ";
//     return !b;
// }

std::pair<bool, std::string> negate(bool b, std::string logger)
{
    return make_pair(!b, logger + "Not so! ");
}

// the thing with this version is that the log would be agregated between calls
// std::pair<bool, std::string> negate(bool b) 
// {
//     return make_pair(!b, "Not so! ");
// }

// std::vector<std::string> toWords(std::string s)
// {
//     return words(s);
// }

std::vector<std::string> words(std::string s)
{
    std::vector<std::string> result{""};
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
using Writer = std::pair<A, std::string>;

Writer<std::string> toUpper(std::string s)
{
    std::string result;
    int (*toupperp)(int) = &std::toupper;
    std::transform(begin(s), end(s), std::back_inserter(result), toupperp);
    return make_pair(result, "toUpper ");
}

Writer<std::vector<std::string>> toWords(std::string s)
{
    return make_pair(words(s), "toWords ");
}

Writer<std::vector<std::string>> process(std::string s)
{
    auto p1 = toUpper(s);
    auto p2 = toWords(p1.first);
    return make_pair(p2.first, p1.second + p2.second);
}

int main()
{
    negate(true, "something");
    negate(true, "and something");
    return 0;
}