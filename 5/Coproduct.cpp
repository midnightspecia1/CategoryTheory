
// in cathegory of sets coproduct it is disjoint union of two sets 
// element of dijoint union of a and b  -  is either a or and element b
// we can think of element of the disjoint union as being tagged to specify it origin

// Contact is the implementation of the coproduct of the int and string 
// tag field is for the understanding what union object is valid
enum ContactType { isPhone, isEmail };

struct Contact
{
public:
    ContactType tag;
    union { int phoneNum; char const* emailAdr; };
};

Contact PhoneNum(int n)
{
    Contact c;
    c.tag = isPhone;
    c.phoneNum = n;
    return c;
};

Contact EmailAddr(char const* Adr)
{
    Contact c;
    c.tag = isEmail;
    c.emailAdr = Adr;
    return c;
}


int Main()
{
    Contact phone = PhoneNum(123123);
    Contact email = EmailAddr("alo@.asd");

    return 0;
};

//boost::variant is the very general implementation of the tagged union
//in UE5 we can use TVariant based loosely on std::variant