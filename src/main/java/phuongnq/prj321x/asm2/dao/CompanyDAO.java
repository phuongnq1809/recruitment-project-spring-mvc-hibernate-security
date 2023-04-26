package phuongnq.prj321x.asm2.dao;

import java.util.List;

import phuongnq.prj321x.asm2.entity.Company;

public interface CompanyDAO {

	void saveCompany(Company company);

	Company getCompanyByUserId(int userId);

	Company getCompanyById(int companyId);

	List<Object[]> getFeaturedCompanies();

	List<Company> getListCompanies();

}
