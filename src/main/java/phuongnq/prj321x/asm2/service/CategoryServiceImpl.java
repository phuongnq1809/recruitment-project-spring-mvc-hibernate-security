package phuongnq.prj321x.asm2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import phuongnq.prj321x.asm2.dao.CategoryDAO;
import phuongnq.prj321x.asm2.entity.Category;

@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private CategoryDAO categoryDAO;

	@Override
	@Transactional
	public Category getCategoryById(int theCategoryId) {
		return categoryDAO.getCategoryById(theCategoryId);
	}

	@Override
	@Transactional
	public List<Category> getCategories() {
		return categoryDAO.getCategories();
	}

	@Override
	@Transactional
	public void saveCategory(Category theCategory) {
		categoryDAO.saveCategory(theCategory);
		
	}

	@Override
	@Transactional
	public List<Category> getTopCategories() {
		return categoryDAO.getTopCategories();
	}

}
