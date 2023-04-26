package phuongnq.prj321x.asm2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import phuongnq.prj321x.asm2.dao.CompanyDAO;
import phuongnq.prj321x.asm2.entity.Company;

@Service
public class CompanyServiceImpl implements CompanyService {
	
	@Autowired
	private CompanyDAO companyDAO;

	@Override
	@Transactional
	public void saveCompany(Company company) {
		companyDAO.saveCompany(company);
	}

	@Override
	@Transactional
	public Company getCompanyByUserId(int userId) {
		return companyDAO.getCompanyByUserId(userId);
	}

	@Override
	@Transactional
	public Company getCompanyById(int companyId) {
		return companyDAO.getCompanyById(companyId);
	}

	@Override
	@Transactional
	public List<Object[]> getFeaturedCompanies() {
		return companyDAO.getFeaturedCompanies();
	}

	@Override
	@Transactional
	public List<Company> getListCompanies() {
		return companyDAO.getListCompanies();
	}

}
