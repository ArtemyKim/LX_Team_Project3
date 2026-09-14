package lx.edu.subwayproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.edu.subwayproject.dao.UserDAO;
import lx.edu.subwayproject.dto.UserDTO;

@Service
public class LoginService {

	@Autowired
	UserDAO dao;
	
	
	public UserDTO login(UserDTO user) {
		UserDTO existingUser = dao.selectUserByUserName(user.getUserName());
		
		if(existingUser == null) {
			dao.addUser(user);
			existingUser = dao.selectUserByUserName(user.getUserName());
		} 
	
		if(existingUser != null) {
			
			if(!existingUser.getPassword().equals(user.getPassword())) {
				return null;
								
			}			
		}
		return existingUser;
	}
}
