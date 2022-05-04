import java.util.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class QSsort 
{
    public static Deque<Integer> q = new ArrayDeque<>();
    public static Deque<Integer> s = new ArrayDeque<>();

    public static void readfileBufferedReader(String filename)
    {
        BufferedReader br = null;

        try
        {	
            br = new BufferedReader(new FileReader(filename));		

            int N = Integer.parseInt(br.readLine());
            String[] data = br.readLine().split(" ", N);
            for (int i = 0; i < N; i++)
                q.add(Integer.parseInt(data[i]));
       } 
       catch (IOException ioe) 
       {
           ioe.printStackTrace();
       } 
       finally 
       {
            try 
            {
                if (br != null)
                    br.close();
            } 
	        catch (IOException ioe) 
            {
		        System.out.println("Error in closing the BufferedReader");
	        }
	    }
    }

    // The main function.
    public static void main(String args[])
    {
        // readfileScanner(args[0]);

        readfileBufferedReader(args[0]);

        if (QState.isSorted(q))
            System.out.println("empty");
        else
        {
            Solver solver = new ZQSolver();
            State initial = new QState(q, s, null, null);
            State result = solver.solve(initial);
            printSolution(result);
            System.out.println();
        }
    }

    // A recursive function to print the states from the initial to the final.
    private static void printSolution(State s)
    {
        if (s.getPrevious() != null)
        { 
            printSolution(s.getPrevious());
            System.out.print(s.getFlag());
        }
    }    
}
