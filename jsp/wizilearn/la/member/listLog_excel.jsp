<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
  
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
        <tr align="center">
        	<td colspan="6">
        	<h3>K-LINK 관리자 로그</h3>
        	</td>
        </tr>
 
        <tr align="center">
          <td><h4>접속계정</h4></td>
          <td><h4>이름</h4></td>
          <td><h4>접속시간</h4></td>
          <td><h4>아이피</h4></td>
			<td><h4>수행업무</h4></td>
			<td><h4>처리한정보주체</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
			<td><c:out value="${result.memId }"/></td>
			<td><c:out value="${result.memNameStr }"/></td>
			<td><c:out value="${result.loginDateStd }"/></td>
			<td><c:out value="${result.clientIp}" /></td>
			<td><c:out value="${result.workType}" /></td>
			<td><c:out value="${result.workText}" /></td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="8" rowspan="6"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
