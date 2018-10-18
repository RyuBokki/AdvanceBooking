package com.ktds.concert.prefer.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.common.session.Session;
import com.ktds.concert.prefer.dao.PreferDao;
import com.ktds.concert.prefer.vo.PreferSearchVO;
import com.ktds.concert.prefer.vo.PreferVO;
import com.ktds.member.dao.MemberDao;
import com.ktds.member.vo.MemberVO;

import io.github.seccoding.web.pager.Pager;
import io.github.seccoding.web.pager.PagerFactory;
import io.github.seccoding.web.pager.explorer.ClassicPageExplorer;
import io.github.seccoding.web.pager.explorer.PageExplorer;

@Service
public class PreferServiceImpl implements PreferService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private PreferDao preferDao;
	
	@Override
	public boolean registOnePrefer(PreferVO preferVO) {
		return this.preferDao.insertOnePrefer(preferVO) > 0;
	}

	@Override
	public boolean deleteOnePrefer(PreferVO preferVO) {
		return this.preferDao.deleteOnePrefer(preferVO) > 0;
	}

	@Override
	public PreferVO isDuplicatedPrefer(PreferVO preferVO) {
		return this.preferDao.isDuplicatedPrefer(preferVO);
	}

	@Override
	public PageExplorer readAllPrefers(PreferSearchVO preferSearchVO
										, HttpSession session) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute(Session.USER);
		
		preferSearchVO.setEmail(memberVO.getEmail());
		
		int totalCount = this.preferDao.selectAllPrefersCount(preferSearchVO);
		
		Pager pager = PagerFactory.getPager(Pager.ORACLE
				, preferSearchVO.getPageNo() + "");

		pager.setTotalArticleCount(totalCount);
		
		PageExplorer pageExplorer = pager.makePageExplorer(ClassicPageExplorer.class, preferSearchVO);
		
		pageExplorer.setList(this.preferDao.selectAllPrefers(preferSearchVO));
		
		return pageExplorer;
	}

	
	@Override
	public void sendEmail(PreferVO preferVO) throws Exception {
		
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "bookki@naver.com";
		String hostSMTPpwd = "dbqhrrl!!";
	
		String fromEmail = "bookki@naver.com";
		String fromName = "Concert Advance Booking";
		String subject = "";
		String msg = "";
		
		subject = "Concert Advance Booking 사전예매 안내입니다..";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += preferVO.getMemberVO().getName() + "님이 좋아요한 사전예매 관련 정보입니다.</h3>";
		msg += "<div>공연 제목 : ";
		msg += preferVO.getConcertVO().getSubject() + "</div>";
		msg += "<div>사전 예매 일자 : ";
		msg += preferVO.getConcertVO().getAdvanceBookingDay() + "</div>";
		msg += "<div>인터파크 링크 : ";
		msg += preferVO.getConcertVO().getAdvanceBookingUrl() + "</div></div>";
		
		
		String mail = preferVO.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSLOnConnect(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setStartTLSEnabled(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	@Override
	public boolean sendAdvanceBookingInfo() throws Exception {
				
		List<PreferVO> emailRecievePreferVOList = this.preferDao.selectAllPrefersForMessage();
		
		if ( emailRecievePreferVOList != null ) {
			
			for (PreferVO preferVO : emailRecievePreferVOList) {
				System.out.println(preferVO.getEmail());
				System.out.println(preferVO.getConcertId());
				System.out.println(preferVO.getMemberVO().getName());
				System.out.println(preferVO.getPreferId());
				
				sendEmail(preferVO);
				this.preferDao.updateEmailSendedPrefer(preferVO.getPreferId());
			}	
			
			return true;
		}
		else {
			
			return false;
		}
	}
	
}
