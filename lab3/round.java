import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class RoundRoundAll
{
    public static int N, K, init_state[], moves[], distances[][];

    public static void readfileBufferedReader(String filename)
    {
        BufferedReader br = null;

        try
        {
            br = new BufferedReader(new FileReader(filename));
            String FirstLine = br.readLine();
            String[] data_1 = FirstLine.split(" ", 2);
            N = Integer.parseInt(data_1[0]);
            K = Integer.parseInt(data_1[1]);
            init_state = new int[K];
            String SecondLine = br.readLine();
            String[] data_2 = SecondLine.split(" ", K);
            for (int i = 0; i < K; i++)
                init_state[i] = Integer.parseInt(data_2[i]);
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

    public static int find_max(int[] arr)
    {
        int max = arr[0];

        for (int i = 1; i < arr.length; i++)
            if (arr[i] > max)
                max = arr[i];

        return max;
    }

    public static int find_min(int[] arr)
    {
        int min = arr[0];

        for (int i = 1; i < arr.length; i++)
            if (arr[i] >= 0 && arr[i] < min)
                min = arr[i];

        return min;
    }

    public static int find_sum(int[] arr)
    {
        int sum = 0;

        for (int i = 0; i < K; i++)
            sum = sum + arr[i];

        return sum;
    }

    public static void main(String args[])
    {
        readfileBufferedReader(args[0]);

        distances = new int[N][K];
        moves = new int[N];

        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < K; j++)
            {
                if (i < init_state[j])
                    distances[i][j] = N - init_state[j] + i;
                else
                    distances[i][j] = i - init_state[j];
            }
        }

        for (int i = 0; i < N; i++)
        {
            int summ = find_sum(distances[i]);
            int maxx = find_max(distances[i]);

            if (maxx <= summ - maxx + 1)
                moves[i] = summ;
            else
                moves[i] = -1;
        }

        int minn = find_min(moves);

        System.out.print(minn + " ");

        for (int i = 0; i < N; i++)
            if (moves[i] == minn)
            {
                System.out.println(i);
                break;
            }
    }
}
