#include "queue.h"

Queue::Queue(double Obj)
{
    CPU_speed = Obj;

}

Queue::~Queue()
{

}

Queue::get_Q_size()
{
    return Q_List.size();
}

Queue::Q_process()
{
    if (Q_List.empty())
    {
        //Queue is empty; nothing to process
        return false;
    }
    Q_List.pop_back();
    std::cout << "Current amount of packages in Queue is: " << Q_List.size() << std::endl;
}

Queue::insert_Packages_test(int Obj)
{
    for (int i = 0 ; i < Obj ; i++)
    {
        Package* testPackage = new Package(); //fill in with appropriate arguments
        Q_Sort (testPackage);
    }
}
