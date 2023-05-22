#include "functional"
#include "string"
#include "iostream"

template<class T>
struct Tree
{
    virtual ~Tree(){};
};

//leaf is identity functor - just container of the value T
template<class T>
struct Leaf : public Tree<T>
{
    T _label;
    Leaf(T l) : _label(l) {}
};

//Node is a product type of the left and right
//it's a bifunctor!
template<class T>
struct Node : public Tree<T>
{
    Tree<T>* _left;
    Tree<T>* _right;
    Node(Tree<T>* l, Tree<T>* r) : _left(l), _right(r) {} 
};

template<class A, class B>
Tree<B>* fmap(std::function<B(A)> f, Tree<A>* t)
{

    Leaf<A>* l = dynamic_cast<Leaf<A>*>(t);
    if(l)
    {
        std::cout << "Leaf finded\n";
        return new Leaf<B>(f (l->_label));
    }

    Node<A>* n = dynamic_cast<Node<A>*>(t);
    if(n)
    {
        std::cout << "Node finded\n"; 
        return new Node<B>(fmap<A,B>(f, n->_left), fmap<A,B>(f, n->_right));
    } 
 
    return nullptr;
};

int main()
{
    using TreeI = Tree<int>;
    using LeafI = Leaf<int>;
    using NodeI = Node<int>;

    TreeI* L1 = new LeafI(20);
    TreeI* L2 = new LeafI(25);
    TreeI* L3 = new LeafI(30);
    TreeI* L4 = new LeafI(35);

    TreeI* N1 = new NodeI(L1, L2);
    TreeI* N2 = new NodeI(L3, L4);
    TreeI* N3 = new NodeI(N1, N2);

    fmap<int, std::string>([](int x){
        std::string s = std::to_string(x);
        std::cout << s << std::endl;
        return s;
    }, N3);

    return 0;
}

// haskell implementation for comparison
// instance Functor Tree where
//     fmap f (Leaf a) = Leaf (f a)
//     fmap f (Node a b) = Node (fmap f a) (fmap f b)