/*
* Asm2 App Controller
*/
package phuongnq.prj321x.asm2.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import phuongnq.prj321x.asm2.entity.ApplyPost;
import phuongnq.prj321x.asm2.entity.CV;
import phuongnq.prj321x.asm2.entity.Category;
import phuongnq.prj321x.asm2.entity.Company;
import phuongnq.prj321x.asm2.entity.Recruitment;
import phuongnq.prj321x.asm2.entity.User;
import phuongnq.prj321x.asm2.service.CVService;
import phuongnq.prj321x.asm2.service.CategoryService;
import phuongnq.prj321x.asm2.service.CompanyService;
import phuongnq.prj321x.asm2.service.RecruitmentService;
import phuongnq.prj321x.asm2.service.UserService;

@Controller
public class Asm2AppController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private RecruitmentService recruitmentService;
	
	@Autowired
	private CVService cvService;
	
	@Autowired
	private CategoryService categoryService;
	
	// landing page
	@RequestMapping(value={"/"})
	public String showLandingPage(HttpServletRequest request, HttpSession session) {
		
		// ds cong ty noi bat
		List<Object[]> featuredCompanies = companyService.getFeaturedCompanies();
		session.setAttribute("featuredCompanies", featuredCompanies);
		
		// viec lam noi bat
		List<Object[]> featuredJobs = recruitmentService.getFeaturedJobs();
		session.setAttribute("featuredJobs", featuredJobs);
		
		// top danh muc
		List<Category> topCategories = categoryService.getTopCategories();
		session.setAttribute("topCategories", topCategories);
		
		if(session.getAttribute("currentUser") != null) {
			
			Principal principal = request.getUserPrincipal();
			
			String theUsername = principal.getName();
			
			// get ve username da dang nhap thanh cong
			User theUser = userService.findUser(theUsername);
			
			// get ve danh sach tin tuyen dung da luu ung voi user (candidate)
			List<Object> userSaveJobs = userService.getSaveJobsByUserId(theUser.getId());
			
			session.setAttribute("currentUserSaveJobs", userSaveJobs);
		}
		
		return "index";
	}
	
	// user dang nhap thanh cong
	@GetMapping("/home")
	public String showHome(HttpServletRequest request, HttpSession session) {
		
		Principal principal = request.getUserPrincipal();
		
		String theUsername = principal.getName();
		
		// get ve username da dang nhap thanh cong
		User theUser = userService.findUser(theUsername);
		
		// cv ma user da cap nhat
		CV theCV = cvService.getCVByUserId(theUser.getId());
		
		// gan vao session de lay thong tin user, cv da cap nhat
		session.setAttribute("currentUser", theUser);
		session.setAttribute("currentUserCV", theCV);
		
		return "redirect:/";
	}
	
	// xu ly tim kiem job at homepage
	@PostMapping(value="/searchProcess", produces = "text/html;charset=UTF-8")
	public String searchProcess(@RequestParam("searchJob") String searchJob,
								@RequestParam("searchPlace") String searchPlace,
								Model theModel,
								HttpServletRequest request,
								HttpSession session) {
		
		List<Recruitment> theSearchResults = null;
		
		if(!searchJob.equals("") && searchPlace.equals("")) {
			theSearchResults = recruitmentService.searchJob(1, searchJob);
		} else if(searchJob.equals("") && !searchPlace.equals("")) {
			theSearchResults = recruitmentService.searchJob(2, searchPlace);
		} else {
			theSearchResults = recruitmentService.searchJob(searchJob, searchPlace);
		}
		
		if(session.getAttribute("currentUser") != null) {
			
			Principal principal = request.getUserPrincipal();
			String theUsername = principal.getName();
			
			// get ve username da dang nhap thanh cong
			User theUser = userService.findUser(theUsername);
			
			// get ve danh sach tin tuyen dung da luu ung voi user
			List<Object> userSaveJobs = userService.getSaveJobsByUserId(theUser.getId());
			
			theModel.addAttribute("userSaveJobs", userSaveJobs);
		}
		
		theModel.addAttribute("theSearchResults", theSearchResults);
		
		
		return "search-result";
	}
	
	// chi tiet thong tin 1 bai dang
	@RequestMapping("/recruitmentDetail")
	public String recruitmentDetail(@RequestParam("recruitmentId") int theRecruitmentId, Model theModel) {
		
		// get ve doi tuong Recruitment
		Recruitment theRecruitment = recruitmentService.getRecruitmentById(theRecruitmentId);
		
		// get ve doi tuong Company tuong ung
		Company theCompany = companyService.getCompanyById(theRecruitment.getCompany().getId());
		
		theModel.addAttribute("recruitmentDetail", theRecruitment);
		theModel.addAttribute("company", theCompany);
		
		return "recruitment-detail";
	}
	
	// chi tiet thong tin cong ty
	@RequestMapping("/companyDetail")
	public String companyDetail(@RequestParam("companyId") int theCompanyId,
								Model theModel,
								HttpServletRequest request,
								HttpSession session) {
		
		// get ve thong tin cong ty
		Company theCompany = companyService.getCompanyById(theCompanyId);
		theModel.addAttribute("companyDetail", theCompany);
		
		if(session.getAttribute("currentUser") != null) {
			
			Principal principal = request.getUserPrincipal();
			
			String theUsername = principal.getName();
			
			// get ve username da dang nhap thanh cong
			User theUser = userService.findUser(theUsername);
			
			// get ve danh sach cong ty da luu ung voi user (candidate)
			List<Object> userSaveCompanies = userService.getSaveCompaniesByUserId(theUser.getId());
			
			theModel.addAttribute("userSaveCompanies", userSaveCompanies);
		}
		
		return "company-detail";
	}
	
}
