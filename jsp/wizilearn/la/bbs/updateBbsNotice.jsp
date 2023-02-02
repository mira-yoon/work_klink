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
	var addFileCnt = 1;
	var bbsType = '${bbsInfo.bbsType}';
	var bbsInfoId = '<c:out value="${bbsInfo.bbsId}"/>';
	
	$(document).ready(function() {
		initEditor();
		
 
		
	});
	function fn_validation(param){
		var bbsTitle = $("#bbsTitle").val();
		if(bbsInfoId == 'BBSMSTR_0000004'){
		var replyContent = $("#replyContent").val();
		}
			if(bbsTitle == ""){
				alert("제목은 필수 입력사항 입니다.");
				return;
			}else if (bbsInfoId == 'BBSMSTR_0000004' && replyContent == ""){
				alert("답변은 필수 입력사항 입니다.");
				return;
			}else {
				fn_save(param);
			}
			
	}
	
	function fn_save(param){
		var bbsId = $("#bbsId").val();
		var reqUrl = "/la/bbs/"+bbsId+"/updateBbsNotice";
		var replyYn = "";
		var replyContent = $("#replyContent").val();
		
		document.frmBbs.bbsNoticeId.value=param;
		
		if(bbsInfoId == 'BBSMSTR_0000004'){
			if(replyContent != null){
				replyYn = 'Y';
			}
			if(replyContent == ""){
				replyYn = 'N';
			}
			$("#replyYn").val(replyYn);
		} else {
			var data =oEditors.getById["content"].getIR();
			var text = data.replace(/[<][^>]*[>]/gi, "");
			if(text=="" && data.indexOf("img") <= 0){
				alert("내용은 필수 입력사항 입니다.");
				oEditors.getById["nttCn"].exec("FOCUS"); 
				return false;
			}
			$("#content").val(data);
		}
		
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}

	/* 화면이 로드된후 에디터 기본옵션 설정 초기화 */ 
	function initEditor() {
		//Smart Editor
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "content",
			sSkinURI: "/smarteditor/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,
				bUseVerticalResizer : true,
				bUseModeChanger : true,
				fOnBeforeUnload : function(){
				}
			},
			fOnAppLoad : function(){
				//oEditors.getById["textAreaContent"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
	}
	
	function addFile(){
		var fileCount = $("#fileCount").val();
		if(fileCount == null || fileCount == ''){
			fileCount = 0;
		}
		var fileCheck = addFileCnt +Number(fileCount); 
		if(fileCheck < 3){
			addFileCnt += 1;
			var htmlText="";
			htmlText += "<input type=\"text\" id=\"file"+addFileCnt+"\" style=\"width:50%; margin-bottom:4px;\" readonly=\"readonly\">";
			htmlText += "<span style=\"display:inline; margin-left:2px;\">";
			htmlText += "<a href=\"#@\" class=\"checkfile\">파일선택</a>";
			htmlText += "<input type=\"file\" class=\"file_input_hidden\" name=\"file_atchFileId\"  id=\"file_atchFileId"+addFileCnt+"\"  onChange=\"javascript:checkFile('"+addFileCnt+"',this)\" />";
			htmlText += "</span>";
			htmlText += "<span id=\"fileSizeName"+addFileCnt+"\" style=\"margin-left:3px;\">0KB / 500M</span>";
			$("#fileaddhtml").append(htmlText);
		}else{
			alert("첨부파일은 게시물당 최대 3개까지 등록가능합니다.");
		}
		 
	}
	
	/* 리스트 조회 */
	function fn_search(){		
		var bbsId = $("#bbsId").val();
		var reqUrl = "/la/bbs/"+bbsId+"/listBbsNotice";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	} 
	function fn_delete(param){
		if(confirm("해당 글을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			fn_save(param)
		}
	}
	
	function checkFile(idx, param){
		var fileCount = $("#fileCount").val();
		if(fileCount == null || fileCount == ''){
			fileCount = 0;
		}else{
			Number(fileCount);
		} 
		if(fileCount < 3){
			$("#file"+idx).val($("#file_atchFileId"+idx).val());
			
			var fileName = $("#file"+idx).val();
			
			var fileExt = fileName.slice(fileName.indexOf(".")+1).toLowerCase();
			
			if(fileExt == "exe"){
				alert("등록할 수 없는 파일 형식입니다.");
				$("#file"+idx).val("");
				return false;
			}
			
			var fileSize = param.files[0].size;
			
			if(fileSize > 500000000){
				alert("전체 사이즈 500M이상 업로드 할수 없습니다.");
				$("#file"+idx).val("");
				return false;
			}else{
				var filesizeNumber = "";
				if(fileSize>1000000){
					filesizeNumber = ((fileSize/1000000).toFixed(2))+" M";
				}else if(fileSize>1000){
					filesizeNumber = ((fileSize/1000).toFixed(2))+" KB";
				}else{
					filesizeNumber = fileSize+" B";
				}
				$("#fileSizeName"+idx).html( filesizeNumber +" / 500M");
			}
		}else{
			alert("첨부파일은 게시물당 최대 3개까지 등록가능합니다."); 
			$("#file_atchFileId"+idx).val("");
			return false;
		}
		 
	}
</script>
<form id="frmBbs" name="frmBbs" method="post"  enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" /> 	 
	<input type="hidden" id="bbsId" name="bbsId" value="<c:out value='${bbsInfo.bbsId }'/>">
	<input type="hidden" id="bbsType" name="bbsType" value="<c:out value='${bbsInfo.bbsType}'/>">
	<input type="hidden" id="commentYn" name="commentYn" value="<c:out value='${bbsInfo.commentYn }'/>">
	<input type="hidden" id="fileYn" name="fileYn" value="<c:out value='${bbsInfo.fileYn }'/>">
	<input type="hidden" id="bbsSecertYn" name="bbsSecertYn" value="<c:out value='${bbsInfo.bbsSecertYn }'/>">
	<input type="hidden" name="bbsCompanyIdArr"  value="<c:out value="${siteId }" />" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="bbsNoticeId" name="bbsNoticeId" value=""/>
	<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
		<input type="hidden" id="replyYn" name="replyYn" value=""/>
	</c:if>
	
	<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
	<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tbody> 
			<tr>
				<th  class="view-th"><label for="title"><font color="red">*</font>제목</label></th>
				<td  class="view-td"><input type="text" name="title" id="bbsTitle" value="${result.title }" style="width:100%;"/></td>
			</tr>
			<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000001' }">
				<tr>
					<th  class="view-th"><label for="notiState_01"><font color="red">*</font>상단공지</label></th>
					<td  class="view-td">
						<input type="radio" id="notiState_01" name="bbsNoticeSort" value="1" <c:if test="${result.bbsNoticeSort eq '1' }">checked</c:if>/>
						<label for="notiState_01" class="lms_lebel">상단공지</label>
						<input type="radio" id="notiState_02" name="bbsNoticeSort" value="2" <c:if test="${result.bbsNoticeSort eq '2' }">checked</c:if> />
						<label for="notiState_02" class="lms_lebel">일반공지</label>
					</td>
				</tr>	
			</c:if>
			<tr>						
				<th  class="view-th"><label for="notiState_03"><font color="red">*</font>상태</label></th>
				<td  class="view-td">
					<input type="radio" id="notiState_03" name="useYn" value="Y" <c:if test="${result.useYn eq 'Y' }">checked</c:if>/>
					<label for="notiState_01" class="lms_lebel">노출</label>
					<input type="radio" id="notiState_04" name="useYn" value="N" <c:if test="${result.useYn eq 'N' }">checked</c:if> />
					<label for="notiState_02" class="lms_lebel">숨김</label>
				</td>
			</tr>
			<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000005' }">
				<tr>
					<th  class="view-th"><font color="red">*</font>게시기간</th>
					<td  class="view-td">
						<input type="text" name="startDate" id="startDate"  value="${result.startDate}" style="width:80px;" /> ~
						<input type="text" name="endDate" id="endDate"  value="${result.endDate}" style="width:80px;" />
					</td>
				</tr>
			</c:if>
			<tr>
			<c:choose>
				<c:when test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
					<th  class="view-th">질문내용</th>
					<td  class="view-td">
						<%-- <div class="text-read" style="white-space:pre;"><c:out value="${result.content}" escapeXml = "false"/></div> --%>
						<textarea name="content"><c:out value="${result.content}" escapeXml = "false"/></textarea>
					</td>
				</c:when>
				<c:otherwise>
					<th  class="view-th"><font color="red">*</font>내용</th>
					<td  class="view-td">
						<textarea name="content" id="content" style="width:85%;"><c:out value="${result.content}" escapeXml = "false"/></textarea>
					</td>
				</c:otherwise>
			</c:choose>
			</tr>
			<c:if test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
			<tr>
				<th class="view-th"><font color="red">*</font>답변</th>
				<td  class="view-td">
					<textarea name="replyContent" id="replyContent"><c:out value="${result.replyContent}"/></textarea>
				</td>
			</tr>
			</c:if>
			<tr>
				<th  class="view-th">첨부파일</th>
				<td  class="view-td">
					<input type="text" id="file1" style="width:50%;" readonly="readonly">
					<span style="display: inline;">
						<a href="#@" class="checkfile">파일선택</a>
						<input type="file" class="file_input_hidden" name="file_atchFileId"  id="file_atchFileId1"  onChange="javascript:checkFile('1',this)" />
					</span>
					<span id="fileSizeName1">0KB / 10M</span>
					<a href="#"  onclick="javascript:addFile();" class="btn">추가</a>
					<div id="fileaddhtml"></div>
					<br/>
					<c:import url="/commbiz/bbs/comBbsFileListImport.do" charEncoding="utf-8">
						<c:param name="param_bbsNoticeId" value="${result.bbsNoticeId}" />
						<c:param name="param_bbsTypeId" value="${result.bbsTypeId }"/>
						<c:param name="param_returnUrl" value="/la/bbs/${bbsInfo.bbsId}/goUpdateBbsNotice?menuId=${menuId}"/>
						<c:param name="param_delYn" value="Y"/>
						<c:param name="updateFlag" value="Y" />
					</c:import>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<c:choose>
		<c:when test="${bbsInfo.bbsId eq 'BBSMSTR_0000004' }">
			<a href="#!" onclick="fn_validation('${result.bbsNoticeId}');">수정 및 답변</a>
		</c:when>
		<c:otherwise>
			<a href="#!" onclick="fn_validation('${result.bbsNoticeId}');">수정</a>
		</c:otherwise>
	</c:choose>
	<a href="#!" onclick="fn_search();">목록</a>
	<a href="#!" onclick="fn_delete('${result.bbsNoticeId}');">삭제</a>
</div>