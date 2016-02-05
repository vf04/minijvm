
class G {
	E myE;
	
	E getE() {
		return myE;
	}
		
	G getG() {
		return myE.getF().getG();
	}
}
