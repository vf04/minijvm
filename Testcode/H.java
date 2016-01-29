
public class H {
	
	int fibonacciIter(int x) {
		int a = 0;
		int b = 1;
		
		while (x > 0)
		{
			int temp = b;
			b = a+b;
			a = temp;
			x--;
		}
		
		return b;
	}
	
	static int fibonacciRec(int x) {
		if (x <= 0 || x == 1)
			return 1;
		return fibonacciRec(x-2)+fibonacciRec(x-1);
	}
	
}
