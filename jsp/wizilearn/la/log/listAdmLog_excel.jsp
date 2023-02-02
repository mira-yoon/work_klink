<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%--
  ~ *******************************************************************************
  ~  * COPYRIGHT(C) 2016 WIZI LEARN ALL RIGHTS RESERVED.
  ~  * This software is the proprietary information of WIZI LEARN.
  ~  *
  ~  * Revision History
  ~  * Author   Date            Description
  ~  * ------   ----------      ------------------------------------
  ~  * 위지런C    2016. 11. 08 오후 1:20         Modify Draft.
  ~  *
  ~  *******************************************************************************
 --%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
        <tr align="center">
        	<td colspan="8">
        	<h3>관리자개인정보이력</h3>
        	</td>
        </tr>
        <tr align="center">
        	<td colspan="8">
        	<h3>기간 : ${comAdmLoginLogVO.searchStartDate} ~  ${comAdmLoginLogVO.searchEndDate}월</h3>
        	</td>
        </tr>
        <tr align="center">
          <td><h4>이름</h4></td>
          <td><h4>접속시간</h4></td>
          <td><h4>아이피</h4></td>
          <td><h4>OS</h4></td>
          <td><h4>브라우저</h4></td>
          <td><h4>메뉴명</h4></td>
          <td><h4>실행URL</h4></td>
          <td><h4>실행유형</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="logAdm" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
	          <td>${logAdm.memNameStr}</td>
	          <td>${logAdm.loginDateStd}</td>
	          <td>${logAdm.clientIp}</td>
              <td>${logAdm.clientOs}</td>
              <td>${logAdm.clientBrowser}</td>
              <td>${logAdm.menuName}</td>
              <td>${logAdm.workUrl}</td>
              <td>${logAdm.workType}</td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="8" rowspan="4"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table>
