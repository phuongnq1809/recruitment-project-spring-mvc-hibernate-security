package phuongnq.prj321x.asm2.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import phuongnq.prj321x.asm2.entity.ApplyPost;
import phuongnq.prj321x.asm2.entity.Category;
import phuongnq.prj321x.asm2.entity.Company;
import phuongnq.prj321x.asm2.entity.Recruitment;
import phuongnq.prj321x.asm2.entity.User;
import phuongnq.prj321x.asm2.service.CategoryService;
import phuongnq.prj321x.asm2.service.CompanyService;
import phuongnq.prj321x.asm2.service.RecruitmentService;
import phuongnq.prj321x.asm2.service.UserService;

@Controller
@RequestMapping("/employer")
public class EmployerController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private RecruitmentService recruitmentService;
	
	@Autowired
	private ServletContext servletContext;
	
	// add an initbinder...to convert trim input strings
	// xoa cac ki tu la khoang trang thua o cac field trong form
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		
		StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true); // true means trim to null
		dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
	}
	
	// form cap nhat thong tin ho so nha tuyen dung va cong ty tuong ung
	@RequestMapping("/updateProfile")
	public String updateProfile(@RequestParam("userId") int theId, Model theModel) {
		
		User theUser = userService.getUser(theId);
		
		Company theCompany = companyService.getCompanyByUserId(theUser.getId());
		
		theModel.addAttribute("employerUpdate", theUser);
		theModel.addAttribute("companyUpdate", theCompany);
		
		return "employer/profile";
		
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
	
	// xu ly cap nhat thong tin ca nhan
	@PostMapping(value="/updateProfileProcess", produces = "text/html;charset=UTF-8")
	public String updateProfileProcess(@RequestParam("userId") int theUserId,
									   @RequestParam("imgProfile") CommonsMultipartFile imgFile,
									   @RequestParam("email") String theUserEmail,
									   @RequestParam("name") String theUserName,
									   @RequestParam("address") String theUserAddress,
									   @RequestParam("phone") String theUserPhone,
									   @RequestParam("userdesc") String theUserdesc) {
		
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
		
		// luu thong tin vao database
		userService.saveUser(theUser);

		return "employer/update-profile-success";
		
	}
	
	// xu ly cap nhat thong tin cong ty
	@PostMapping(value="/updateCompanyProcess", produces = "text/html;charset=UTF-8")
	public String updateCompanyProcess(@RequestParam("companyId") int theCompanyId,
									   @RequestParam("imgLogo") CommonsMultipartFile logoFile,
									   @RequestParam("companyemail") String theCompanyEmail,
									   @RequestParam("companyname") String theCompanyName,
									   @RequestParam("companyaddress") String theCompanyAddress,
									   @RequestParam("companyphone") String theCompanyPhone,
									   @RequestParam("companydesc") String theCompanyDesc) {
		
		// get doi tuong Company dang cap nhat
		Company theCompany = companyService.getCompanyById(theCompanyId);
		
		// ten file anh logo
		String imgLogo = "";
		
		// Neu co thay doi anh logo cong ty
		if(!logoFile.isEmpty()) {
			
			uploadFile(logoFile);
			imgLogo = logoFile.getOriginalFilename();
			
		}
		
		theCompany.setEmail(theCompanyEmail);
		theCompany.setCompanyName(theCompanyName);
		theCompany.setAddress(theCompanyAddress);
		theCompany.setPhoneNumber(theCompanyPhone);
		theCompany.setDescription(theCompanyDesc);
		
		if(!imgLogo.equals("")) {
			theCompany.setLogo(imgLogo);
		}
		
		// luu thong tin vao database
		companyService.saveCompany(theCompany);

		return "employer/update-profile-success";
		
	}
	
	// show form dang tin tuyen dung
	@RequestMapping("/postRecruitment")
	public String postRecruitment() {
		return "employer/post-recruitment";
	}
	
	// xu ly form dang tin tuyen dung
	@PostMapping(value="/postRecruitmentProcess", produces = "text/html;charset=UTF-8")
	public String postRecruitmentProcess(@RequestParam("userId") int theUserId,
										 @RequestParam("title") String theTitle,
										 @RequestParam("desc") String theDesc,
										 @RequestParam("experience") String theExperience,
										 @RequestParam("quantity") int theQuantity,
										 @RequestParam("address") String theAddress,
										 @RequestParam("deadline") String theDeadline,
										 @RequestParam("salary") String theSalary,
										 @RequestParam("type") String theType,
										 @RequestParam("category") int theCategoryId) {
		
		// get doi tuong Company tu User tuong ung
		Company company = companyService.getCompanyByUserId(theUserId);
		
		// get ve Category tuong ung
		Category theCategory = categoryService.getCategoryById(theCategoryId);
		
		// cap nhat so lan chon category
		int updateNumberChoose = theCategory.getNumberChoose() + 1;
		theCategory.setNumberChoose(updateNumberChoose);
		
		String currentDate = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(Calendar.getInstance().getTime());
		
		// khoi tao doi tuong Recruitment
				Recruitment theRecruitment = 
						new Recruitment(theTitle, theDesc, theExperience, theQuantity, theAddress, theDeadline,
										theSalary, theType, theCategory, company, 0, currentDate, 1);
		
		// luu vao database
		recruitmentService.saveRecruitment(theRecruitment);
		categoryService.saveCategory(theCategory);
		
		return "employer/post-recruitment-success";
	}
	
	// show danh sach tin tuyen dung
	@RequestMapping("/recruitmentsManagement")
	public String recruitmentsManagement(@RequestParam("employerId") int theEmployerId, Model theModel) {
		
		// get doi tuong Company tuong ung voi User (Employer)
		Company theCompany = companyService.getCompanyByUserId(theEmployerId);
		
		// get ve danh sach cac bai dang tuong ung voi company (qua id)
		int companyId = theCompany.getId();
		List<Recruitment> theRecruitments = recruitmentService.getRecruitments(companyId);
		
		theModel.addAttribute("recruitments", theRecruitments);
		theModel.addAttribute("companyRecruitments", theCompany);
		
		return "employer/list-recruitments";
	}
	
	// xoa 1 tin tuyen dung
	@RequestMapping("/deleteRecruitment")
	public String deleteRecruitment(@RequestParam("recruitmentId") int theRecruitmentId) {
		
		recruitmentService.deleteRecruitment(theRecruitmentId);
		
		return "employer/delete-recruitment-success";
		
	}
	
	// show form cap nhat thong tin 1 bai dang
	@RequestMapping("/updateRecruitment")
	public String updateRecruitment(@RequestParam("recruitmentId") int theRecruitmentId, Model theModel) {
		
		// get ve doi tuong Recruitment theo id
		Recruitment theRecruitment = recruitmentService.getRecruitmentById(theRecruitmentId);
		
		// loai cong viec
		String currentType = theRecruitment.getType();
		List<String> types = new ArrayList<>();
		types.add("Full time");
		types.add("Part time");
		types.add("Freelancer");
		types.remove(currentType);
		
		// danh muc cong viec
		Category currentCategory = theRecruitment.getCategory();
		List<Category> categories = categoryService.getCategories();
		
		Category tempCategory = null;	
		for(Category category : categories) {
			if(category.getCategoryName().equals(currentCategory.getCategoryName())) {
				tempCategory = category;
			}
		}
		
		if(tempCategory != null) {
			categories.remove(tempCategory);
		}
		
		theModel.addAttribute("recruitmentUpdate", theRecruitment);
		theModel.addAttribute("types", types);
		theModel.addAttribute("categories", categories);
		
		return "employer/update-recruitment";
	}
	
	// xu ly form cap nhat tin tuyen dung
	@PostMapping(value="/updateRecruitmentProcess", produces = "text/html;charset=UTF-8")
	public String updateRecruitmentProcess(@RequestParam("recruitmentId") int theRecruitmentId,
										   @RequestParam("title") String theTitle,
										   @RequestParam("desc") String theDesc,
										   @RequestParam("experience") String theExperience,
										   @RequestParam("quantity") int theQuantity,
										   @RequestParam("address") String theAddress,
										   @RequestParam("deadline") String theDeadline,
										   @RequestParam("salary") String theSalary,
										   @RequestParam("type") String theType,
										   @RequestParam("category") int theCategoryId) {
		
		// get ve doi tuong Recruitment dang cap nhat
		Recruitment theRecruitment = recruitmentService.getRecruitmentById(theRecruitmentId);
		
		// get ve doi tuong Category user select
		Category category = categoryService.getCategoryById(theCategoryId);
		
		// cap nhat thong tin
		theRecruitment.setTitle(theTitle);
		theRecruitment.setDescription(theDesc);
		theRecruitment.setExperience(theExperience);
		theRecruitment.setQuantity(theQuantity);
		theRecruitment.setAddress(theAddress);
		theRecruitment.setDeadline(theDeadline);
		theRecruitment.setSalary(theSalary);
		theRecruitment.setType(theType);
		theRecruitment.setCategory(category);
		
		// luu vao database
		recruitmentService.saveRecruitment(theRecruitment);
		
		return "employer/update-recruitment-success";
	}
	
	// chi tiet thong tin 1 bai dang
	@RequestMapping("/recruitmentDetail")
	public String recruitmentDetail(@RequestParam("recruitmentId") int theRecruitmentId, Model theModel) {
		
		// get ve doi tuong Recruitment dang cap nhat
		Recruitment theRecruitment = recruitmentService.getRecruitmentById(theRecruitmentId);
		
		// get ve doi tuong Company tuong ung
		Company theCompany = companyService.getCompanyById(theRecruitment.getCompany().getId());
		
		// get ve danh sach user ung tuyen vao vi tri tuong ung
		List<ApplyPost> theApplyPosts = userService.getApplyPostsByRecruitmentId(theRecruitmentId);
		
		theModel.addAttribute("recruitmentDetail", theRecruitment);
		theModel.addAttribute("company", theCompany);
		theModel.addAttribute("applyPosts", theApplyPosts);
		
		return "employer/recruitment-detail";
	}
	
	// show danh sach ung cu vien ung tuyen cua cong ty
	@RequestMapping("/listCandidate")
	public String listCandidate(@RequestParam("userId") int theUserId, Model theModel) {
		
		// get ve cong ty tuong ung voi user (employer)
		Company theCompany = companyService.getCompanyByUserId(theUserId);
		
		// get ve danh sach ung cu vien da ung tuyen vao cac vi tri tuyen dung cua cong ty
		List<ApplyPost> listApplyPost = userService.getApplyPostsByCompany(theCompany.getId());
		
		theModel.addAttribute("theCompany", theCompany);
		theModel.addAttribute("listApplyPost", listApplyPost);
		
		return "employer/list-candidate";
	}
	
}
