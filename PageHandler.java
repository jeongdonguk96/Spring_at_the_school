package com.ezen.biz;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageHandler {
	private int totalCount; /// 총 게시물 수
	private int pageSize; // 한 페이지 내 게시글 수
	private int naviSize; // 페이지 네이게이션 수
	private int totalPage; // 전체 페이지 수
	private int page; // 현재 페이지
	private int beginPage; // 네비게이션의 첫 페이지
	private int endPage; // 네비게이션의 마지막 페이지
	private boolean showPrev; // 이전 페이지로 이동하는 링크를 보여줄 것인지 여부
	private boolean showNext; // 다음 페이지로 이동하는 링크를 보여줄 것인지 여부
	
	public PageHandler(int totalCount, int page) {
		this(totalCount, page, 10);
	}
	
	public PageHandler(int totalCount, int page, int pageSize) {
		this.totalCount = totalCount;
		this.page = page;
		this.pageSize = pageSize;
		
		totalPage = (int) Math.ceil(totalCount / (double)pageSize); // ex) 전체 페이지 수는 462/10 = 46에 ceil(올림)로 인해 47
		beginPage = (page-1) / naviSize * naviSize + 1; // ex) 네비게이션의 첫 페이지는 (35/10)*10+1 = 31 
		endPage = Math.min(beginPage + naviSize - 1, totalPage); // ex) 네비게이션의 마지막 페이지는 (31+10-1, 47) 둘 중 작은 숫자
		showPrev = beginPage != 1; // 이전페이지는 네비 첫 페이지가 1이 아닌 경우 보여주기
		showNext = endPage != totalPage; // 다음페이지는 네비 마지막 페이지가 곧 전체 페이지가 아닌 경우 보여주기
	}
	
	void print() {
		System.out.println("page = " + page);
		System.out.println(showPrev ? "[PREV]" : "");
		
		for(int i=beginPage; i<=endPage; i++) {
			System.out.println(i + " ");
		}
		System.out.println(showNext ? "[Next]" : "");
	}
}
