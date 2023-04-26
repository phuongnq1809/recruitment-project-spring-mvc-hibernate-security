package phuongnq.prj321x.asm2.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import phuongnq.prj321x.asm2.entity.Category;

@Repository
public class CategoryDAOImpl implements CategoryDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public Category getCategoryById(int theCategoryId) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		Category category = currentSession.get(Category.class, theCategoryId);
		
		return category;
	}

	@Override
	public List<Category> getCategories() {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<Category> theQuery = currentSession.createQuery("from Category");
		
		List<Category> categories = theQuery.getResultList();
		
		return categories;
	}

	@Override
	public void saveCategory(Category theCategory) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		currentSession.saveOrUpdate(theCategory);
		
	}

	@Override
	public List<Category> getTopCategories() {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// top danh muc co nhieu bai tuyen dung
		Query<Category> theQuery = currentSession.createQuery("FROM Category ORDER BY numberChoose DESC");
		theQuery.setMaxResults(4); // so luong top danh muc hien thi o trang chu
		
		List<Category> result = theQuery.getResultList();
		
		return result;
	}

}
