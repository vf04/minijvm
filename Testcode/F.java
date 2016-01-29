
public class F {
	G myG;
	
	F getF() {
		return myG.getE().getF();
	}
	
	G getG() {
		return myG;
	}
}
