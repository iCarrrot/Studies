#include <iostream>
#include <thread>
#include <fstream>
#include <vector>
#include <random>
#include <unistd.h>
#include <cstdlib>
#include <time.h>
#include <string>
#include <sstream>
#include <semaphore.h>
#include <cstddef>
using namespace std;

struct SlaveInfo
{
	bool ifEnd;
	int number;
	long long int track;
	
};
struct dint
{
	int number;
	long long int track;
};
struct ProgInfo
{	
	SlaveInfo * Sinf;
	int bufor;
	int fNum;
	sem_t *sem;
	sem_t *back;	
};

bool isIn(vector <dint> v, int id);

dint finder (vector <dint> *v, int current );

void slave(int id, string fName, SlaveInfo *info, sem_t * sem, sem_t * back);

void master(  ProgInfo * inf );


int main(int argc, char *argv[]){
	//argument init
	string b= argv[1];
	int fNum=argc-2;
	int bufor = stoi(b);


	thread SlaveS[fNum]; 
	SlaveInfo Sinf[fNum];

	sem_t sems[fNum];
	sem_t sem_back[fNum];


	ProgInfo info;
		info.Sinf=Sinf;
		info.bufor=bufor;
		info.fNum=fNum;
		info.sem=sems;
		info.back=sem_back;

	for (int i = 0; i < fNum; i++)
	{
		string temp=argv[i+2];
		sem_init(&(sems[i]), 2, 0);
		sem_init(&(sem_back[i]), 2, 0);
		SlaveS[i] = thread(&slave, i,temp, &(Sinf[i]), &sems[i], &sem_back[i] );

	}

	thread Master=thread(&master, &info);
	Master.join();


	for (int i=0;i<fNum;i++){
		SlaveS[i].join();
	}


	return 0;
}

void slave(int id, string fName, SlaveInfo *info, sem_t * sem, sem_t * back){
	fstream plik;
	plik.open( fName, ios::in);

	vector < int > dane;

	for (string temp; getline(plik, temp); ) {
        dane.push_back(stoi(temp));
    }

	info->number = id;
	info->ifEnd = 0;
	vector<int>::iterator it = dane.begin();

	if(dane.empty()){
		info->ifEnd = 1;
	}

	else{
		info->track = dane[0];
		sem_post(sem);
		sem_wait(back);
		
	}

	while(! dane.empty()){
			sem_wait(sem);
			printf("service requester %d track %llu\n",id, info->track );

			it = dane.begin();
			dane.erase(it);

			info->track = dane[0];
			sem_post(back);
			
	}


	info->ifEnd = 1;
}

void master(  ProgInfo * inf ){

	int bufor 		= inf->bufor; 
	int numOfFiles 	= inf->fNum;
	sem_t *sem		= inf->sem;
	sem_t *back 	= inf->back;
	SlaveInfo *info = inf->Sinf;


	int current=0;
	vector <dint> v;

	//czekam aż wszyscy niewolnicy zakończą swoją inicjację
	for (int i = 0; i < numOfFiles; i++)
	{
		sem_wait(&sem[i]);	
	}
	for (int i = 0; i < numOfFiles; i++)
	{
		sem_post(&back[i]);	
	}

	int counter=0;//potrzebny do pierwszego napełnienia bufora
	int licznik=0;//będzie iteratorem przez cały czas działania programu

	//pierwsze napełnienie bufora
	while(counter<bufor && licznik<numOfFiles){

		dint temp;

		if(info[licznik].ifEnd==0)
		{
			temp.number=info[licznik].number;
			temp.track=info[licznik].track;
			printf("requester %d track %llu\n", temp.number, temp.track);
			v.push_back(temp);
			counter++;
		}
		licznik++;
	}


	dint currentSlave = finder(&v,current); //pierwszy najbliższy rekord

		current=currentSlave.track;
		int numer=currentSlave.number;
		//wywołujemy pierwszy najbliższy rekord
	sem_post(&sem[numer]);
	sem_wait(&back[numer]);

	while(! v.empty()){
		int old_licznik=licznik;
		int circle_counter=0;//sprawdza czy nie zatoczyliśmy koła przechodząc po buforze
		dint temp;

		//znajdujemy kolejny wątek który chce się wpisać
		while((info[licznik].ifEnd==1 && circle_counter<2) || isIn(v,licznik) || licznik==numer){

			if(licznik==old_licznik)
				circle_counter++;

			licznik++;
			licznik %= numOfFiles;
		}
		//jeżeli znależliśmy taki wątek, to pozwalamy mu się wykonać
		if(info[licznik].ifEnd==0 && v.size()<=(uint)bufor && ( !isIn(v,licznik)) ){
			temp.number=info[licznik].number;
			temp.track=info[licznik].track;

			printf("requester %d track %llu \n", temp.number, temp.track);
			v.push_back(temp);

			licznik++;
			licznik%=numOfFiles;
		}	
		//aktualizujemy aktualny numer ścieżki
		currentSlave = finder(&v,current);
			current = currentSlave.track;
			numer = currentSlave.number;
		//wątku wykonaj się
		sem_post(&sem[numer]);
		sem_wait(&back[numer]);		
		
	}
	printf("Thread library exiting.\n");
}

bool isIn(vector <dint> v, int id){
	for(uint i=0;i<v.size();i++){
		if(v[i].number == id)
			return true;
	}
	return false;
}

dint finder (vector <dint> *v, int current ){
	int min;
	int nr=0;
	int nUmber=(*v)[0].number;
	int tRack=(*v)[0].track;
	(*v)[0].track-current<0? min=-1*((*v)[0].track-current):min=(*v)[0].track-current;

	for(unsigned int i=0;i<v->size();i++){
		int temp;

		(*v)[i].track-current<0 ? temp=-1*((*v)[i].track-current) : temp=(*v)[i].track-current;
		
		if (temp<min) {
			min=temp;
			nr=i;
			nUmber=(*v)[i].number;
			tRack=(*v)[i].track;
		}
	}
	
	*v->erase(v->begin() + nr);
	
	dint currentSlave;
		currentSlave.number=nUmber;
		currentSlave.track=tRack;

	return currentSlave;
}