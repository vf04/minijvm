
class B {

	int x;
	int y;
	
	int getX() {
		return x;
	}
	
	int getY() {
		return y;
	}
	
	void setX(int i) {
		x = i;
	}
	
	void setY(int i) {
		this.y = i;
	}
	
	int addXY() {
		return x + y;
	}
	
	int add(int a, int b) {
		return a*b;
	}
  int div(int a, int b){
  return a / b;
  }
  
  int calc(int x){
    return 5 % 2 + 2 * x;
  }


}
