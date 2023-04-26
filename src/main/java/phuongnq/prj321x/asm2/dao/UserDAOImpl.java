package phuongnq.prj321x.asm2.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import phuongnq.prj321x.asm2.entity.ApplyPost;
import phuongnq.prj321x.asm2.entity.Company;
import phuongnq.prj321x.asm2.entity.FollowCompany;
import phuongnq.prj321x.asm2.entity.Recruitment;
import phuongnq.prj321x.asm2.entity.SaveJob;
import phuongnq.prj321x.asm2.entity.User;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void saveUser(User theUser) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// save/update the user
		currentSession.saveOrUpdate(theUser);
	}

	@Override
	public User findUser(String email) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<User> theQuery = currentSession.createQuery("from User where email=:theEmail");
		theQuery.setParameter("theEmail", email);
		
		List<User> users = theQuery.getResultList();
		
		if(!users.isEmpty()) {
			return users.get(0);
		} else {
			return null;
		}
	}

	@Override
	public User getUser(int theId) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// now retrieve/read from database using the primary key
		User theUser = currentSession.get(User.class, theId);
				
		return theUser;
	}

	@Override
	public void saveApplyPost(ApplyPost theApplyPost) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
				
		// save/update the apply-post
		currentSession.saveOrUpdate(theApplyPost);	
	}

	@Override
	public ApplyPost findApplyPost(Recruitment theRecruitment, User user) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<ApplyPost> theQuery = currentSession.createQuery("from ApplyPost where recruitment.id=:theRecruitmentId"
				+ " and user.id=:theUserId");
		
		theQuery.setParameter("theRecruitmentId", theRecruitment.getId());
		theQuery.setParameter("theUserId", user.getId());
		
		List<ApplyPost> applyposts = theQuery.getResultList();
		
		if(!applyposts.isEmpty()) {
			return applyposts.get(0);
		} else {
			return null;
		}
	}

	@Override
	public List<ApplyPost> getApplyPostsByRecruitmentId(int theRecruitmentId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<ApplyPost> theQuery = currentSession.createQuery("from ApplyPost where recruitment.id=:theRecruitmentId");
		
		theQuery.setParameter("theRecruitmentId", theRecruitmentId);
		
		List<ApplyPost> applyposts = theQuery.getResultList();
		
		if(!applyposts.isEmpty()) {
			return applyposts;
		} else {
			return null;
		}
	}

	@Override
	public List<ApplyPost> getApplyPostsByCompany(int companyId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<ApplyPost> theQuery = currentSession.createQuery("from ApplyPost where company.id=:theCompanyId");
		
		theQuery.setParameter("theCompanyId", companyId);
		
		List<ApplyPost> applyposts = theQuery.getResultList();
		
		if(!applyposts.isEmpty()) {
			return applyposts;
		} else {
			return null;
		}
	}

	@Override
	public void saveLoveJob(SaveJob theSaveJob) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// save/update the user
		currentSession.save(theSaveJob);
		
	}

	@Override
	public void unSaveJob(int theRecruitmentId, int theUserId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// delte object
		Query theQuery = 
				currentSession.createQuery("DELETE FROM SaveJob WHERE recruitment.id=:theRecruitmentId AND user.id=:theUserId");
		theQuery.setParameter("theRecruitmentId", theRecruitmentId);
		theQuery.setParameter("theUserId", theUserId);
		
		theQuery.executeUpdate();
	}

	@Override
	public List<Object> getSaveJobsByUserId(int theUserId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<Object> theQuery = currentSession.createQuery("SELECT sj.recruitment.id FROM SaveJob sj WHERE sj.user.id=:theUserId");
		
		theQuery.setParameter("theUserId", theUserId);
		
		List<Object> savejobs = theQuery.getResultList();
		
		if(!savejobs.isEmpty()) {
			return savejobs;
		} else {
			return null;
		}
	}

	@Override
	public SaveJob findUserSaveJob(int theRecruitmentId, int theUserId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<SaveJob> theQuery = currentSession.createQuery("from SaveJob where recruitment.id=:theRecruitmentId and user.id=:theUserId");
		theQuery.setParameter("theRecruitmentId", theRecruitmentId);
		theQuery.setParameter("theUserId", theUserId);
		
		List<SaveJob> savejobs = theQuery.getResultList();
		
		if(!savejobs.isEmpty()) {
			return savejobs.get(0);
		} else {
			return null;
		}
	}

	@Override
	public List<Object> getListSaveJobsByUserId(int theUserId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<Object> theQuery = currentSession.createQuery("SELECT sj.recruitment FROM SaveJob sj WHERE sj.user.id=:theUserId");
		
		theQuery.setParameter("theUserId", theUserId);
		
		List<Object> savejobs = theQuery.getResultList();
		
		if(!savejobs.isEmpty()) {
			return savejobs;
		} else {
			return null;
		}
	}

	@Override
	public List<Object> getSaveCompaniesByUserId(int theUserid) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<Object> theQuery = currentSession.createQuery("SELECT fc.company.id FROM FollowCompany fc WHERE fc.user.id=:theUserId");
		
		theQuery.setParameter("theUserId", theUserid);
		
		List<Object> followcompanies = theQuery.getResultList();
		
		if(!followcompanies.isEmpty()) {
			return followcompanies;
		} else {
			return null;
		}
	}

	@Override
	public FollowCompany findUserFollowCompany(int theCompanyId, int theUserId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<FollowCompany> theQuery = currentSession.createQuery("from FollowCompany where company.id=:theCompanyId and user.id=:theUserId");
		theQuery.setParameter("theCompanyId", theCompanyId);
		theQuery.setParameter("theUserId", theUserId);
		
		List<FollowCompany> followcompanies = theQuery.getResultList();
		
		if(!followcompanies.isEmpty()) {
			return followcompanies.get(0);
		} else {
			return null;
		}
	}

	@Override
	public void saveFollowCompany(FollowCompany theFollowCompany) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// save/update the user
		currentSession.save(theFollowCompany);
		
	}

	@Override
	public void unFollowCompany(int theCompanyId, int theUserId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession(); 
		
		// delte object
		Query theQuery = 
				currentSession.createQuery("DELETE FROM FollowCompany WHERE company.id=:theCompanyId AND user.id=:theUserId");
		theQuery.setParameter("theCompanyId", theCompanyId);
		theQuery.setParameter("theUserId", theUserId);
		
		theQuery.executeUpdate();
		
	}

	@Override
	public List<Object> getListFollowCompanyByUserId(int theUserId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<Object> theQuery = currentSession.createQuery("SELECT fc.company FROM FollowCompany fc WHERE fc.user.id=:theUserId");
		
		theQuery.setParameter("theUserId", theUserId);
		
		List<Object> followcompanies = theQuery.getResultList();
		
		if(!followcompanies.isEmpty()) {
			return followcompanies;
		} else {
			return null;
		}
	}

	@Override
	public List<ApplyPost> getListApplyJobsByUserId(int theUserId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession(); 
		
		// create a query
		Query<ApplyPost> theQuery = currentSession.createQuery("FROM ApplyPost ap WHERE ap.user.id=:theUserId");
		
		theQuery.setParameter("theUserId", theUserId);
		
		List<ApplyPost> applyjobs = theQuery.getResultList();
		
		if(!applyjobs.isEmpty()) {
			return applyjobs;
		} else {
			return null;
		}
				
	}
	
	@Override
	public User findUserByVerificationCode(String code) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// create a query
		Query<User> theQuery = currentSession.createQuery("from User where verificationCode=:theCode");
		theQuery.setParameter("theCode", code);
		
		List<User> users = theQuery.getResultList();
		
		if(!users.isEmpty()) {
			return users.get(0);
		} else {
			return null;
		}
	}

}
