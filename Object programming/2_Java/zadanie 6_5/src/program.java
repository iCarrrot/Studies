
public class program {

	public static void main(String[] args) {
		int[] T = {4,2,1,5,6,3};

        MergeSort sort = new MergeSort(T, 0, 6); sort.start();
        
        try
        {
        	sort.join();
        }
        catch(Exception e) {}

        for(int i = 0; i < 6; i++) System.out.println(T[i]);

	}

}
