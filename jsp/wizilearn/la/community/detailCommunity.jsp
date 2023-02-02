<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
<!--
	var oEditors = [];
	$(document).ready(function() {

	}); 
	
	function initEditor() {
		//Smart Editor
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "bbsContent",
			sSkinURI: "/smarteditor/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : false,
				bUseVerticalResizer : false,
				bUseModeChanger : false,
				fOnBeforeUnload : function(){
				}
			}, 
			fOnAppLoad : function(){
				//oEditors.getById["bbsContent"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
	}
	
	/* 리스트 조회 */
	function fn_search(){
		$("#courseCd").val("");
		var reqUrl = "/la/community/listCommunity";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	
	/* 수정화면 */
	function fn_update( ){
		var reqUrl = "/la/community/goUpdateCommunity";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}

//-->
</script>
<form id="frmBbs" name="frmBbs" method="post"  enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>" />
	<input type="hidden" id="bbsNoticeId" name="bbsNoticeId" value="${result.bbsNoticeId }" />
	<input type="hidden" id="courseCd" name="courseCd" value="<c:out value='${result.courseCd}'/>" />
	
	<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tbody>
			<tbody>
			
				<tr>
					<th width="100px" class="view-th" >과정</th>
					<td  class="view-td" colspan="3" ><c:out value="${result.courseNm}" /></td>
				</tr>
				
				<tr>
					<th class="view-th">제목</th>
					<td class="view-td" colspan="3"><c:out value="${result.title }" /></td>
				</tr>
				
				<tr>
					<th class="view-th" >작성자</th>
					<td class="view-td">${result.insertUser}</td>
					<th class="view-th" width="100px">작성일</th>
					<td class="view-td" >${result.insertDate}</td>

				</tr>
				
				<tr>
					<th class="view-th">사용여부</th>
					<td class="view-td" >
						<c:if test="${result.useYn eq 'N' }">숨김</c:if><c:if test="${result.useYn eq 'Y' }">노출</c:if>
					</td>
					<th class="view-th" width="100px">조회수</th>
					<td class="view-td" >${result.readCnt} 회</td>
				</tr>
								
				<tr>
						<th class="view-th">내용</th>
						<td class="view-td" colspan="3" style="overflow: -webkit-paged-y; padding:50px 70px; line-height:25px;">
							<c:out value="${result.content}" escapeXml = "false"/>
						</td>
				</tr>

				<tr>
					<th class="view-th">첨부파일</th>
					<td class="view-td" colspan="3">
						<c:import url="/commbiz/bbs/comBbsFileListImport.do" charEncoding="utf-8">
							<c:param name="param_bbsNoticeId" value="${result.bbsNoticeId}" />
							<c:param name="param_bbsTypeId" value="${result.bbsTypeId }"/>
							<c:param name="param_delYn" value="N"/>
						</c:import>
					</td>
				</tr>
			</tbody>
		</tbody> 
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_update();">수정</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>