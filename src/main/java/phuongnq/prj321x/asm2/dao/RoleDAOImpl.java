package phuongnq.prj321x.asm2.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import phuongnq.prj321x.asm2.entity.Authority;
import phuongnq.prj321x.asm2.entity.Role;

@Repository
public class RoleDAOImpl implements RoleDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public Role getRoleById(int theRoleId) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// now retrieve/read from database using the primary key
		Role theRole = currentSession.get(Role.class, theRoleId);
			
		return theRole;
		
	}

	@Override
	public void setUserAuthorities(String username, String roleName) {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// khoi tao cac doi tuong Authority ung voi cac quyen truy cap
		// authority1: quyen truy cap chung cho cac user
		Authority authority1 = new Authority(username, "ROLE_USERS");
		
		// authority2: phan quyen theo ung vien hoac cong ty
		Authority authority2;
		
		if(roleName.equals("Ung vien")) {
			authority2 = new Authority(username, "ROLE_UNGVIEN");
		} else {
			authority2 = new Authority(username, "ROLE_CONGTY");
		}
		
		// luu cac doi tuong vao database
		currentSession.save(authority1);
		currentSession.save(authority2);
		
//		// delte object with primary key
//		Query theQuery = 
//				currentSession.createQuery("delete from User where id=:userId");
//		theQuery.setParameter("userId", theId);
//		
//		theQuery.executeUpdate();

	}

}
