/*
* User Controller
*/
package phuongnq.prj321x.asm2.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import phuongnq.prj321x.asm2.entity.ApplyPost;
import phuongnq.prj321x.asm2.entity.CV;
import phuongnq.prj321x.asm2.entity.Company;
import phuongnq.prj321x.asm2.entity.FollowCompany;
import phuongnq.prj321x.asm2.entity.Recruitment;
import phuongnq.prj321x.asm2.entity.SaveJob;
import phuongnq.prj321x.asm2.entity.User;
import phuongnq.prj321x.asm2.service.CVService;
import phuongnq.prj321x.asm2.service.CompanyService;
import phuongnq.prj321x.asm2.service.RecruitmentService;
import phuongnq.prj321x.asm2.service.UserService;

@Controller
@RequestMapping("/candidate")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CVService cvService;
	
	@Autowired
	private RecruitmentService recruitmentService;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private ServletContext servletContext;
	
	// show form cap nhat thong tin user
	@RequestMapping("/updateProfile")
	public String updateProfile(@RequestParam("userId") int theUserId, Model theModel) {
		
		User theUser = userService.getUser(theUserId);
		theModel.addAttribute("userCandidate", theUser);
		
		// get ve doi tuong CV tuong ung voi user id
		CV theCV = cvService.getCVByUserId(theUserId);
		theModel.addAttribute("userCV", theCV);
		
		return "candidate/profile";
		
	}
	
	// ham upload file len server (project localhost)
	private void uploadFile(CommonsMultipartFile file) {
		try {
			
			byte[] data = file.getBytes();
			
			// create directory to store files
			String rootPath = servletContext.getRealPath("/")
					 + "resources" + File.separator + "img-upload";
			File dir = new File(rootPath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			// create the file on server
			File serverFile = new File(dir.getAbsolutePath() + File.separator + file.getOriginalFilename());
			
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			stream.write(data);
			stream.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	// ham upload file len server (project localhost)
	private void uploadCVFile(CommonsMultipartFile file) {
		try {
			
			byte[] data = file.getBytes();
			
			// create directory to store files
			String rootPath = servletContext.getRealPath("/")
					 + "resources" + File.separator + "cv-upload";
			File dir = new File(rootPath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			// create the file on server
			File serverFile = new File(dir.getAbsolutePath() + File.separator + file.getOriginalFilename());
			
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			stream.write(data);
			stream.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	// xu ly cap nhat thong tin ca nhan
	@PostMapping(value="/updateProfileProcess", produces = "text/html;charset=UTF-8")
	public String updateProfileProcess(@RequestParam("userId") int theUserId,
									   @RequestParam("imgProfile") CommonsMultipartFile imgFile,
									   @RequestParam("email") String theUserEmail,
									   @RequestParam("name") String theUserName,
									   @RequestParam("address") String theUserAddress,
									   @RequestParam("phone") String theUserPhone,
									   @RequestParam("userdesc") String theUserdesc,
									   @RequestParam("userCV") CommonsMultipartFile cvFile) {
		
		// THONG TIN CA NHAN
		// get doi tuong User dang cap nhat
		User theUser = userService.getUser(theUserId);
		
		// ten file anh dai dien
		String imgProfile = "";
		
		// Neu co thay doi anh dai dien
		if(!imgFile.isEmpty()) {
			
			uploadFile(imgFile);
			imgProfile = imgFile.getOriginalFilename();
			
		}
		
		theUser.setEmail(theUserEmail);
		theUser.setFullName(theUserName);
		theUser.setAddress(theUserAddress);
		theUser.setPhoneNumber(theUserPhone);
		theUser.setDescription(theUserdesc);
		
		if(!imgProfile.equals("")) {
			theUser.setImage(imgProfile);
		}
		
		// THONG TIN CV
		// ten file CV
		String CVFileName = "";
		
		// Neu co chon file CV pdf
		if(!cvFile.isEmpty()) {
			
			uploadCVFile(cvFile);
			CVFileName = cvFile.getOriginalFilename();
			
		}
		
		// get ve doi tuong CV tuong ung voi user id
		CV theCV = cvService.getCVByUserId(theUserId);
		
		if(theCV == null) {
			theCV = new CV(CVFileName, theUser);
		} else {
			theCV.setFileName(CVFileName);
		}
		
		// luu thong tin vao database
		userService.saveUser(theUser);
		cvService.saveCV(theCV);

		return "candidate/update-profile-success";
		
	}
	
	// show danh sach tat ca cac viec lam hien co
	@RequestMapping("/allJobs")
	public String allJobs(@RequestParam("userId") int theUserId, Model theModel) {
		
		// get ve danh sach tat ca tin tuyen dung
		List<Recruitment> theRecruitments = recruitmentService.getRecruitments();
		
		// get ve danh sach tin tuyen dung da luu ung voi user
		List<Object> userSaveJobs = userService.getSaveJobsByUserId(theUserId);
		
		// get ve CV tuong ung voi User
		CV theUserCV = cvService.getCVByUserId(theUserId);
		
		theModel.addAttribute("listRecruitments", theRecruitments);
		theModel.addAttribute("userCV", theUserCV);
		theModel.addAttribute("userSaveJobs", userSaveJobs);
		
		return "candidate/list-recruitments";
	}
	
	// xu ly viec user apply job
	@PostMapping("/applyJobProcess")
	public String applyJobProcess(@RequestParam("recruitmentId") int theRecruitmentId,
								  @RequestParam("userId") int theUserId,
								  @RequestParam("cvId") int theCVId,
								  @RequestParam("typeCVSelect") String typeCV,
								  @RequestParam("selectCV") CommonsMultipartFile selectCVFile,
								  @RequestParam("intro") String theIntro,
								  Model theModel) {
		
		// get ve doi tuong Recruitment
		Recruitment theRecruitment = recruitmentService.getRecruitmentById(theRecruitmentId);
		
		// get ve User tuong ung
		User user = userService.getUser(theUserId);
		
		String theCVFileName = "";
		
		// dung CV da cap nhat
		if(typeCV.equals("updatedCV")) {
			
			CV theCV = cvService.getCVById(theCVId);
			theCVFileName = theCV.getFileName();
		
		// nop CV moi
		} else if(typeCV.equals("newCV") && (!selectCVFile.isEmpty())) {
			
			uploadCVFile(selectCVFile); // upload file
			theCVFileName = selectCVFile.getOriginalFilename();
			
		}
		
		// kiem tra xem user da ung tuyen vao vi tri va nop cv hay chua
		ApplyPost applyPostFound = userService.findApplyPost(theRecruitment, user);
		
		if(applyPostFound == null) {
			
			String currentDate = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(Calendar.getInstance().getTime());
			
			// khoi tao doi tuong ApplyPost - user ung tuyen vao 1 vi tri tuyen dung
			ApplyPost theApplyPost = new ApplyPost(theRecruitment, theRecruitment.getCompany(), user, theCVFileName, theIntro, currentDate, 1);
			
			// luu thong tin vao database
			userService.saveApplyPost(theApplyPost);
			
			theModel.addAttribute("applypost", theApplyPost);
			
		} else {
			
			String msg = "Bạn đã ứng tuyển vào vị trí này trước đó, vui lòng chờ hồi đáp từ công ty hoặc liên hệ với bộ phận tuyển dụng, many thanks!";
			theModel.addAttribute("msg_failure", msg);
			
		}
		
		return "candidate/apply-job-result";
		
	}
	
	// luu theo doi cong viec
	@RequestMapping("/saveJob")
	public String saveJob(@RequestParam("recruitmentId") int theRecruitmentId,
						  @RequestParam("userId") int theUserId,
						  Model theModel) {
		
		
		
		// kiem tra xem user da luu tin truoc do hay chua
		SaveJob userSaveJob = userService.findUserSaveJob(theRecruitmentId, theUserId);
		
		String msgAlert = "";
		
		if(userSaveJob == null) {
			
			Recruitment recruitment = recruitmentService.getRecruitmentById(theRecruitmentId);
			User user = userService.getUser(theUserId);
			
			SaveJob theSaveJob = new SaveJob(recruitment, user);
			userService.saveLoveJob(theSaveJob);
			
			msgAlert = "Bạn đã lưu theo dõi công việc này thành công!";
			
		} else {
			msgAlert = "Bạn đã lưu tin này trước đó!";
		}
		
		theModel.addAttribute("msgAlert", msgAlert);
		return "candidate/save-job-notification";
	}
	
	// bo luu theo doi cong viec
	@RequestMapping("/unSaveJob")
	public String unSaveJob(@RequestParam("recruitmentId") int theRecruitmentId,
						    @RequestParam("userId") int theUserId) {
		
		userService.unSaveJob(theRecruitmentId, theUserId);
		
		return "candidate/unsave-job-success";
	}
	
	// danh sach cong viec da luu
	@RequestMapping("/listSaveJobs")
	public String listSaveJobs(@RequestParam("userId") int theUserId, Model theModel) {
		
		// get ve danh sach tin tuyen dung da luu ung voi user (candidate)
		List<Object> theListSaveJobs = userService.getListSaveJobsByUserId(theUserId);
		
		// cv ma user da cap nhat
		CV theCV = cvService.getCVByUserId(theUserId);
		
		theModel.addAttribute("theListSaveJobs", theListSaveJobs);
		theModel.addAttribute("userCV", theCV);
		
		return "candidate/list-save-jobs";
	}
	
	// danh sach cong viec da ung tuyen
	@RequestMapping("/listApplyJob")
	public String listApplyJob(@RequestParam("userId") int theUserId, Model theModel) {
		
		// get ve danh sach tin tuyen dung da ung tuyen ung voi user (candidate)
		List<ApplyPost> theListApplyJobs = userService.getListApplyJobsByUserId(theUserId);
		
		theModel.addAttribute("theListApplyJobs", theListApplyJobs);
		
		return "candidate/list-apply-jobs";
	}
	
	// danh sach tat ca cong ty
	@RequestMapping("/allCompanies")
	public String allCompanies(@RequestParam("userId") int theUserId, Model theModel) {
		
		// get ve danh sach tat ca cong ty hien co
		List<Company> listCompanies = companyService.getListCompanies();
		
		// get ve danh sach cong ty da luu ung voi user (candidate)
		List<Object> userSaveCompanies = userService.getSaveCompaniesByUserId(theUserId);
		
		theModel.addAttribute("listCompanies", listCompanies);
		theModel.addAttribute("userSaveCompanies", userSaveCompanies);
		
		return "candidate/list-company";
	}
	
	// theo doi cong ty
	@RequestMapping("/followCompany")
	public String followCompany(@RequestParam("companyId") int theCompanyId,
			  					@RequestParam("userId") int theUserId,
			  					Model theModel) {
		
		// kiem tra xem user da theo doi cong ty hay chua
		FollowCompany userFollowCompany = userService.findUserFollowCompany(theCompanyId, theUserId);
		
		String msgAlert = "";
		
		// neu chua theo doi cong ty thi tien hanh luu vao db, khong thi tra ve thong bao da luu
		if(userFollowCompany == null) {
			Company theCompany = companyService.getCompanyById(theCompanyId);
			User theUser = userService.getUser(theUserId);
			
			FollowCompany theFollowCompany = new FollowCompany(theCompany, theUser);
			userService.saveFollowCompany(theFollowCompany);
			
			msgAlert = "Bạn đã lưu theo dõi công ty này thành công!";
			
		} else {
			msgAlert = "Bạn đã theo dõi công ty này rồi!";
		}
		
		theModel.addAttribute("msgAlert", msgAlert);
		
		return "candidate/follow-company-notification";
	}
	
	// huy theo doi cong ty
	@RequestMapping("/unFollowCompany")
	public String unFollowCompany(@RequestParam("companyId") int theCompanyId,
								  @RequestParam("userId") int theUserId) {
		
		userService.unFollowCompany(theCompanyId, theUserId);
		
		return "candidate/unfollow-company-success";
	}
	
	// danh sach bai dang cua cong ty
	@RequestMapping("/companyListJobs")
	public String companyListJobs(@RequestParam("companyId") int theCompanyId,
			  					  @RequestParam("userId") int theUserId,
			  					  Model theModel) {
		
		// get ve cong ty
		Company company = companyService.getCompanyById(theCompanyId);
		
		// get ve danh sach bai dang cua cong ty
		List<Recruitment> listRecruitmentOfCompany = recruitmentService.getRecruitments(theCompanyId);
		
		// get ve danh sach tin tuyen dung da luu ung voi user
		List<Object> userSaveJobs = userService.getSaveJobsByUserId(theUserId);
		
		// get ve CV tuong ung voi User
		CV theUserCV = cvService.getCVByUserId(theUserId);
		
		theModel.addAttribute("listRecruitmentOfCompany", listRecruitmentOfCompany);
		theModel.addAttribute("userCV", theUserCV);
		theModel.addAttribute("userSaveJobs", userSaveJobs);
		theModel.addAttribute("company", company);
		
		return "candidate/list-recruitment-company";
	}
	
	// danh sach cong ty da luu
	@RequestMapping("/listFollowCompanies")
	public String listFollowCompanies(@RequestParam("userId") int theUserId, Model theModel) {
		
		// get ve danh sach cong ty da theo doi ung voi user (candidate)
		List<Object> theListFollowCompany = userService.getListFollowCompanyByUserId(theUserId);
		
		// get ve danh sach cong ty da luu ung voi user (candidate)
		List<Object> userSaveCompanies = userService.getSaveCompaniesByUserId(theUserId);
		
		theModel.addAttribute("theListFollowCompany", theListFollowCompany);
		theModel.addAttribute("userSaveCompanies", userSaveCompanies);
		
		return "candidate/list-follow-company";
	}
	

}
