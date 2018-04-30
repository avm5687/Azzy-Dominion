#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;

int main() 
{	
	int n = 10000;
	ofstream myfile;
  	myfile.open ("S.txt");

  	myfile << n << "\n";
    int Num[n];
    for(int i = 0; i < n; i++)
    {	
        Num[i] = i;
        int l = rand() % 26;
        char c = (char)(l+65);
        myfile << i << " " << c << "\n" ;
    }
    
    myfile.close();
    return 0;
}