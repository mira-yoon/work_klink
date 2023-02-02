<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<c:set var="targetUrl" value="/la/access/"/>
<script type="text/javascript">
<!--
	var targetUrl = "${targetUrl}"; 

	var pageSize = '${pageSize}'; //페이지당 그리드에 조회 할 Row 갯수;
	var totalCount = '${totalCount}'; //전체 데이터 갯수
	var pageIndex = '${pageIndex}'; //현재 페이지 정보

	$(document).ready(function() {

		if ('' == pageSize) {
			pageSize = 10;
		}
		if ('' == totalCount) {
			totalCount = 0;
		}
		if ('' == pageIndex) {
			pageIndex = 1;
		}

		loadPage();
	});

	/*====================================================================
		화면 초기화 
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}

	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/* 화면이 로드된후 처리 초기화 */
	function initHtml() {

		$("#pageSize").val(pageSize); //페이지당 그리드에 조회 할 Row 갯수;
		$("#pageIndex").val(pageIndex); //현재 페이지 정보
		$("#totalRow").text(totalCount);
		
	}

	/*====================================================================
		사용자 정의 함수 
	====================================================================*/

	function press(event) { 
	}

	/* 리스트 조회 */
	function fn_search( pageNo ){
		$("#pageIndex").val( pageNo );

		var reqUrl = CONTEXT_ROOT +  targetUrl+"listAccess";
		$("#frmMain").attr("action", reqUrl);
		$("#frmMain").submit();
	}
	/* 신규 페이지로 이동 */
	function fn_cret(){

		var reqUrl = CONTEXT_ROOT + targetUrl + "goInsertAccess";
		com.openPopup("accessIp", reqUrl, 700, 285, "CENTER");
		
	} 
	/* 신규 페이지로 이동 */
	function fn_detail(param){

		var reqUrl = CONTEXT_ROOT + targetUrl + "goUpdateAccess?comAccessId="+param;
		
		com.openPopup("accessIp", reqUrl, 700, 250, "CENTER");
		
	} 
	//-->
</script>
<form id="frmMain" name="frmMain"  method="post"> 


<!--ul class="board-info">
	<span>검색결과 : 총 </span><span id="totalRow">0</span><span> 건</span>
</ul --><!-- E : board-info -->

<table border="0" cellpadding="0" cellspacing="0" class="list-1">
	<thead>
		<tr>
			<th width="30px">번호</th>
			<th width="200px" >대상</th>
			<th width="*" >URL</th>
		</tr>
	</thead>
	<tbody>
	<!-- 로그가 있는경우 시작 -->
    <c:choose>
        <c:when test="${!empty resultList}">
          <c:forEach var="resultList" items="${resultList}"  varStatus="status">
            <tr>            
              <td>${status.count}</td>
              <td><a href="javascript:fn_detail('${resultList.comAccessId}');" >${resultList.accessName}</a></td>
			  <td><a href="javascript:fn_detail('${resultList.comAccessId}');" >${resultList.accessIp}</a></td>
            </tr>
          </c:forEach>
        </c:when>
        <c:otherwise>
        <c:if test="${empty resultList}">
          <tr>
            <td colspan="3">아이피가  없습니다.</td>
          </tr>
          </c:if>
        </c:otherwise>
    </c:choose>
    <!--  끝 -->

</tbody>
</table><!-- E : list -->

</form>
<div class="page-btn"> 
	<a href="#" onclick="javascript:fn_cret();">등록</a>
</div><!-- E : page-btn -->