<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
page import="kr.co.wizi.wizilearn.comm.service.EgovProperties" %> <%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
<!-- 
	$(document).ready(function() {  
	});
 
	function fn_save(){
	
		var reqUrl = CONTEXT_ROOT +"/la/content/goUpdateComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
		
	}
 	 
	/* 리스트 조회 */
	function fn_search(){		 
		var reqUrl = "/la/content/listComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
	}
  	function fn_view(contentSeq){
  		$("#recontentSeq").val(contentSeq);
		var reqUrl = "<%=EgovProperties.getProperty("Globals.user.domain")%>lu/content/preview";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_blank");
		$("#frmComContent").submit();
  	}
  	function fn_preview(contentSeq){
  		$("#recontentSeq").val(contentSeq);
		var reqUrl = "<%=EgovProperties.getProperty("Globals.user.domain")%>lu/content/preview";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_blank");
		$("#frmComContent").submit();
  	}
  	function fn_restoration(contentSeq){
  		$("#recontentSeq").val(contentSeq);
		var reqUrl = "/la/content/restoration";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
  	}
//-->
</script>
<div class="info">
<form id="frmComContent" name="frmComContent" method="post"   >
	<input type="hidden" id="menuId" name="menuId" value="${comContentVO.menuId}" />  
	<input type="hidden" id="pageIndex" name="pageIndex" value="${comContentVO.pageIndex}" /> 	 
	<input type="hidden" id="contentId" name="contentId" value="${result.contentId}" />
	<input type="hidden" id="contentSeq" name="contentSeq" value="${result.contentSeq}" />
	<input type="hidden" id="recontentSeq" name="recontentSeq"  />
	<div class="data-table box-area td-cne">
	<h3>기본정보</h3>
				<table class="view-2">
					<colgroup>
						<col style="width:180px" />
						<col style="width:*" />
					</colgroup>
					<tbody>
					
						<tr>
							<th><label for="title">아이디</label></th>
							<td>${result.contentId}</td>
						</tr> 
						
						<tr>
							<th><label for="title">제목</label></th>
							<td>${result.contentName}</td>
						</tr> 
						<tr>
							<th><label for="title">등록일</label></th>
							<td><c:out value="${result.insertDate}"/></td>
						</tr> 
						<tr>
							<th><label for="content">내용</label></th>
							<td>${result.contentDesc}</td>
						</tr>
						   
					</tbody>
				</table>
</form>
						<div class="page-btn btn-box">
							<a  href="#!" class="btn-blue btn-lg" onclick="javascript:fn_preview('${result.contentSeq}');">미리보기</a>
							<a  href="#!" class="btn-blue btn-lg" onclick="javascript:fn_save();">수정</a>
							<a  href="#!" class="btn-white btn-lg" onclick="javascript:fn_search();">목록</a>
						</div>
			</div>
<div class="data-table box-area">
<h3>변경이력</h3>
<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="" >제목</th>
			<th width="15%" >등록일</th>			
			<th width="10%" >등록자</th>
			<th width="15%" >수정일</th>
			<th width="10%" >수정자</th>			
			<th width="10%" >보기</th>
			<th width="10%" >복원</th>
		</tr>
	</thead>
	<tbody>
	<!-- 로그가 있는경우 시작 -->
    <c:choose>
        <c:when test="${!empty resultList}">
          <c:forEach var="resultList" items="${resultList}"  varStatus="status">
            <tr>            
			  <td><c:out value="${resultList.contentName }"/></td>
              <td><c:out value="${resultList.insertDate }"/></td>
			  <td><c:out value="${resultList.insertUserName }"/></td>
              <td><c:out value="${resultList.updateDate }"/></td>
			  <td><c:out value="${resultList.updateUserName }"/></td>			  
              <td><a href="javascript:fn_view('${resultList.contentSeq}');"  class="btn-1" >보기버튼</a> </td>
              <td><a href="javascript:fn_restoration('${resultList.contentSeq}');" class="btn-1" >복원</a> </td>
            </tr>
          </c:forEach>
        </c:when>
        <c:otherwise>
        <c:if test="${empty resultList}">
          <tr>
            <td colspan="7">등록된 컨텐츠가 없습니다.</td>
          </tr>
          </c:if>
        </c:otherwise>
    </c:choose>
    <!--  끝 -->

</tbody>
</table><!-- E : list -->						
</div>		 