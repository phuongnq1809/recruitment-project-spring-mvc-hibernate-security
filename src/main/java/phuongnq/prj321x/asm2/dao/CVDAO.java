package phuongnq.prj321x.asm2.dao;

import phuongnq.prj321x.asm2.entity.CV;

public interface CVDAO {

	CV getCVByUserId(int theUserId);

	void saveCV(CV theCV);

	CV getCVById(int theCVId);

}
