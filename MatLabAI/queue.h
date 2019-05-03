#ifndef QUEUE_H
#define QUEUE_H

#include <package.h>
#include <list>
#include <iostream>

class Queue
{

    public:
        Queue(double Obj);
        virtual ~Queue();
        void Q_sort (Package* Obj);
        void Q_process ();
        int get_Q_size ();
        void insert_Packages_test (int Obj);

    private:
        double CPU_speed;
        std::list<Package*> Q_List;

};

#endif // QUEUE_H
