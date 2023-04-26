package phuongnq.prj321x.asm2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import phuongnq.prj321x.asm2.dao.RoleDAO;
import phuongnq.prj321x.asm2.entity.Role;

@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleDAO roleDAO;

	@Override
	@Transactional
	public Role getRoleById(int theRoleId) {
		return roleDAO.getRoleById(theRoleId);
	}

	@Override
	@Transactional
	public void setUserAuthorities(String username, String roleName) {
		roleDAO.setUserAuthorities(username, roleName);
	}

}
