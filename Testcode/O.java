
class O {

	int x;
	
	O(int x) {
		this.x = x;
	}
	
	O test() {
		int a;
		{
			int i = 40;
			a = i;
		}
		{
			int i = a+2;
			return new O(i);
		}
	}
}
