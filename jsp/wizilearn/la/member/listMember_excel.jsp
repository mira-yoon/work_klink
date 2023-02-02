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
        	<td colspan="16">
        	<h3>회원정보</h3>
        	</td>
        </tr>
 
        <tr align="center">
          <td><h4>회원구분</h4></td>
          <td><h4>국적</h4></td>
          <td><h4>ID</h4></td>
          <td><h4>이름</h4></td>
          
			<td><h4>기관구분</h4></td>
			<td><h4>기관명</h4></td>
			<td><h4>부서</h4></td>
			<td><h4>직업</h4></td>
			<td><h4>이메일</h4></td>
			<td><h4>서브이메일</h4></td>
			<td><h4>메일링여부</h4></td>
			<td><h4>유선번호</h4></td>
			<td><h4>무선번호</h4></td>
			<td><h4>최종방문일</h4></td>
			<td><h4>방문수</h4></td>
			          
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
			<td>
				${result.memTypeName}
			</td>
			<td><c:out value="${result.natNameKr}" /></td> 
			<td><c:out value="${result.memId }"/></td>
			<td><c:out value="${result.memNameStr }"/></td>
			<td><c:out value="${result.orgGubunName }"/></td>
			<td><c:out value="${result.orgName}" /></td>
			<td><c:out value="${result.depName}" /></td>
			<td><c:out value="${result.memJob}" /></td>
			<td><c:out value="${result.emailStr}" /></td>
			<td><c:out value="${result.emailSubStr}" /></td>
			<td><c:out value="${result.receiveMailYn}" /></td>
			<td style='mso-number-format:"\@";'><c:out value="${result.telNoStr}"/></td>
			<td style='mso-number-format:"\@";'><c:out value="${result.hpNoStr}"/></td>
			<td style='mso-number-format:"Short Date";' ><c:out value="${result.lastLoginYmd}" /></td>
			<td><c:out value="${result.loginCnt}"/></td>
			
			
			
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="8" rowspan="16"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
