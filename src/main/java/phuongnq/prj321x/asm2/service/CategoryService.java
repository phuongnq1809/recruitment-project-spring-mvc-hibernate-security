package phuongnq.prj321x.asm2.service;

import java.util.List;

import phuongnq.prj321x.asm2.entity.Category;

public interface CategoryService {

	Category getCategoryById(int theCategoryId);

	List<Category> getCategories();

	void saveCategory(Category theCategory);

	List<Category> getTopCategories();

}
