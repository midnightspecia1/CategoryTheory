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

pair<bool, string> negate(bool b, string logger)
{
    return make_pair(!b, logger + "Not so! ");
}

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

int main()
{
    negate(true, "something");
    negate(true, "and something");
    return 0;
}