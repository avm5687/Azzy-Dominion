#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;

int main() 
{	
	int n = 2;
	ofstream myfile;
  	myfile.open ("two.txt");

  	myfile << n << "\n";

	int l = rand() % 26;
    char c = (char)(l+65);
    int j = 1;
    myfile << j << " " << c << "\n" ;
    myfile << 100000 << " " << c << "\n" ;
    myfile.close();
    return 0;
}