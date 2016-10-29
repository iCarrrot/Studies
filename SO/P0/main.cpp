#include <iostream>
#include <thread>
using namespace std;
void thread_1(){
	cout<<"th1\n";
}
void thread_2(){
	cout<<"th2\n";
}

int main(){
	thread t1(&thread_1);
	thread t2(&thread_2);
	t1.join();
	
	t2.join();
	cout<<"mian_t\n";
	return 0;
}