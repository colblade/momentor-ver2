package org.kosta.momentor.member.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.kosta.momentor.contents.model.ListVO;
import org.kosta.momentor.contents.model.PagingBean;
import org.kosta.momentor.contents.model.ReListVO;
import org.kosta.momentor.contents.model.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
//github.com/colblade/Momentor-test.git
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MomentorMemberServiceImpl implements MomentorMemberService {
	@Resource
	private MomentorMemberDAO momentorMemberDAO;

	/*로그인*/
	@Override
	public MomentorMemberPhysicalVO login(MomentorMemberVO vo) {
		return momentorMemberDAO.login(vo);
	}
	/* 아이디 찾기 */
	@Override
	public MomentorMemberVO idCheck(MomentorMemberVO vo) {
		return momentorMemberDAO.idCheck(vo);
	}
	/* 비밀번호 찾기 */
	@Override
	public MomentorMemberVO passwordCheck(MomentorMemberVO vo){
		return momentorMemberDAO.passwordCheck(vo);
	}
	/* 비밀번호를 찾은 후 해당 이메일로 전송 */
	@Autowired
    protected JavaMailSender  mailSender;
	@Override
	public void SendEmail(EmailVO email) throws Exception {
		MimeMessage msg = mailSender.createMimeMessage();
        try {
            msg.setSubject(email.getSubject());
            msg.setText(email.getContent());
            msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email.getReceiver()));         
        }catch(MessagingException e) {
            System.out.println("MessagingException");
            e.printStackTrace();
        }
        try {
            mailSender.send(msg);
        }catch(MailException e) {
            System.out.println("MailException발생");
            e.printStackTrace();
        }
	}
	
	/*회원 가입시 아이디 중복 검사*/
	@Override
	public String idOverlappingCheck(String id) {
		int count=momentorMemberDAO.idOverlappingCheck(id);
		return (count==0) ? "ok":"fail"; 
	}
	/*회원 가입시 닉네임 중복 검사*/
	@Override
	public String nickNameOverlappingCheck(String nickName) {
		int count=momentorMemberDAO.nickNameOverlappingCheck(nickName);
		return (count==0) ? "ok":"fail"; 
	}
	/*회원가입시 이메일 중복 검사*/
	@Override
	public String emailOverlappingCheck(String memberEmail, String memberEmail2) {
		System.out.println("서비스 : "+memberEmail+"@"+memberEmail2);
		int count=momentorMemberDAO.emailOverlappingCheck(memberEmail+"@"+memberEmail2);
		return (count==0) ? "ok":"fail";
	}
	/*회원 가입*/
	@Override
	public void registerMember(MomentorMemberVO vo, String date, String memberEmail, String memberEmail2,String memberWeight,String memberHeight,String infoPublic) {
		MomentorMemberPhysicalVO pnvo=new MomentorMemberPhysicalVO();
	    SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyy", Locale.KOREA);
        Date currentTime = new Date();
        String mTime = mSimpleDateFormat.format (currentTime);
        int mT=Integer.parseInt(mTime);
        int birthYear=Integer.parseInt(date.substring(0, 4));
        int birthMonth=Integer.parseInt(date.substring(5, 7));
        int birthDay=Integer.parseInt(date.substring(8, 10));
        int age=mT-birthYear+1;
        int weight=Integer.parseInt(memberWeight);
        int height=Integer.parseInt(memberHeight);
        pnvo.setMemberWeight(weight);
        pnvo.setMemberHeight(height);
        double bmi=(double)weight/((double)height*(double)height)*(double)10000;
        double b = Math.round(bmi*100d) / 100d;
        vo.setBirthYear(birthYear);
        vo.setBirthMonth(birthMonth);
        vo.setBirthDay(birthDay);
        vo.setMemberEmail(memberEmail+"@"+memberEmail2);
        pnvo.setMomentorMemberVO(vo);
        pnvo.setAge(age);
        pnvo.setBmi(b);
    	momentorMemberDAO.registerMember(vo);
		momentorMemberDAO.registerPhysicalMember(pnvo);
	}
	
	/*마이페이지 회원정보 보기*/
	@Override
	public MomentorMemberPhysicalVO myPageMemberInfo(String memberId) {
		return momentorMemberDAO.myPageMemberInfo(memberId);
	}
	//updateMember는 정상수행되고 updateMemberPhysical은 에러가 나게 되는 경우 rollback 해주기 위해서
	//transaction 처리해주고 exception throws 해줌
	@Transactional
	@Override
	public String updateMember(String myBirthDate,MomentorMemberVO vo, MomentorMemberPhysicalVO pnvo) throws Exception {
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyy", Locale.KOREA);
		Date currentTime = new Date();
		String mTime = mSimpleDateFormat.format (currentTime);
		int mT=Integer.parseInt(mTime);
		int birthYear=Integer.parseInt(myBirthDate.substring(0, 4));
		int birthMonth=Integer.parseInt(myBirthDate.substring(5, 7));
		int birthDay=Integer.parseInt(myBirthDate.substring(8, 10));
		vo.setBirthYear(birthYear);
		vo.setBirthMonth(birthMonth);
		vo.setBirthDay(birthDay);
		momentorMemberDAO.updateMember(vo);
        double bmi=(double) pnvo.getMemberWeight()/((double)pnvo.getMemberHeight()*(double)pnvo.getMemberHeight())*(double)10000;
        double b = Math.round(bmi*100d) / 100d;
        int age=mT-birthYear+1;
        pnvo.setAge(age);
        pnvo.setBmi(b);
        momentorMemberDAO.updateMemberPhysical(pnvo);
		return "myInfoUpdate";
	}
	/*마이페이지 회원 탈퇴 신체정보 삭제, 회원정보 수정(auth) */
	@Transactional
	@Override
	public String deleteMemeber(String memberId) throws Exception {
		momentorMemberDAO.myPageDeleteMemberPhysicalInfo(memberId);
		momentorMemberDAO.myPageDeleteMemberInfo(memberId);
		return "myInfoDelete";
	}
	/*마이페이지 회원 수정/탈퇴 할때 비밀번호 체크*/
	@Override
	public String myPasswordCheck(String password, String memberId) {
		MomentorMemberPhysicalVO mpvo = momentorMemberDAO.myPageMemberInfo(memberId);
		int passwordCheck= momentorMemberDAO.myPasswordCheck(password);
		//패스워드는 고유값이 아니기 때문에 멤버의 패스워드와 비교하는 것을 추가함
		return (passwordCheck!=0&&password.equals(mpvo.getMomentorMemberVO().getMemberPassword())) ? "ok":"fail"; 
	}
	/*내가 쓴 커뮤니티 게시글 리스트*/
	@Override
	public ListVO getCommnunityListByMemberId(String memberId, String pageNo) {
		if(pageNo==null||pageNo.equals("")){
			pageNo = "1";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("pageNo", pageNo);
		ListVO lvo = new ListVO();
		lvo.setList((ArrayList)momentorMemberDAO.getCommnunityListByMemberId(map));
		lvo.setPagingBean(new PagingBean(momentorMemberDAO.totalCommnunityByMemberId(memberId), Integer.parseInt(pageNo)));
		return lvo;
	}
	/*내가 쓴 댓글 리스트*/
	@Override
	public ReListVO getReplyListByMemberId(String memberId, String pageNo) {
		if(pageNo==null||pageNo.equals("")){
			pageNo = "1";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("pageNo", pageNo);		
		ReListVO rvo = new ReListVO();
		rvo.setList((ArrayList<ReplyVO>)momentorMemberDAO.getReplyListByMemberId(map));
		rvo.setPagingBean(new PagingBean(momentorMemberDAO.totalReplyByMemberId(memberId), Integer.parseInt(pageNo)));
		return rvo;
	}
	
	/*관리자가 회원 목록 보기*/
	@Override
	public MemberListVO managerGetAllMember(String pageNo) {
		if(pageNo==null||pageNo=="") 
			pageNo="1";
		ArrayList<MomentorMemberPhysicalVO> list=(ArrayList)momentorMemberDAO.managerGetAllMember(pageNo);
		int total=momentorMemberDAO.totalMemberCount();
		PagingBean paging = new PagingBean(total, Integer.parseInt(pageNo));
		MemberListVO lvo = new MemberListVO(list, paging);
		return lvo;
	}
	/*관리자가 아이디로 회원 검색*/
	@Override
	public MemberListVO managerFindMemberById(String search, String pageNo) {
		if(pageNo==null||pageNo=="") 
			pageNo="1";
		ArrayList<MomentorMemberPhysicalVO> list = null;
		HashMap<String, String> paramMap=new HashMap<String, String>();
		paramMap.put("memberId", search);
		paramMap.put("pageNo", pageNo);
		list=(ArrayList)momentorMemberDAO.managerFindMemberById(paramMap);
		int total = momentorMemberDAO.totalMemberFindByIdCount(search);
		PagingBean paging = new PagingBean(total, Integer.parseInt(pageNo));
		MemberListVO lvo = new MemberListVO(list, paging);
		return lvo;
	}
	/*관리자가 이름으로 회원 검색*/
	@Override
	public MemberListVO managerFindMemberByName(String search, String pageNo) {
		if(pageNo==null||pageNo=="") 
			pageNo="1";
		ArrayList<MomentorMemberPhysicalVO> list = null;
		HashMap<String, String> paramMap=new HashMap<String, String>();
		paramMap.put("memberName", search);
		paramMap.put("pageNo", pageNo);
		list=(ArrayList)momentorMemberDAO.managerFindMemberByName(paramMap);
		int total = momentorMemberDAO.totalMemberFindByNameCount(search);
		PagingBean paging = new PagingBean(total, Integer.parseInt(pageNo));
		MemberListVO lvo = new MemberListVO(list,paging);
		return lvo;
	}
	/*관리자가 닉네임으로 회원 검색*/
	@Override
	public MemberListVO managerFindMemberByNickName(String search, String pageNo) {
		if(pageNo==null||pageNo=="") 
			pageNo="1";
		ArrayList<MomentorMemberPhysicalVO> list = null;
		HashMap<String, String> paramMap=new HashMap<String, String>();
		paramMap.put("nickName", search);
		paramMap.put("pageNo", pageNo);
		list=(ArrayList)momentorMemberDAO.managerFindMemberByNickName(paramMap);
		int total = momentorMemberDAO.totalMemberFindByNickNameCount(search);
		PagingBean paging = new PagingBean(total, Integer.parseInt(pageNo));
		MemberListVO lvo = new MemberListVO(list,paging);
		return lvo;
	}
	/*관리자가 회원 강퇴*/
	@Override
	public int deleteMemberByAdmin(String id) {
		return momentorMemberDAO.deleteMemberByAdmin(id);
	}

	/*커뮤니티 게시판에서 닉네임으로 회원 정보 보기*/
	@Override
	public MomentorMemberPhysicalVO getMemberInfoByNickName(String nickName) {
		return momentorMemberDAO.getMemberInfoByNickName(nickName);
	}
}