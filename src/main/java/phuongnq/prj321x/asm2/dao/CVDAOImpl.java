package phuongnq.prj321x.asm2.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import phuongnq.prj321x.asm2.entity.CV;

@Repository
public class CVDAOImpl implements CVDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public CV getCVByUserId(int theUserId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<CV> theQuery = currentSession.createQuery("from CV where user.id=:theUserId");
		theQuery.setParameter("theUserId", theUserId);
		
		List<CV> cvs = theQuery.getResultList();
		
		if(!cvs.isEmpty()) {
			return cvs.get(0);
		} else {
			return null;
		}
	}

	@Override
	public void saveCV(CV theCV) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		currentSession.saveOrUpdate(theCV);
		
	}

	@Override
	public CV getCVById(int theCVId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		CV cv = currentSession.get(CV.class, theCVId);
		
		return cv;
	}

}
