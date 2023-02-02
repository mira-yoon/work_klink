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
        	<h3>국가별 초청연수 현황</h3>
        	</td>
        </tr>
 
        <tr align="center">
          <td><h4>순위</h4></td>
          <td><h4>대륙</h4></td>
          <td><h4>국가(영문)</h4></td>
          <td><h4>국가(한글)</h4></td>
          <td><h4>건수</h4></td>
          <td><h4>비교율</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
				<td>${result.rank}</td>
				<td><c:out value="${result.nationDTO.partName}" /></td> 
				<td><c:out value="${result.nationDTO.natName }"/></td>
				<td><c:out value="${result.nationDTO.natNameKr }"/></td>
				<td><c:out value="${result.cnt }"/></td>
				<td><c:out value="${result.ratio}%" /></td>
				<%-- <td style='mso-number-format:"\@";'><c:out value="${result.telNoStr}"/></td>
				<td style='mso-number-format:"\@";'><c:out value="${result.hpNoStr}"/></td>
				<td style='mso-number-format:"Short Date";' ><c:out value="${result.lastLoginYmd}" /></td> --%>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="6" rowspan="16"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
