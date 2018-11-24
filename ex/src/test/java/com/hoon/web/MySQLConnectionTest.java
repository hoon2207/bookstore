package com.hoon.web;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MySQLConnectionTest {
	
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	
	private static final String URL = "jdbc:mysql://localhost:3307/project?useSSL=false";
	
	private static final String USER = "root";
	
	private static final String PW = "cjadnjf363";
	
	//MySQL 연결 테스트
	@Test
	public void testConnection() throws Exception{
		
		Class.forName(DRIVER);
		
		try(Connection con = DriverManager.getConnection(URL, USER, PW)) {
			
			System.out.println(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
