package com.hoon.web;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;


//스프링 로딩
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class DataSoureTest {
	
	@Inject
	private DataSource ds;
	
	//DataSource 테스트
	@Test
	public void testConnection() throws Exception{
		try(Connection con = ds.getConnection()) {
			System.out.println(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
