package phuongnq.prj321x.asm2.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import phuongnq.prj321x.asm2.entity.Recruitment;

@Repository
public class RecruitmentDAOImpl implements RecruitmentDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void saveRecruitment(Recruitment recruitment) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		currentSession.saveOrUpdate(recruitment);
		
	}

	@Override
	public List<Recruitment> getRecruitments(int companyId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query<Recruitment> theQuery = currentSession.createQuery("from Recruitment where company.id=:theId and status=1");
		theQuery.setParameter("theId", companyId);
		
		List<Recruitment> recruitments = theQuery.getResultList();
		
		return recruitments;
	}

	@Override
	public void deleteRecruitment(int theRecruitmentId) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// delte object with primary key
		Query theQuery = 
				currentSession.createQuery("update Recruitment set status=0 where id=:recruitmentId");
		theQuery.setParameter("recruitmentId", theRecruitmentId);
		
		theQuery.executeUpdate();
		
	}

	@Override
	public Recruitment getRecruitmentById(int theRecruitmentId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		Recruitment recruitment = currentSession.get(Recruitment.class, theRecruitmentId);
		
		return recruitment;
	}

	@Override
	public List<Recruitment> getRecruitments() {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query<Recruitment> theQuery = currentSession.createQuery("from Recruitment where status=1");
		
		List<Recruitment> recruitments = theQuery.getResultList();
		
		return recruitments;
		
	}

	@Override
	public List<Object[]> getFeaturedJobs() {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// viec lam noi bat voi luot ung tuyen nhieu
		Query<Object[]> theQuery = currentSession.createQuery("SELECT ap.recruitment, COUNT(*) FROM ApplyPost ap GROUP BY ap.recruitment ORDER BY COUNT(*) DESC");
		theQuery.setMaxResults(2); // so luong viec lam noi bat hien thi o trang chu
		
		List<Object[]> result = theQuery.getResultList();
		
		return result;
	}

	@Override
	public List<Recruitment> searchJob(int typeSearch, String searchTxt) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		String query = "";
		
		if(typeSearch == 1) {
			
			query = "FROM Recruitment as rc WHERE (rc.title LIKE:searchTxt"
					+ " OR rc.company.companyName LIKE:searchTxt"
					+ " OR rc.category.categoryName LIKE:searchTxt)"
					+ " AND rc.status=1";
			
		} else if(typeSearch == 2) {
			
			query = "FROM Recruitment as rc WHERE rc.address LIKE:searchTxt AND rc.status=1";
		}
		
		Query<Recruitment> theQuery = currentSession.createQuery(query);
		theQuery.setParameter("searchTxt", "%" + searchTxt + "%");
		
		List<Recruitment> result = theQuery.getResultList();
		
		return result;
				
	}

	@Override
	public List<Recruitment> searchJob(String searchJob, String searchPlace) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		String query = "FROM Recruitment as rc WHERE rc.title LIKE:searchJob"
					 + " AND rc.address LIKE:searchPlace AND rc.status=1";
		
		Query<Recruitment> theQuery = currentSession.createQuery(query);
		theQuery.setParameter("searchJob", "%" + searchJob + "%");
		theQuery.setParameter("searchPlace", "%" + searchPlace + "%");
		
		List<Recruitment> result = theQuery.getResultList();
		
		return result;
	}

}
