import java.io.*;
import java.util.*;

public class MazeRunner {
	public static boolean path = false;

	public static class Disjoint
	{
		//Scanner mazeScan = new Scanner(System.in);
		public int[] Maze;
		private int size;

		public Disjoint(int x)
		{
			Maze = new int[x*x+2];
			size = x;
		}

		public void CheckIndex(int x)
		{
			if(x < -1 || x > Maze.length)
				System.out.println("Out of Bounds");
		}

		public void CreateSet(int x)
		{
			CheckIndex(x);
			if(Maze[x] == 0)
				Maze[x] = -1;
		}

		public int find(int x)
		{
			CheckIndex(x);
			if (Maze[x] == 0)
				return 0;
			if(Maze[x] < 0)
			{
				return x;
			}
			else
			{	
				int root = find(Maze[x]);
				Maze[x] = root; //path compression
				return root;
			}
		}

		public void union(int x, int y)
		{
			CheckIndex(x);
			CheckIndex(y);
			if(Maze[x] >= 0 || Maze[y] >= 0)
			{
				x=find(x);
				y = find(y);
			}
			//if(Maze[y] >= 0)
				//y = find(y);
			if(x == y)
			{
				System.out.println("Hi Bitch");
				path = true;
				return;
			}
			if(Maze[x] > Maze[y])
			{
				Maze[y] = Maze[y] + Maze[x];
				Maze[x] = y;
			}
			else
			{
				Maze[x] += Maze[y];
				Maze[y] = x;
			}
		}
		public void getMaze(int size)
		{
			for(int i = 1; i <= size; i++)
			{
				for(int j = 1; j <= size; j++)
				{
					System.out.print(Maze[size*(i-1) + j] + " ");
				}
				System.out.println();
			}
			System.out.println();
		}
	}

    public static void main(String[] args) throws IOException {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        System.setIn(new FileInputStream(new File("input.txt")));
        Scanner mazeScan = new Scanner(System.in);
        int  MazeSize = mazeScan.nextInt();
        int row = 0;
        int column = 0;
        int count = 0;
        int placement = 0;
        int a, b, c, d, e, f, sum = 0;
        Disjoint StorageArray = new Disjoint(MazeSize);
        //int[] placementA;
        //placementA = new int[MazeSize*MazeSize+3];
        //row = mazeScan.nextInt();
        //column = mazeScan.nextInt();
        //sum++;
        row = 1;
        boolean flag = false;
  		boolean flag1 = false;
  		boolean flag2 = false;
        while (row > 0)
        {
  			while(!flag)
  			{	
  				row = mazeScan.nextInt();
	        	if(row == -1)
	        		break;
        		column = mazeScan.nextInt();
	        	placement = MazeSize * (row - 1) + column;
	        	//placementA[placement] = placement;
	        	StorageArray.CreateSet(placement);
	        	sum++;
	        	e=StorageArray.find(placement);
	        	//System.out.println(e);
	        	a=placement-1;
	        	b=placement+1;
	        	c=placement-MazeSize;
	        	d=placement+MazeSize;
	        
	        	if((placement%MazeSize) == 0)
	        	{
	        		if(a> 0 && a <= (MazeSize*MazeSize))
	        		{	
	        			a = StorageArray.find(a);
	        			if(a != 0)
	        				StorageArray.union(a, e);
	        		}

	        		if(b> 0 && b <= (MazeSize*MazeSize))
	        		{
	        			b = StorageArray.find(b);
	        			if(b != 0)
	        				StorageArray.union(b, e);
	        		}

	        		if(c> 0 && c <= (MazeSize*MazeSize))
	        		{
	        			c = StorageArray.find(c);
	        			if(c != 0)
	        				StorageArray.union(c, e);
	        		}
	        		//e=StorageArray.find(placement);
	        	}

	        	if((placement%MazeSize) == 1)
	        	{	
	        		if(d> 0 && d <= (MazeSize*MazeSize))
	        		{	
	        			d = StorageArray.find(d);
	        			if(d != 0)
	        				StorageArray.union(d, e);
	        		}

	        		if(b> 0 && b <= (MazeSize*MazeSize))
	        		{
	        			b = StorageArray.find(b);
	        			if(b != 0)
	        				StorageArray.union(b, e);
	        		}

	        		if(c> 0 && c <= (MazeSize*MazeSize))
	        		{
	        			c = StorageArray.find(c);
	        			if(c != 0)
	        				StorageArray.union(c, e);
	        		}
	        	}	//b c d

	        	if((placement%MazeSize) > 1)
	        	{
	        		if(a> 0 && a <= (MazeSize*MazeSize))
	        		{	
	        			a = StorageArray.find(a);
	        			if(a != 0)
	        				StorageArray.union(a, e);
	        		}

	        		if(b> 0 && b <= (MazeSize*MazeSize))
	        		{
	        			b = StorageArray.find(b);
	        			if(b != 0)
	        				StorageArray.union(b, e);
	        		}

	        		if(c> 0 && c <= (MazeSize*MazeSize))
	        		{
	        			c = StorageArray.find(c);
	        			if(c != 0)
	        				StorageArray.union(c, e);
	        		}

	        		if(d> 0 && d <= (MazeSize*MazeSize))
	        		{	
	        			d = StorageArray.find(d);
	        			if(d != 0)
	        				StorageArray.union(d, e);
	        		}


	        	} //then ab c d
	        	StorageArray.getMaze(MazeSize);
	        	e = StorageArray.find(placement);
		        for(int i = 1; i <= MazeSize; i++)
		        {
		        	if(StorageArray.find(i) == e)
		        		flag1 = true;
		        }
		        if(flag1)
		        {
		        	for(int j = ((MazeSize*MazeSize) - MazeSize)+1; j < MazeSize*MazeSize; j++)
		        		if(StorageArray.find(j) == e)
		        			flag2 = true;
		        }
		        flag = flag1 && flag2;
		        if(flag)
		        {
		        	System.out.println(sum);
		        	row = -1;
		        	break;
		        }
		        flag1 = false;
		        flag2 = false;
		       
		       	//row = mazeScan.nextInt();
        	}
    	}
    if(!flag)
    	System.out.println(-1);
    //else
    	//System.out.println("-1");
	}
}