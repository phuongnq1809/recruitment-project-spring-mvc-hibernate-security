package phuongnq.prj321x.asm2.service;

import java.util.List;

import phuongnq.prj321x.asm2.entity.Recruitment;

public interface RecruitmentService {

	void saveRecruitment(Recruitment recruitment);

	List<Recruitment> getRecruitments(int companyId);

	void deleteRecruitment(int theRecruitmentId);

	Recruitment getRecruitmentById(int theRecruitmentId);

	List<Recruitment> getRecruitments();

	List<Object[]> getFeaturedJobs();

	List<Recruitment> searchJob(int typeSearch, String searchTxt);

	List<Recruitment> searchJob(String searchJob, String searchPlace);

}
