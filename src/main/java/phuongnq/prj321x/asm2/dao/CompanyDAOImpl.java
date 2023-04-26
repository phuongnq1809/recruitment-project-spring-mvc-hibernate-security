package phuongnq.prj321x.asm2.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import phuongnq.prj321x.asm2.entity.Company;
import phuongnq.prj321x.asm2.entity.Recruitment;

@Repository
public class CompanyDAOImpl implements CompanyDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void saveCompany(Company company) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		currentSession.saveOrUpdate(company);
				
	}

	@Override
	public Company getCompanyByUserId(int userId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<Company> theQuery = currentSession.createQuery("from Company where user.id=:theUserId");
		theQuery.setParameter("theUserId", userId);
		
		List<Company> companies = theQuery.getResultList();
		
		if(!companies.isEmpty()) {
			return companies.get(0);
		} else {
			return null;
		}
	}

	@Override
	public Company getCompanyById(int companyId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		Company theCompany = currentSession.get(Company.class, companyId);
		
		return theCompany;
	}

	@Override
	public List<Object[]> getFeaturedCompanies() {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// cong ty noi bat voi luot ung tuyen nhieu
		Query<Object[]> theQuery = currentSession.createQuery("SELECT ap.company, COUNT(*) FROM ApplyPost ap GROUP BY ap.company ORDER BY COUNT(*) DESC");
		theQuery.setMaxResults(1); // so luong cong ty noi bat hien thi o trang chu
		
		List<Object[]> result = theQuery.getResultList();
		
		return result;
	}

	@Override
	public List<Company> getListCompanies() {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query<Company> theQuery = currentSession.createQuery("from Company where status=1");
		
		List<Company> recruitments = theQuery.getResultList();
		
		return recruitments;
	}

}
