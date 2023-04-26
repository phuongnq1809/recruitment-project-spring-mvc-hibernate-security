package phuongnq.prj321x.asm2.service;

import phuongnq.prj321x.asm2.entity.Role;

public interface RoleService {

	Role getRoleById(int theRoleId);
	
	void setUserAuthorities(String username, String roleName);

}
