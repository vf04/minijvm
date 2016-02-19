
class H {
	
	int whileDemo(int x) {
		int a = 0;
		int b = 1;
		while (x > 0)
		{
			int temp = b;
			b = a;
			a = temp;
			x = b;
		};
		

		return b;
	}
}
