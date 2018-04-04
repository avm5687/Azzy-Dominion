import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Trains {
    public static void main(String[] args) throws NumberFormatException, IOException {
       System.setIn(new FileInputStream(new File("input.txt")));
       BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
       int n = Integer.valueOf(reader.readLine());
       String ArrivalArray[] = new String[n];
       String DepartArray[] = new String[n];

       for (int i = 0; i < n; i++) {
           String[] times = reader.readLine().split(" ");
           ArrivalArray[i] = times[0];
           DepartArray[i] = times[1];        
       }
       Arrays.sort(ArrivalArray);
       Arrays.sort(DepartArray);
       /*for(int j = 0; j < n; j++)//for my testing purposes
       {
       	System.out.print(ArrivalArray[j]+ " ");
       	System.out.println(DepartArray[j]);
       }*/

       //using a merged sort to determine arrival and departures
       int platformsatTime = 0;
       int platformsN = 0; //platforms needed by end
       int j = 0, k = 0;
       while(j < n && k < n)
        {
          if(ArrivalArray[j].compareTo(DepartArray[k]) < 0)
          {
            platformsatTime++;
            j++;
            if(platformsatTime > platformsN)
              platformsN = platformsatTime;
          }
          else
          {
            platformsatTime--;
            k++;
          }
        }
        System.out.println(platformsN);
    }
}