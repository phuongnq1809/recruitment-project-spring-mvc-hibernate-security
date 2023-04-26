package phuongnq.prj321x.asm2.service;

import phuongnq.prj321x.asm2.entity.CV;

public interface CVService {

	CV getCVByUserId(int theUserId);

	void saveCV(CV theCV);

	CV getCVById(int theCVId);

}
