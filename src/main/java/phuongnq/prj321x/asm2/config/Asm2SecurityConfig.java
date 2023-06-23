/*
* Security Config
*/
package phuongnq.prj321x.asm2.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.access.channel.ChannelProcessingFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

@Configuration
@EnableWebSecurity
public class Asm2SecurityConfig extends WebSecurityConfigurerAdapter {

	// add a reference to our security data source
	
	@Autowired
	private DataSource securityDataSource;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {

		// xac thuc thong tin duoc ket noi den database
		
		auth.jdbcAuthentication().dataSource(securityDataSource);

	}
	
	// phan quyen truy cap cho user
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		// encode utf-8
		http.addFilterBefore(new CharacterEncodingFilter("UTF-8", true), ChannelProcessingFilter.class);

		http.authorizeRequests()
			.antMatchers("/**").permitAll() // landing page
			.antMatchers("/register/**").permitAll() // register page
			//.antMatchers("/home").hasAnyRole("USERS", "JOBSEEKER", "EMPLOYER")
			.antMatchers("/home").hasRole("USERS")
			.antMatchers("/employer/**").hasRole("CONGTY")
			.antMatchers("/candidate/**").hasRole("UNGVIEN")
			.antMatchers("/resources/**").permitAll()
			.and()
			.formLogin()
				.loginPage("/login")
				.loginProcessingUrl("/authenticateTheUser")
				.defaultSuccessUrl("/home", true)
				.permitAll()
			.and()
			.logout()
				.logoutSuccessUrl("/") // after logout: redirect to landing page
				.permitAll()
			.and()
			.exceptionHandling().accessDeniedPage("/access-denied");
		
	}
	
	@Bean
	public UserDetailsManager userDetailsManager() {
		
		JdbcUserDetailsManager jdbcUserDetailsManager = new JdbcUserDetailsManager();
		
		jdbcUserDetailsManager.setDataSource(securityDataSource);
		
		return jdbcUserDetailsManager; 
	}
		
}
