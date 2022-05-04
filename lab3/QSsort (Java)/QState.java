import java.util.*;

public class QState implements State
{
    private Deque<Integer> queue;
    private Deque<Integer> stack; 
    private State previous;
    private String flag;

    public QState(Deque<Integer> q, Deque<Integer> s, State p, String f)
    {
        queue = q;
        stack = s;
        previous = p;
        flag = f;
    }

    public static Deque<Integer> Copy(Deque<Integer> q1)
    {
        Deque<Integer> q2 = new ArrayDeque<>();

        for (int item : q1)
            q2.add(item);
        return q2;
    }

    public static boolean isEqual(ArrayList<Integer> qq1, Deque<Integer> qq2)
    {
        if (qq1.size() != qq2.size())
            return false;
            
        Iterator<Integer> itq_1 = qq1.iterator();
        Iterator<Integer> itq_2 = qq2.iterator();

        while(itq_1.hasNext() && itq_2.hasNext()) 
        {
            if (itq_1.next() != itq_2.next())
                return false;
        }
        return true;
    }

    public static boolean isEqual(Deque<Integer> qq1, Deque<Integer> qq2)
    {
        if (qq1.size() != qq2.size())
            return false;
            
        Iterator<Integer> itq_1 = qq1.iterator();
        Iterator<Integer> itq_2 = qq2.iterator();

        while(itq_1.hasNext() && itq_2.hasNext()) 
        {
            if (itq_1.next() != itq_2.next())
                return false;
        }
        return true;
    }

    public static boolean isSorted(Deque<Integer> qq)
    {
        Iterator<Integer> it = qq.iterator();

        if (!it.hasNext())
            return false;
        
        int previous = it.next();

        while (it.hasNext())
        {    
            int current = it.next();
            if (current < previous)
                return false;
            previous = current;   
        }
        return true;
    }

    public static ArrayList<ArrayList<Integer>> split(ArrayList<Integer> x)
    {
        ArrayList<ArrayList<Integer>> foo = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> foo1 = new ArrayList<>();
        ArrayList<Integer> foo2 = new ArrayList<>();
        boolean found = false;

        for (int item : x)
        {
            if (item == -1)
            {
                foo.add(foo1);
                found = true;
            }
            else
            {
                if (!found)
                    foo1.add(item);
                else
                    foo2.add(item);
            }
        }
        foo.add(foo2);

        return foo;
    }

    @Override
    public ArrayList<Integer> convert()
    {
        ArrayList<Integer> helpy = new ArrayList<>();

        for (int item : queue)
            helpy.add(item);
        helpy.add(-1);
        for (int item : stack)
            helpy.add(item);

        return helpy;
    }

    @Override
    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("queue = ").append(queue);
        sb.append(", stack = ").append(stack);
        return sb.toString();
    } 

    @Override
    public boolean isFinal()
    {
        if (queue.size() != QSsort.q.size())
            return false;
        return isSorted(queue);
    }

    @Override
    public Collection<State> next()
    {
        Collection<State> states = new ArrayList<>();

        // move from queue to stack (Q)
        if (!queue.isEmpty())
        {
            Deque<Integer> myQueue = Copy(queue);
            Deque<Integer> myStack = Copy(stack);

            myStack.push(myQueue.remove());
            states.add(new QState(myQueue, myStack, this, "Q"));
        }

        // move from stack to queue (S)
        if (!stack.isEmpty())
        {
            if (stack.peek() != queue.peek())
            {
                Deque<Integer> myQueue = Copy(queue);
                Deque<Integer> myStack = Copy(stack);

                myQueue.add(myStack.pop());
                states.add(new QState(myQueue, myStack, this, "S"));
            }
        }
        return states;
    }

    @Override
    public State getPrevious()
    {
        return previous;
    }

    @Override
    public String getFlag()
    {
        return flag;
    }

    @Override
    public boolean equals(Object o)
    {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        ArrayList<Integer> other = (ArrayList<Integer>) o;
        ArrayList<ArrayList<Integer>> listOfLists = split(other);
        return isEqual(listOfLists.get(0), queue) && isEqual(listOfLists.get(1), stack);

    }

    @Override
    public int hashCode()
    {
        return Objects.hash(queue, stack);
    }
}
