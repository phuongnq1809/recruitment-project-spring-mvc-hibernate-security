package phuongnq.prj321x.asm2.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="category")
public class Category {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="category_name")
	private String categoryName;
	
	@Column(name="number_choose")
	private int numberChoose;
	
	public Category() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getNumberChoose() {
		return numberChoose;
	}

	public void setNumberChoose(int numberChoose) {
		this.numberChoose = numberChoose;
	}
	
}
