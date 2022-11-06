
class Shape
{
    virtual float Area();
    virtual float Circ();
};

class Square : public Shape
{
    Square(const float H)
    {
        h = H;
    }

    virtual float Area() override
    {
        return h * h;
    };

    virtual float Circ() override
    {
        return h * 4;
    }
private:
    float h;
};

class Rect : public Shape
{
    Rect(const float H, const float D){
        h = H;
        d = D;
    };

    virtual float Area() override
    {
        return h * d;
    };

    virtual float Circ() override
    {
        return 2.0f * h * d;
    }

private:
    float h;
    float d;
};

class Circle : public Shape
{
    Circle(const float R){
        r = R;
    };

    virtual float Area() override
    {
        return 3.14f * r * r;
    };
    
    virtual float Circ() override
    {
        return 2.0f * 3.14f * r;
    }

private:
    float r;
};

int main()
{ return 0; }