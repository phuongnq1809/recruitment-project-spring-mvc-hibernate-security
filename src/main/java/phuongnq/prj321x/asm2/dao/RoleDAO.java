package phuongnq.prj321x.asm2.dao;

import phuongnq.prj321x.asm2.entity.Role;

public interface RoleDAO {

	Role getRoleById(int theRoleId);

	void setUserAuthorities(String username, String roleName);

}
