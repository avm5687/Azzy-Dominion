#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;

int main() 
{	
	int n = 10000;
	ofstream myfile;
  	myfile.open ("same.txt");

  	myfile << n << "\n";
    int Num[n];
    for(int i = 0; i < n; i++)
    {	
        Num[i] = 1;
        int l = rand() % 26;
        char c = (char)(l+65);
        myfile << Num[i] << " " << c << "\n" ;
    }
    
    myfile.close();
    return 0;
}