#include <functional>
#include <iostream>


template<typename L>
class Left
{
public:
    Left(){};
    Left(L inL){ val = inL; };

private:
    L lval;
};

template<typename R>
class Right
{
public:
    Right(){};
    Right(R inR){ rval = inR; };

private:
    R rval;
};

template<typename A, typename B>
class Either
{
public:
    Either(Left<A> l)
    {   
        L = l; 
        isLeft = true;
    };

    Either(Right<B> r)
    { 
        R = r;
        isLeft = false;
    };

    bool isLeft(){ return isLeft; }
    A GetLeft(){ return L; }
    B GetRight(){ return R; }
private:
    Left<A> L;
    Right<B> R;
    bool isLeft;
};

void driver(Either<int, float> e)
{
    
};

int main()
{
    driver(Left<int>(5));
    
    return 0;
}

//5.5 show that either is better than the 
int i(int n){ return n; };
int j(bool b){ return b ? 0 : 1; };

//m factorizes i and j
int m(Either<int,bool> &e)
{
    if(e.isLeft())
    { 
        return i(e.GetLeft()); 
    }
    else          
    { 
        return j(e.GetRight());
    }
};

//either is better because we can reproduce i and j with compositions
// m . Left and m . Right

//5.6 in opposite way when we going
// int  -> int -> either
// bool -> int -> either
//after first morphism we cannot understand which value to use Left or Right

//5.7 what about those injections
int i_(int n)
{
    if(n < 0)
    {
        return n;
    }
    else n + 2;
}

int j_(bool b) { return b ? 0 : 1; }

Either<int,bool> m_(int n)
{
    if(n == 0)
    {
        return Right<bool>(true);
    }
    if(n == 1)
    {
        return Right<bool>(false);
    }
    return Left<int>(true);
}
//it looks like its fine but, in the first function i_ of the composition (m_ . i_) 
//int can be overflowed by the passing maxInt number in that function
//so Either is still better candidate than int

//5.8 