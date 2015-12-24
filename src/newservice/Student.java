package newservice;

public class Student {
	
	String name;
	String roll;
	String marks;

	public Student(String name,String roll,String marks)
	{
		this.name=name;
		this.roll=roll;
		this.marks=marks;
		// TODO Auto-generated constructor stub
	}
	
		public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoll() {
		return roll;
	}
	public void setRoll(String roll) {
		this.roll = roll;
	}
	public String getMarks() {
		return marks;
	}
	public void setMarks(String marks) {
		this.marks = marks;
	}
	
}
