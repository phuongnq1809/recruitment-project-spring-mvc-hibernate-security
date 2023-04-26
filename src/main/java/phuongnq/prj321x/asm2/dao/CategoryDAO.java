package phuongnq.prj321x.asm2.dao;

import java.util.List;

import phuongnq.prj321x.asm2.entity.Category;

public interface CategoryDAO {

	Category getCategoryById(int theCategoryId);

	List<Category> getCategories();

	void saveCategory(Category theCategory);

	List<Category> getTopCategories();

}
