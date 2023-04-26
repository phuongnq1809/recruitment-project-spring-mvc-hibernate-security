package phuongnq.prj321x.asm2.dao;

import java.util.List;

import phuongnq.prj321x.asm2.entity.ApplyPost;
import phuongnq.prj321x.asm2.entity.FollowCompany;
import phuongnq.prj321x.asm2.entity.Recruitment;
import phuongnq.prj321x.asm2.entity.SaveJob;
import phuongnq.prj321x.asm2.entity.User;

public interface UserDAO {

	void saveUser(User theUser);

	User findUser(String email);

	User getUser(int theId);

	void saveApplyPost(ApplyPost theApplyPost);

	ApplyPost findApplyPost(Recruitment theRecruitment, User user);

	List<ApplyPost> getApplyPostsByRecruitmentId(int theRecruitmentId);

	List<ApplyPost> getApplyPostsByCompany(int companyId);

	void saveLoveJob(SaveJob theSaveJob);

	void unSaveJob(int theRecruitmentId, int theUserId);

	List<Object> getSaveJobsByUserId(int theUserId);

	SaveJob findUserSaveJob(int theRecruitmentId, int theUserId);

	List<Object> getListSaveJobsByUserId(int theUserId);

	List<Object> getSaveCompaniesByUserId(int theUserid);

	FollowCompany findUserFollowCompany(int theCompanyId, int theUserId);

	void saveFollowCompany(FollowCompany theFollowCompany);

	void unFollowCompany(int theCompanyId, int theUserId);

	List<Object> getListFollowCompanyByUserId(int theUserId);

	List<ApplyPost> getListApplyJobsByUserId(int theUserId);

	User findUserByVerificationCode(String theCode);

}
