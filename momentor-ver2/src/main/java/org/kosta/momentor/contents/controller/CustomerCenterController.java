package org.kosta.momentor.contents.controller;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.momentor.contents.model.FAQBoardService;
import org.kosta.momentor.contents.model.FAQBoardVO;
import org.kosta.momentor.contents.model.NoticeBoardService;
import org.kosta.momentor.contents.model.NoticeBoardVO;
import org.kosta.momentor.contents.model.QNABoardService;
import org.kosta.momentor.contents.model.QNABoardVO;
import org.kosta.momentor.member.model.MomentorMemberPhysicalVO;
import org.kosta.momentor.member.model.MomentorMemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class CustomerCenterController {
	@Resource
	private NoticeBoardService noticeBoardService;
	@Resource
	private FAQBoardService faqBoardService;
	@Resource
	private QNABoardService qnaBoardService;
	
	  //공지사항 리스트
	  @RequestMapping(value="member_getAllNoticeList.do")
		public ModelAndView MygetAllNoticeList(HttpServletRequest request,String pageNo){
			MomentorMemberVO mvo = (MomentorMemberVO) request.getSession().getAttribute("mvo");
			//ListVO list = noticeBoardService.getAllNoticeList(pageNo);
			return new ModelAndView("member_getAllNoticeList","noticeList",noticeBoardService.getAllNoticeList(pageNo));
		}
	  
	  /*관리자 tails 적용하여 관리자가 공지글 목록리스트를 보기 위해*/
	  	@RequestMapping(value="admin_getAllNoticeList.do")
	  	public ModelAndView AdmingetAllNoticeList(HttpServletRequest request,String pageNo){
		  	return new ModelAndView("admin_getAllNoticeList","noticeList",noticeBoardService.getAllNoticeList(pageNo));
	  	}
	  	
		@RequestMapping(value="member_getNoticeByNo.do")
		public ModelAndView MygetNoticeByNo(int boardNo){
			NoticeBoardVO nvo = noticeBoardService.getNoticeByNo(boardNo);
			return new ModelAndView("member_getNoticeByNo","nvo",nvo);
		}
		
		/*관리자 tails 적용하여 관리자가 상세내용 불러오기 위해*/
		@RequestMapping(value="admin_getNoticeByNo.do")
		public ModelAndView AdmingetNoticeByNo(int boardNo){
			NoticeBoardVO nvo = noticeBoardService.getNoticeByNo(boardNo);
			return new ModelAndView("admin_getNoticeByNo","nvo",nvo);
		}
		
		/*관리자가 공지사항 글작성 하는 form*/
		@RequestMapping(value="admin_writeNoticeByAdminForm.do")
		public ModelAndView writeNoticeByAdminForm(HttpServletRequest request){
			MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO) request.getSession().getAttribute("pnvo");
			return new ModelAndView("admin_noticemgr_writeNoticeByAdminForm","pnvo",pnvo);
		}
		
		/*관리자가 공지사항 글작성*/
		@RequestMapping(value="admin_writeNoticeByAdmin.do")
		public ModelAndView writeNoticeByAdmin(HttpServletRequest request, NoticeBoardVO nvo){
			HttpSession session = request.getSession(false);
			MomentorMemberPhysicalVO pnvo =  (MomentorMemberPhysicalVO) session.getAttribute("pnvo");
			nvo.setMomentorMemberVO(pnvo.getMomentorMemberVO());
			noticeBoardService.postingNotice(nvo);
			return new ModelAndView("admin_noticemgr_writeNoticeResult","nvo",nvo);
		}
		
		/*관리자가 공지사항 글 수정 form*/
		@RequestMapping(value="admin_noticeUpdateForm.do")
		public ModelAndView noticeUpdateForm(int noticeNo){
			NoticeBoardVO nvo = noticeBoardService.getNoticeByNo(noticeNo);
			return new ModelAndView("admin_noticemgr_noticeUpdateForm","nvo",nvo);
		}
		
		/*관리자가 공지사항 글 수정*/
		@RequestMapping(value="admin_noticeUpdate.do", method=RequestMethod.POST)
		public ModelAndView noticeUpdate(HttpServletRequest request, NoticeBoardVO nvo){
			noticeBoardService.updateNotice(nvo);
			return new ModelAndView("admin_noticemgr_noticeUpdateResult","nvo",nvo);
		}
		
		/*관리자가 공지사항 글 삭제*/
		@RequestMapping(value="admin_noticeDelete.do")
		public ModelAndView noticeDelete(HttpServletRequest request, int noticeNo){			
			noticeBoardService.deleteNoticeByNo(noticeNo);
			return new ModelAndView("admin_noticemgr_noticeDeleteResult");
		}
		
		/*qna part */
		/* QNA 목록불러오기*/
		@RequestMapping(value="member_getAllQNAList.do")
		public ModelAndView MygetAllQNAList(HttpServletRequest request,String pageNo){
			return new ModelAndView("member_getAllQNAList","QNAList",qnaBoardService.getAllQNAList(pageNo));
		}
		
		/*조회수 증가하지 않게하는경우 */
		@RequestMapping(value="getQNAByNoNoHit.do")
	  	public ModelAndView getQNAByNoNoHit(int boardNo){
		  	return new ModelAndView("member_getQNAByNo","qvo",qnaBoardService.getQNAByNoNoHit(boardNo));
	  	}
		
		/*QNA 상세목록 보기*/
		@RequestMapping(value="member_getQNAByNo.do")
		public ModelAndView MygetQNAByNo(int boardNo, @CookieValue(value="QNABoard",required=false) String cookieValue,HttpServletResponse response){
			QNABoardVO qvo = null;
			if(cookieValue==null){
				response.addCookie(new Cookie("QNABoard", ""+boardNo+""));
				qvo = qnaBoardService.getQNAByNo(boardNo);
			}else if(cookieValue.indexOf("|"+boardNo+"|")==-1){
				cookieValue+="|"+boardNo+"|";
				response.addCookie(new Cookie("QNABoard", cookieValue));
				qvo = qnaBoardService.getQNAByNo(boardNo);
			}else{
				qvo = qnaBoardService.getQNAByNoNoHit(boardNo);
			}
			
			return new ModelAndView("member_getQNAByNo","qvo",qvo);
		}
		
		/*로그인한 유저가 QNA의 글작성폼*/
		@RequestMapping(value="my_writeQNAForm.do")
		public ModelAndView writeQNAForm(HttpServletRequest request){
			MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO) request.getSession().getAttribute("pnvo");
			return new ModelAndView("my_writeQNAForm","pnvo",pnvo);
		}
		
		/*로그인한 유저가 QNA 글작성*/
		@RequestMapping(value="my_writeQNA.do")
		public ModelAndView writeQNA(QNABoardVO qvo){
			qnaBoardService.writeQNA(qvo);
			return new ModelAndView("my_writeQNAResult","qvo",qvo);
		}
		
		/*유저가 QNA글 수정 폼*/
		@RequestMapping(value="my_updateQNAForm.do")
		public ModelAndView updateQNAForm(int qnaNo){
			QNABoardVO qvo = qnaBoardService.getQNAByNo(qnaNo);
			return new ModelAndView("my_updateQNAForm","qvo",qvo);
		}
		
		/*유저가 QNA 글 수정, 관리자가 QNA 답변 글 수정*/
		@RequestMapping(value="my_updateQNA.do", method=RequestMethod.POST)
		public ModelAndView updateQNA(HttpServletRequest request, QNABoardVO qvo){
			qnaBoardService.updateQNA(qvo);
			return new ModelAndView("my_updateQNAResult","qvo",qvo);
		}
		
		/*유저가 QNA 글 삭제, 관리자가 QNA 답변 글 삭제*/
		@RequestMapping(value="my_deleteQNA.do")
		public ModelAndView deleteQNA(HttpServletRequest request, int qnaNo){
			qnaBoardService.deleteQNA(qnaNo);
			return new ModelAndView("my_DeleteQNAResult");
		}
		
		/*관리자가 QNA 답변쓰기 폼*/
		@RequestMapping(value="admin_replyView.do")
		public ModelAndView replyView(int boardNo) {		
			return new ModelAndView("admin_noticemgr_replyForm","qvo",qnaBoardService.getQNAByNoNoHit(boardNo));
		}
		
		/*관리자가 QNA 답변쓰기*/
		@RequestMapping(value="admin_qnaReply.do")
		public ModelAndView reply(QNABoardVO qvo) throws Exception{		
			qnaBoardService.qnaReply(qvo);	
			return new ModelAndView("redirect:getQNAByNoNoHit.do?boardNo="+qvo.getBoardNo());
		}
		
		/* FAQ 게시판 글 전체 목록 받아오기 */
		@RequestMapping(value="showFAQList.do")
		public ModelAndView showFAQList(String pageNo){
			return new ModelAndView("member_showFAQList","FAQList",faqBoardService.getAllFAQList(pageNo));
		}
		
		/* FAQ 글쓰기 페이지로 이동하기 */
		@RequestMapping(value="admin_writeFAQForm.do")
		public ModelAndView writeFAQForm(){
			return new ModelAndView("admin_faqmgr_writeFAQForm");
		}
		
		/* FAQ 글쓰기 DB 저장 */
		@RequestMapping(value="admin_postingFAQ.do",method=RequestMethod.POST)
		public ModelAndView postingFAQ(FAQBoardVO fvo){
			faqBoardService.postingFAQ(fvo);
			return new ModelAndView("redirect:/showFAQList.do");
		}

		/* FAQ 게시물 삭제 */
		@RequestMapping(value="admin_deleteFAQByNo.do")
		public ModelAndView deleteFAQByNo(int boardNo){
			faqBoardService.deleteFAQByNo(boardNo);
			return new ModelAndView("redirect:/showFAQList.do","pageNo","1");
		}
		
		/* FAQ 수정 페이지로 이동 */
		@RequestMapping(value="admin_updateFAQForm.do")
		public ModelAndView updateFAQForm(int boardNo){
			return new ModelAndView("admin_faqmgr_updateFAQForm","fvo",faqBoardService.getFAQByNo(boardNo));
		}
		
		/* FAQ 수정 DB 등록 후 상세보기 반환 */
		@RequestMapping(value="admin_updateFAQ.do",method=RequestMethod.POST)
		public ModelAndView updateFAQ(FAQBoardVO fvo){
			faqBoardService.updateFAQ(fvo);
			return new ModelAndView("redirect:/showFAQList.do");			
		}
}
