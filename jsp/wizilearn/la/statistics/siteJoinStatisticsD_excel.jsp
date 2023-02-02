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
        	<td colspan="2">
        	<h3>사이트 접속통계 (일별 접속수)</h3>
        	</td>
        </tr>
        <tr align="center">
        	<td colspan="2">
        	<h3>기간 : ${ param.searchYear}년  ${param.searchMonth}월</h3>
        	</td>
        </tr>
        <tr align="center">
          <td width="50" class="tableTitle"><h4>일</h4></td>
          <td width="50" class="tableTitle"><h4>접속수</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="statistics" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
	          <td width="50">${statistics.xArea}일</td>
	          <td width="50">${statistics.yCnt}</td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="2">조회된 정보가 없습니다.</td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table>
