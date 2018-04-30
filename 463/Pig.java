import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Pig {

	//static int counter = 0;
	static HashMap <Integer, Long> Table = new HashMap<>();

	static long printCompositions(int TargetVal)
	{
		long val = 0, roll = 0;

		if(TargetVal == 0 || TargetVal == 2)
			return 1;
		if(TargetVal == 1 || TargetVal < 0)
			return 0;
		if(Table.containsKey(TargetVal))
			return Table.get(TargetVal);
		for(int i = 2; i <= 6; i++)
		{
			val = printCompositions(TargetVal-i);
			roll += val;
			Table.put(TargetVal-i, val);
		}
		return roll;
	}

	    //Table.put(n, counter);
	    // Utility function to print array arr[] 
	    /*static void printArray(int arr[], int m)
	    {
	        for (int i = 0; i < m; i++)
	            System.out.print(arr[i] + " ");
	        System.out.println();
	        
	    }*/ // printing for testing
	     
	     
	    // Driver program
	    public static void main (String[] args) 
	    {
	        Scanner target = new Scanner(System.in);
        	int TargetVal= target.nextInt();
        	int size = 10000;
		    long[] arr = new long[size];
		    int count = 0;
        	while(TargetVal != -1)
	        {
		        //System.out.println("Different compositions of " + RollValue + " are"); //for testing
		        System.out.println(printCompositions(TargetVal));
		        TargetVal = target.nextInt();
		    }
	    }
}
