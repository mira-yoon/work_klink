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
        	<td colspan="4">
        	<h3>기간별 로그인 현황</h3>
        	</td>
        </tr>
 
        <tr align="center">
			<td rowspan="2"><h4>기간</h4></td>
			<td colspan="2"><h4>회원구분</h4></td>
			<td rowspan="2"><h4>합계</h4></td>
		</tr>
		<tr align="center">
			<td><h4>관리자</h4></td>
			<td><h4>일반</h4></td>
		</tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
				<td>${result.LOGIN_DATE }</td>
				<td>${result.UT01 }</td>
				<td>${result.UT03 }</td>
				<td>${result.CNT }</td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="4" rowspan="16"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
