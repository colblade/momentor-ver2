<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- Footer -->
    <footer class="text-center">
        <div class="footer-above">
            <div class="container">
                <div class="row">
                    <div class="footer-col col-md-4">
                        <h3>Location</h3>
                        <p>경기도 성남시 분당구 삼평동 696-1 유스페이스2 B동 8층 한국소프트웨어진흥협회</p>
                    </div>
                    <div class="footer-col col-md-4">
                        <h3>Around the Web</h3>
                        <ul class="list-inline">
                            <li>
                                <a href="http://www.facebook.com" class="btn-social btn-outline"><i class="fa fa-fw fa-facebook"></i></a>
                            </li>
                            <li>
                                <a href="http://google.co.kr" class="btn-social btn-outline"><i class="fa fa-fw fa-google-plus"></i></a>
                            </li>
                            <li>
                                <a href="http://twitter.com" class="btn-social btn-outline"><i class="fa fa-fw fa-twitter"></i></a>
                            </li>
                            <li>
                                <a href="http://instagram.com" class="btn-social btn-outline"><i class="fa fa-fw fa-instagram"></i></a>
                            </li>
                        </ul>
                    </div>
                    <div class="footer-col col-md-4">
                        <h3>Created By</h3>
                        <p>PM : 한현준&nbsp;&nbsp;&nbsp;PL : 김유정&nbsp;&nbsp;&nbsp;PE : 이&nbsp;&nbsp;&nbsp;탄</p>
                        <p>PE : 박준하&nbsp;&nbsp;&nbsp;PS : 장윤재&nbsp;&nbsp;&nbsp;PA : 박준선</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-below">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                    <c:choose>
                    	<c:when test="${not empty sessionScope.pnvo}">
                    		Copyright &copy; <a href="${initParam.root}login_home.do">www.momentor.co.kr</a> 2015
                    	</c:when>
                    	<c:otherwise>
	                        Copyright &copy; <a href="${initParam.root}home.do">www.momentor.co.kr</a> 2015                	
                    	</c:otherwise>
                    </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-top page-scroll visible-xs visible-sm">
        <a class="btn btn-primary" href="#page-top">
            <i class="fa fa-chevron-up"></i>
        </a>
    </div>