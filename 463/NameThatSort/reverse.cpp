#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;

int main() 
{	
	int n = 100000;
	ofstream myfile;
  	myfile.open ("R.txt");

  	myfile << n << "\n";
    int Num[n];
    for(int i = n; i > 0; i--)
    {	
        Num[i] = i;
        int l = rand() % 26;
        char c = (char)(l+65);
        myfile << i << " " << c << "\n" ;
    }

    myfile.close();
    return 0;
}