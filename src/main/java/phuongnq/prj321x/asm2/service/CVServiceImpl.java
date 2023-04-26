package phuongnq.prj321x.asm2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import phuongnq.prj321x.asm2.dao.CVDAO;
import phuongnq.prj321x.asm2.entity.CV;

@Service
public class CVServiceImpl implements CVService {
	
	@Autowired
	private CVDAO cvDAO;

	@Override
	@Transactional
	public CV getCVByUserId(int theUserId) {
		return cvDAO.getCVByUserId(theUserId);
	}

	@Override
	@Transactional
	public void saveCV(CV theCV) {
		cvDAO.saveCV(theCV);
		
	}

	@Override
	@Transactional
	public CV getCVById(int theCVId) {
		return cvDAO.getCVById(theCVId);
	}

}
