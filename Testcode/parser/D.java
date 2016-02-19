
class D {
  int x;
  
	D getThis() {
		return this;
	}
	C getNewC() {
		C newC = new C();
		return newC;
	}
}
