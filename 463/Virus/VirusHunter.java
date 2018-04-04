import java.io.*;
import java.util.*;


public class VirusHunter {
	public class Edge
	{
		private String ChildStrain;
		private String Connection;
		public Edge(String virus, String type)
		{
			ChildStrain = virus;
			Connection = type;	
		}
		public String format()
		{
			return Connection;
		}
		public String Name()
		{
			return ChildStrain;
		}
		@Override
		public String toString()
		{
			return ChildStrain;
		}
	}

	private Map<String, List<Edge>> DerivedStrains = new HashMap<String, List<Edge>>();
	private Map<String, Integer> Editing = new HashMap<String, Integer>(); 

	public void commit(String s1, String s2, String assignment)
	{
		this.add(s1);
		this.add(s2);
		DerivedStrains.get(s1).add(new Edge(s2, assignment));
	}

	public void add(String s1) 
	{
        if (DerivedStrains.containsKey(s1))
            return;
        DerivedStrains.put(s1, new ArrayList<Edge>());
   	}

   	public void print()
   	{
   		int counter = 0;
   		String[] Array = new String[DerivedStrains.size()];
   		for(String v: DerivedStrains.keySet())
   		{
   			Array[counter] = v;
   			counter++;
   		}
   		Arrays.sort(Array);
   		for(int f = 0; f < Array.length; f++)
   		{
   			System.out.println(Array[f]);
   		}
   		//System.out.print(Array[]);
   	}

   	public void delete()
   	{
   		String flag = "";
   		for(String v: DerivedStrains.keySet())
   		{
   			List<Edge> temp = DerivedStrains.get(v);
   			for(int k = 0; k < temp.size(); k++)
   			{
   				//System.out.println(temp.get(k).format());
   				if(temp.get(k).format().equals("->"))
   				{
   					flag += temp.get(k).Name() + " " + edit(temp.get(k).Name());
   				}
   			}
   			//System.out.println(v);
   		}
   		//System.out.println(flag);
   		String[] deletion = flag.split(" ");
   		for(int l = 0; l < deletion.length; l++)
   		{
   			DerivedStrains.remove(deletion[l]);
   		}
   	}

   	public String edit(String v)
   	{
   		String temp2 = "";
   		List<Edge> temp3 = DerivedStrains.get(v);
   		if(temp3.isEmpty())
   		{
   			return (v + " ");
   		}
   		else
   		{
   			for(int m = 0; m < temp3.size(); m++)
   			{
   				if(!Editing.containsKey(temp3.get(m).Name()))
   				{
   					Editing.put(temp3.get(m).Name(), 5);
   					temp2 += " " + temp3.get(m).Name()+ edit(temp3.get(m).Name()) + " ";
   				}
   			}
   		}
   		return temp2;
   	}
    public static void main(String[] args) throws IOException{
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        //System.setIn(new FileInputStream(new File("input.txt")));
        Scanner Virus = new Scanner(System.in);
        int E = Virus.nextInt();
        //System.out.print(E+"\n");
        String Strain1[];
        Strain1 = new String[E];
        String Assign[];
        Assign = new String[E];
        String Strain2[];
        Strain2 = new String[E];

        VirusHunter viruses = new VirusHunter();
        for(int i = 0; i < E; i++)
        {
        	Strain1[i] = Virus.next();
        	Assign[i] = Virus.next();
        	Strain2[i] = Virus.next();
        	if(Assign[i].equals("->"))
        	{
        		viruses.commit(Strain1[i], Strain2[i], Assign[i]);
        	}
        	if(Assign[i].equals("?"))
        	{
        		viruses.commit(Strain1[i], Strain2[i], Assign[i]);
        		viruses.commit(Strain2[i], Strain1[i], Assign[i]);
        	}
        }

    	//viruses.print();
    	viruses.delete();
    	viruses.print();
       	/*for(int j = 0; j < E; j++)
       	{
       		System.out.print(Strain1[j]+ " "+ Assign[j]+ " "+ Strain2[j]+ "\n");
       	}*/
    }
}