package phuongnq.prj321x.asm2.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import phuongnq.prj321x.asm2.entity.Company;
import phuongnq.prj321x.asm2.entity.Role;
import phuongnq.prj321x.asm2.entity.User;
import phuongnq.prj321x.asm2.service.CompanyService;
import phuongnq.prj321x.asm2.service.RoleService;
import phuongnq.prj321x.asm2.service.UserService;

@Controller
public class RegistrationController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private CompanyService companyService;
	
	private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	// add an initbinder...to convert trim input strings
	// xoa cac ki tu la khoang trang thua o cac field trong form
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		
		StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true); // true means trim to null
		dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
	}
	
	@GetMapping("/register")
	public String showRegistrationForm() {
		
		return "register";
	}
	
	@PostMapping(value="/register/processForm", produces = "text/html;charset=UTF-8")
	public String processRegistrationForm(@RequestParam("email") String theEmail,
										  @RequestParam("name") String theName,
										  @RequestParam("password") String thePassword,
										  @RequestParam("passwordConfirm") String thePasswordConfirm,
										  @RequestParam("role") int theRoleId,
										  HttpServletRequest request,
										  Model theModel) {
		
		// kiem tra xem email da ton tai trong he thong chua
		if(doesUserExist(theEmail)) {
			theModel.addAttribute("error_msg", "Email đã tồn tại trong hệ thống, vui lòng chọn email khác!");
			return "register";
		}
		
		// Kiem tra xem mat khau nhap lai co trung khop khong
		if(!thePassword.equals(thePasswordConfirm)) {
			theModel.addAttribute("error_msg", "Mật khẩu nhập lại chưa khớp, vui lòng nhập lại!");
			return "register";
		}
		
		// get Role object
		Role theRole = roleService.getRoleById(theRoleId);
		
		String currentDate = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(Calendar.getInstance().getTime());
		
		// ma hoa mat khau bang bcrypt
        String encodedPassword = passwordEncoder.encode(thePassword);
        encodedPassword = "{bcrypt}" + encodedPassword;
		
		// khoi tao 1 doi tuong User de them vao database
		User theUser = new User(theEmail, theEmail, encodedPassword, theName, "", "", "", "", currentDate, 1, theRole,"");
		
		Company company = null;
		// neu nguoi dung dang ky la nha tuyen dung, khoi tao 1 doi tuong company moi tuong ung
		// va gui email xac thuc tai khoan
		if(theUser.getRole().getRoleName().equals("Cong ty")) {
			
			company = new Company("","","","","","",currentDate, 0, theUser);
			
			// gui email xac thuc
			String randomVerificationCode = RandomStringUtils.random(64, true, true);
			theUser.setVerificationCode(randomVerificationCode);
			theUser.setEnabled(0);
			
			String siteURL = request.getRequestURL().toString();
	        siteURL =  siteURL.replace(request.getServletPath(), "");
			
			try {
				userService.sendVerificationEmail(theUser, siteURL);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
		
		// luu thong tin vao database (phan quyen cho user voi vai tro tuong ung (Ung vien hoac Cong ty))
		userService.saveUser(theUser);
		if(company != null) {
			companyService.saveCompany(company);
		}
		roleService.setUserAuthorities(theUser.getUsername(), theUser.getRole().getRoleName());
		
		theModel.addAttribute("userRegisterd", theUser);
		
		return "registration-success";
	}
	
	// ham kiem tra xem email da ton tai hay chua
	private boolean doesUserExist(String email) {
		
		User foundUser = userService.findUser(email);
		
		if(foundUser != null) {
			return true;
		} else {
			return false;
		}
	}
	
	// xac thuc email voi tai khoan dang ky la nha tuyen dung
	@GetMapping("/verifyAccount")
	public String verifyAccount(@RequestParam("code") String theCode) {
		
		User theUser = userService.findUserByVerificationCode(theCode);
		
		if(theUser == null || theUser.getEnabled() == 1) {
			
			return "verify-fail";
			
		} else {
			
			// set enable cho user
			theUser.setVerificationCode("");
			theUser.setEnabled(1);
			userService.saveUser(theUser);
			
			// set enable cho cong ty tuong ung voi user
			Company company = companyService.getCompanyByUserId(theUser.getId());
			company.setStatus(1);
			companyService.saveCompany(company);
								
			return "verify-success";
		}
		
	}

}
