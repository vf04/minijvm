
public class C {
	B b;
	
	int getXFromB() {
		return b.x;
	}
	int callGetYFromB() {
		return b.getY();
	}
	void callSetXFromB(int x) {
		b.setX(x);
	}
	int callAddFromB(int x, int y) {
		return b.add(x, y);
	}
}
