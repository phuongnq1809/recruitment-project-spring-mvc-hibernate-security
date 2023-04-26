package phuongnq.prj321x.asm2.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import phuongnq.prj321x.asm2.dao.CompanyDAO;
import phuongnq.prj321x.asm2.dao.UserDAO;
import phuongnq.prj321x.asm2.entity.ApplyPost;
import phuongnq.prj321x.asm2.entity.FollowCompany;
import phuongnq.prj321x.asm2.entity.Recruitment;
import phuongnq.prj321x.asm2.entity.SaveJob;
import phuongnq.prj321x.asm2.entity.User;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private JavaMailSender mailSender;

	@Override
	@Transactional
	public void saveUser(User theUser) {
		userDAO.saveUser(theUser);		
	}

	@Override
	@Transactional
	public User findUser(String email) {
		return userDAO.findUser(email);
	}

	@Override
	@Transactional
	public User getUser(int theId) {
		return userDAO.getUser(theId);
	}

	@Override
	@Transactional
	public void saveApplyPost(ApplyPost theApplyPost) {
		userDAO.saveApplyPost(theApplyPost);
		
	}

	@Override
	@Transactional
	public ApplyPost findApplyPost(Recruitment theRecruitment, User user) {
		return userDAO.findApplyPost(theRecruitment, user);
	}

	@Override
	@Transactional
	public List<ApplyPost> getApplyPostsByRecruitmentId(int theRecruitmentId) {
		return userDAO.getApplyPostsByRecruitmentId(theRecruitmentId);
	}

	@Override
	@Transactional
	public List<ApplyPost> getApplyPostsByCompany(int companyId) {
		return userDAO.getApplyPostsByCompany(companyId);
	}

	@Override
	@Transactional
	public void saveLoveJob(SaveJob theSaveJob) {
		userDAO.saveLoveJob(theSaveJob);
		
	}

	@Override
	@Transactional
	public void unSaveJob(int theRecruitmentId, int theUserId) {
		userDAO.unSaveJob(theRecruitmentId, theUserId);
		
	}

	@Override
	@Transactional
	public List<Object> getSaveJobsByUserId(int theUserId) {
		return userDAO.getSaveJobsByUserId(theUserId);
	}

	@Override
	@Transactional
	public SaveJob findUserSaveJob(int theRecruitmentId, int theUserId) {
		return userDAO.findUserSaveJob(theRecruitmentId, theUserId);
	}

	@Override
	@Transactional
	public List<Object> getListSaveJobsByUserId(int theUserId) {
		return userDAO.getListSaveJobsByUserId(theUserId);
	}

	@Override
	@Transactional
	public List<Object> getSaveCompaniesByUserId(int theUserid) {
		return userDAO.getSaveCompaniesByUserId(theUserid);
	}

	@Override
	@Transactional
	public FollowCompany findUserFollowCompany(int theCompanyId, int theUserId) {
		return userDAO.findUserFollowCompany(theCompanyId, theUserId);
	}

	@Override
	@Transactional
	public void saveFollowCompany(FollowCompany theFollowCompany) {
		userDAO.saveFollowCompany(theFollowCompany);
		
	}

	@Override
	@Transactional
	public void unFollowCompany(int theCompanyId, int theUserId) {
		userDAO.unFollowCompany(theCompanyId, theUserId);
		
	}

	@Override
	@Transactional
	public List<Object> getListFollowCompanyByUserId(int theUserId) {
		return userDAO.getListFollowCompanyByUserId(theUserId);
	}

	@Override
	@Transactional
	public List<ApplyPost> getListApplyJobsByUserId(int theUserId) {
		return userDAO.getListApplyJobsByUserId(theUserId);
	}

	@Override
	public void sendVerificationEmail(User theUser, String siteURL) throws MessagingException, UnsupportedEncodingException{
		
		String toAddress = theUser.getEmail();
	    String fromAddress = "quangphuongfunix@gmail.com";
	    String senderName = "QP Works";
	    String subject = "Please verify your registration at QP Works";
	    String content = "Dear [[name]],<br>"
	            + "Please click the link below to verify your registration as an employer:<br>"
	            + "<h3><a href=\"[[URL]]\" target=\"_blank\">VERIFY LINK</a></h3>"
	            + "Thanks & Best Regard,<br>"
	            + "QP Works.";
	     
	    MimeMessage message = mailSender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message);
	     
	    helper.setFrom(fromAddress, senderName);
	    helper.setTo(toAddress);
	    helper.setSubject(subject);
	     
	    content = content.replace("[[name]]", theUser.getFullName());
	    String verifyURL = siteURL + "/verifyAccount?code=" + theUser.getVerificationCode();
	     
	    content = content.replace("[[URL]]", verifyURL);
	     
	    helper.setText(content, true);
	     
	    mailSender.send(message);
	}

	@Override
	@Transactional
	public User findUserByVerificationCode(String theCode) {
		return userDAO.findUserByVerificationCode(theCode);
	}

}
