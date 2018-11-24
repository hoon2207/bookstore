package com.hoon.domain;

import java.util.Arrays;
import java.util.Date;

public class BookVO {

	private Integer bno;
	private String title;
	private String author;
	private String publisher;
	private String pubday;
	private String content;
	private int price;
	private int quantity;
	private Date regdate;
	private int replycnt;
	private String writer;
	
	private String[] files;
	
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPubday() {
		return pubday;
	}
	public void setPubday(String pubday) {
		this.pubday = pubday;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "BookVO [bno=" + bno + ", title=" + title + ", author=" + author + ", publisher=" + publisher
				+ ", pubday=" + pubday + ", content=" + content + ", price=" + price + ", quantity=" + quantity
				+ ", regdate=" + regdate + ", replycnt=" + replycnt + ", writer=" + writer + ", files="
				+ Arrays.toString(files) + "]";
	}
	
	
	
	
	
	
	
	
	
}
