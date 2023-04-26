package phuongnq.prj321x.asm2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import phuongnq.prj321x.asm2.dao.RecruitmentDAO;
import phuongnq.prj321x.asm2.entity.Recruitment;

@Service
public class RecruitmentServiceImpl implements RecruitmentService {
	
	@Autowired
	private RecruitmentDAO recruitmentDAO;

	@Override
	@Transactional
	public void saveRecruitment(Recruitment recruitment) {
		recruitmentDAO.saveRecruitment(recruitment);
	}

	@Override
	@Transactional
	public List<Recruitment> getRecruitments(int companyId) {
		return recruitmentDAO.getRecruitments(companyId);
	}

	@Override
	@Transactional
	public void deleteRecruitment(int theRecruitmentId) {
		recruitmentDAO.deleteRecruitment(theRecruitmentId);
		
	}

	@Override
	@Transactional
	public Recruitment getRecruitmentById(int theRecruitmentId) {
		return recruitmentDAO.getRecruitmentById(theRecruitmentId);
	}

	@Override
	@Transactional
	public List<Recruitment> getRecruitments() {
		return recruitmentDAO.getRecruitments();
	}

	@Override
	@Transactional
	public List<Object[]> getFeaturedJobs() {
		return recruitmentDAO.getFeaturedJobs();
	}

	@Override
	@Transactional
	public List<Recruitment> searchJob(int typeSearch, String searchTxt) {
		return recruitmentDAO.searchJob(typeSearch, searchTxt);
	}

	@Override
	@Transactional
	public List<Recruitment> searchJob(String searchJob, String searchPlace) {
		return recruitmentDAO.searchJob(searchJob, searchPlace);
	}

}
