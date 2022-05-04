import java.util.*;

public interface State
{
  public boolean isFinal();

  public Collection<State> next();

  public State getPrevious();

  public String getFlag();

  public ArrayList<Integer> convert();
}
