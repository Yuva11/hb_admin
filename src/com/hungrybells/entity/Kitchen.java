package com.hungrybells.entity;

public class Kitchen {
	String name;
	long id;
	public Kitchen(long id,String name){
		this.id=id;
		this.name=name;
	}
	
	public long getId(){
		return this.id;
	}
	
	public String getName(){
		return this.name;
	}
}