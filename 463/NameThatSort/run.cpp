#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;

int main() 
{	
	int n = 100;
	ofstream myfile;
  	myfile.open ("Test.txt");

  	myfile << n << "\n";

    for(int i = 0; i < n; i++)
    {	
    	int l = rand() % 26;
    	char c = (char)(l+65);
    	int j = rand() % 15;
    	myfile << j << " " << c << "\n" ;
    }
    myfile.close();
    return 0;
}
