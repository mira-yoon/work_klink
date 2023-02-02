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
		var bbsId = $("#bbsId").val();
		var reqUrl = "/la/bbs/"+bbsId+"/listBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
	
	/* 수정화면 */
	function fn_update(param){
		var bbsId = $("#bbsId").val();
		
		document.frmBbs.bbsNoticeId.value=param;
		
		var reqUrl = "/la/bbs/"+bbsId+"/goUpdateBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
</script>
<form id="frmBbs" name="frmBbs" method="post"  enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>">
	<input type="hidden" id="bbsId" name="bbsId" value="<c:out value='${bbsInfo.bbsId }'/>">
	<input type="hidden" id="bbsType" name="bbsType" value="<c:out value='${bbsInfo.bbsType}'/>">
	<input type="hidden" id="commentYn" name="commentYn" value="<c:out value='${bbsInfo.commentYn }'/>">
	<input type="hidden" id="fileYn" name="fileYn" value="<c:out value='${bbsInfo.fileYn }'/>">
	<input type="hidden" id="bbsSecertYn" name="bbsSecertYn" value="<c:out value='${bbsInfo.bbsSecertYn }'/>">
	
	<input type="hidden" id="bbsNoticeId" name="bbsNoticeId" value=""/>
	

	
	<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tbody>
			<tbody>
				<tr>
					<th width="100px" class="view-th" >작성자</th>
					<td class="view-td">${result.insertUser}</td>
					<th class="view-th" width="100px">작성일</th>
					<td class="view-td" >${result.insertDate}</td>
					<th class="view-th" width="100px">조회수</th>
					<td class="view-td" >${result.readCnt} 회</td>
				</tr>
				<tr>
					<th class="view-th">사용여부</th>
					<td class="view-td" colspan="5">
						<c:if test="${result.useYn eq 'N' }">숨김</c:if><c:if test="${result.useYn eq 'Y' }">노출</c:if>
					</td>
				</tr>
				<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000001' }">
					</tr>
						<th class="view-th">유형</th>
						<td class="view-td" colspan="5">
							<c:if test="${result.bbsNoticeSort eq '1' }">상단</c:if><c:if test="${result.bbsNoticeSort eq '2' }">일반</c:if>
						</td>
					</tr>
				</c:if>
				<tr>
					<th class="view-th">제목</th>
					<td class="view-td" colspan="5"><c:out value="${result.title }" /></td>
				</tr>
				<tr>
				<c:choose>
					<c:when test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
						<th class="view-th">질문내용</th>
					</c:when>
					<c:otherwise>
						<th class="view-th">내용</th>
					</c:otherwise>
				</c:choose>
					<td class="view-td" colspan="5" style="white-space:pre;overflow: -webkit-paged-y; padding:50px 70px; line-height:25px;">
						<c:out value="${result.content}" escapeXml = "false"/>
					</td>
				</tr>
				
				<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
					<tr>
						<th class="view-th">답변</th>
						<td  class="view-td" colspan="5">
							<textarea readonly><c:out value="${result.replyContent}"/></textarea>
						</td>
					</tr>
				</c:if>

				<tr>
					<th class="view-th">첨부파일</th>
					<td class="view-td" colspan="5">
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
	<a href="#!" onclick="fn_update('${result.bbsNoticeId}');">수정</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>