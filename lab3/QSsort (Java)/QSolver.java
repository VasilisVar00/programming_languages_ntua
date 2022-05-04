import java.util.*;

public class ZQSolver implements Solver
{
    @Override
    public State solve (State initial)
    {
        Set<ArrayList<Integer>> seen = new HashSet<>();
        Queue<State> remaining = new ArrayDeque<>();
        remaining.add(initial);
        seen.add(initial.convert());
        while (!remaining.isEmpty())
        {
            State s = remaining.remove();
            //System.out.print("Current state: ");
            //System.out.println(s);
            if (s.isFinal()) 
                return s;
            for (State n : s.next())
            {
                //System.out.print("Next state: ");
                //System.out.println(n);
                if (!seen.contains(n.convert()))
                {
                    remaining.add(n);
                    seen.add(n.convert());
                }
            }
        }
        return null;
    }
}
