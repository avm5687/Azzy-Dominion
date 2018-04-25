import java.io.*;
import java.util.*;
public class MazeRunner
{
    public static class Disjoint
    {
        //Scanner mazeScan = new Scanner(System.in);
        public int[] Maze;
        public Disjoint(int x)
        {
            Maze = new int[x*x+5];
            //Maze[x*x+1] = -1;
            //Maze[x*x+2] = -1;
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
            {
                Maze[x] = -1;
            }
        }
        public int find(int x)
        {
            CheckIndex(x);
            if (Maze[x] == 0)
                return 0;
            if(Maze[x] < 0)
                return x;
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
                return;
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
    }
    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        Scanner mazeScan = new Scanner(System.in);
        int  MazeSize = mazeScan.nextInt();
        int row = 0;
        int column = 0;
        int placement = 0;
        int a, b, c, d, e, f, g, sum = 0;
        Disjoint StorageArray = new Disjoint(MazeSize);
        //int[] placementA;
        int count = 0;
        row = 1;
        int begin = (MazeSize*MazeSize+1);
        int end = (MazeSize*MazeSize+2);
        StorageArray.CreateSet(begin);
        StorageArray.CreateSet(end);
        boolean flag = false;
        while (row > 0)
        {
            //while(!flag)
            //{ 
                row = mazeScan.nextInt();
                if(row == -1)
                    break;
                column = mazeScan.nextInt();
                placement = MazeSize * (row - 1) + column;
                //placementA[placement] = placement;
                StorageArray.CreateSet(placement);
                sum++;
                e=StorageArray.find(placement);
                f = StorageArray.find(begin);
                g = StorageArray.find(end);
                if(placement <= MazeSize)
                    StorageArray.union(placement, f);
                if(placement >= ((MazeSize*MazeSize)-MazeSize)+1)
                    StorageArray.union(placement, g);
                a=placement-1; //left
                b=placement+1; //right
                c=placement-MazeSize; //down
                d=placement+MazeSize; //up
                //System.out.println((placement%MazeSize) + "Where");
                if((placement%MazeSize) == 0) //right side
                {
                    if(a > 0 && a <= (MazeSize*MazeSize))
                    {   
                        a = StorageArray.find(a);
                        if(a != 0)
                            StorageArray.union(a, e);
                    }
                    if(d> 0 && d <= (MazeSize*MazeSize))
                    {   
                        d = StorageArray.find(d);
                        if(d != 0)
                            StorageArray.union(d, e);
                    }
                    if(c > 0 && c <= (MazeSize*MazeSize))
                    {
                        c = StorageArray.find(c);
                        if(c != 0)
                            StorageArray.union(c, e);
                    }
                    if(d > (MazeSize*MazeSize))
                    {
                        StorageArray.union(g, e);
                    }
                    if(c < 0)
                    {
                        StorageArray.union(f, e);
                    }
                    //e=StorageArray.find(placement);
                }
                if((placement%MazeSize) == 1) //left side
                {   
                    if(d > 0 && d <= (MazeSize*MazeSize))
                    {   
                        d = StorageArray.find(d);
                        if(d != 0)
                            StorageArray.union(d, e);
                    }
                    if(b > 0 && b <= (MazeSize*MazeSize))
                    {
                        b = StorageArray.find(b);
                    }
                    if(c > 0 && c <= (MazeSize*MazeSize))
                    {
                        c = StorageArray.find(c);
                        if(c != 0)
                            StorageArray.union(c, e);
                    }
                    if(d > (MazeSize*MazeSize))
                    {
                        StorageArray.union(g, e);
                    }
                    if(c < 0)
                    {
                        StorageArray.union(f, e);
                    }
                } //then ab c d
                else
                {
                    if(a > 0 && a <= (MazeSize*MazeSize))
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
                    if(d > 0 && d <= (MazeSize*MazeSize))
                    {   
                        d = StorageArray.find(d);
                        if(d != 0)
                            StorageArray.union(d, e);
                    }
                    if(d > (MazeSize*MazeSize))
                    {
                        StorageArray.union(g, e);
                    }
                    if(c < 0)
                    {
                        StorageArray.union(f, e);
                    }
                }
                if(StorageArray.find(begin) == StorageArray.find(end))
                {
                    flag =true;
                    row = -1;
                }
                //}
        }//true one
        if(flag == false)
            System.out.println(-1);
        else
            System.out.println(sum);
    }
}
