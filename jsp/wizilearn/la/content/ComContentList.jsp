<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<script type="text/javascript">
<!-- 

	var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
	var totalCount = '${totalCount}'; //전체 데이터 갯수
	var pageIndex = '${pageIndex}'; //현재 페이지 정보

	$(document).ready(function() {
  
	});

 
	/* 리스트 조회 */
	function fn_search( pageNo ){
		$("#pageIndex").val( pageNo );

		var reqUrl = CONTEXT_ROOT + "/la/content/listComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").submit();
	} 
	function fn_save(){
		
		var reqUrl = CONTEXT_ROOT + "/la/content/goInsertComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
		
	}
	function fn_update(contentSeq){
		$("#contentSeq").val( contentSeq );
		var reqUrl = CONTEXT_ROOT + "/la/content/goUpdateComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
		
	}
	function fn_detail(contentSeq){
		$("#contentSeq").val( contentSeq );
		var reqUrl = CONTEXT_ROOT +   "/la/content/goDetailComContent";
		$("#frmComContent").attr("action", reqUrl);
		$("#frmComContent").attr("target","_self");
		$("#frmComContent").submit();
		
	}
	//-->
</script>
<div class="process-manage">
<form id="frmComContent" name="frmComContent"  method="post">
<div class="search-box box-area"> 
	<input type="hidden" id="menuId" name="menuId" value="${comContentVO.menuId}" />
	<input type="hidden" id="contentSeq" name="contentSeq"  />
	 
	<input type="hidden" id="pageIndex" name="pageIndex" value="${comContentVO.pageIndex}" /> 
		
	
	
		
	<label>아이디/제목</label>
	<input type="text" name="searchKeyword" id="searchKeyword" value="${comContentVO.searchKeyword }" /><input type="button" value="조회" onclick="javascript:fn_search(1);">
	</div>
	<div class="page-btn btn-box"> 
	  <a href="#" class="btn-blue btn-lg-x2" onclick="javascript:fn_save();">등록</a>
    </div><!-- E : page-btn -->
	<div class="data-table box-area">
	<ul class="board-info">
		<li class="info-area">총<span> <c:out value="${paginationInfo.totalRecordCount}" /></span>건 </li>
		<li class="btn-area">
			<select name="pageSize"   id="pageSize" title="목록 갯수 설정하기" onchange="fn_search(1)">
				<option value="10" <c:if test="${comContentVO.pageSize=='10' }" > selected</c:if> >10 개</option>
				<option value="20" <c:if test="${comContentVO.pageSize=='20' }" > selected</c:if> >20 개</option>
				<option value="30" <c:if test="${comContentVO.pageSize=='30' }" > selected</c:if> >30 개</option>
				<option value="50" <c:if test="${comContentVO.pageSize=='50' }" > selected</c:if> >50 개</option>
			</select>
		</li>
	</ul><!-- E : table-title -->

</form>

<table class="list-1">
	<thead>
		<tr>
			<th width="10%">번호</th>
			<th width="10%" >아이디</th>
			<th width="*" >제목</th>
			<th width="15%" >등록일</th>
			<th width="10%" >등록자</th>
			<th width="10%" >수정</th>
		</tr>
	</thead>
	<tbody>
	<!-- 로그가 있는경우 시작 -->
    <c:choose>
        <c:when test="${!empty resultList}">
          <c:forEach var="resultList" items="${resultList}"  varStatus="status">
            <tr>            
              <td><c:out value="${paginationInfo.totalRecordCount - ((comContentVO.pageIndex-1) * comContentVO.pageSize + status.index)}"/></td>
              <td><a href="javascript:fn_detail('${resultList.contentSeq}');"><c:out value="${resultList.contentId }"/></a></td>
			  <td><a href="javascript:fn_detail('${resultList.contentSeq}');"><c:out value="${resultList.contentName }"/></a></td>
              <td><c:out value="${resultList.insertDate }"/></td>
			  <td><c:out value="${resultList.insertUserName }"/></td>
              <td><a class="btn-1" href="javascript:fn_update('${resultList.contentSeq}');" >수정</a> </td>
            </tr>
          </c:forEach>
        </c:when>
        <c:otherwise>
        <c:if test="${empty resultList}">
          <tr>
            <td colspan="6">등록된 컨텐츠가 없습니다.</td>
          </tr>
          </c:if>
        </c:otherwise>
    </c:choose>
    <!--  끝 -->

</tbody>
</table><!-- E : list -->
<div id="number">
  <ul>
	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
  </ul> 
</div><!-- E : page-num -->
</div>

</div>