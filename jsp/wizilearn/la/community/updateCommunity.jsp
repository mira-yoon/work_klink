<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
<!--

	var oEditors = [];
	var addFileCnt = 1; 
	
	$(document).ready(function() {
		initEditor();
	});
	function fn_validation(){
		var bbsTitle = $("#bbsTitle").val();
		 
			if(title != null && title != ""){
				fn_save();
			}else{
				alert("제목은 필수 입력사항 입니다.");
				return;
			} 
	}
	
	function fn_save(){ 
		var reqUrl = "/la/community/updateCommunity";		
		var data =oEditors.getById["content"].getIR();
		var text = data.replace(/[<][^>]*[>]/gi, "");
		if(text=="" && data.indexOf("img") <= 0){
			alert("내용은 필수 입력사항 입니다.");
			oEditors.getById["nttCn"].exec("FOCUS"); 
			return false;
		}
		$("#content").val(data);
		
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
		//var fileCount = $("#fileCount").val();
		//if(fileCount == null || fileCount == ''){
		//	fileCount = 0;
		//}
		//var fileCheck = addFileCnt +Number(fileCount); 
		//if(fileCheck < 3){
			addFileCnt += 1;
			var htmlText="";
			htmlText += "<input type=\"text\" id=\"file"+addFileCnt+"\" style=\"width:50%; margin-bottom:4px;\" readonly=\"readonly\">";
			htmlText += "<span style=\"display:inline; margin-left:2px;\">";
			htmlText += "<a href=\"#@\" class=\"checkfile\">파일선택</a>";
			htmlText += "<input type=\"file\" class=\"file_input_hidden\" name=\"file_atchFileId\"  id=\"file_atchFileId"+addFileCnt+"\"  onChange=\"javascript:checkFile('"+addFileCnt+"',this)\" />";
			htmlText += "</span>";
			htmlText += "<span id=\"fileSizeName"+addFileCnt+"\" style=\"margin-left:3px;\">0KB / 500M</span>";
			$("#fileaddhtml").append(htmlText);
		//}else{
		//	alert("첨부파일은 게시물당 최대 3개까지 등록가능합니다.");
		//}
	}
	
	/* 리스트 조회 */
	function fn_search(){		
		
		$("#courseCd").val("");
		
		var reqUrl = "/la/community/listCommunity";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	} 
	function fn_delete(){
		if(confirm("해당 글을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			fn_save()
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
	function fn_courseList(yearStr){
		
		var reqUrl = "/la/course/selectboxCourseList";
		if(yearStr==null || yearStr==""){
			alert("년도를 선택하세요");
			return;
		}else{
			$.ajax({
				url:reqUrl,
				type:"post",
				data:{ searchYear:yearStr },
				dataType:"json",
				success:function(data){
					var result = data.msg;
					var resultLists = data.resultList;
					if(result == "success"){		
						$("#courseCd option:first").remove();
						$("#courseCd").html("<option value='' >선택</option> ");
						for(var i=0; resultLists.length>i ; i++){
							$("#courseCd").append("<option value='"+resultLists[i].courseCd+"' >"+resultLists[i].title+"</option> ");
						}
					}else{
						alert("작업 진행중 오류가 발행하였습니다.");
					}
				},
				error:function(e){
					console.log("ERROR!!!!!!!!!!!");
				}
			});			
		}

	}
	

//-->
</script>
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<fmt:formatDate var="nowDate" value="${now}" pattern="yyyy"/>
    <fmt:formatNumber value="${nowDate}" type="number" pattern="0000" var="nowDateNumberType" />
 
<form id="frmBbs" name="frmBbs" method="post"  enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" /> 	 
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	<input type="hidden" id="bbsNoticeId" name="bbsNoticeId" value="${result.bbsNoticeId }"/>
	 <input type="hidden" id="bbsNoticeSort" name="bbsNoticeSort" value="1" />
	 
	<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
	<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tbody> 
<%-- //<c:when test="${fn:substring(result.year, 0, 4)  eq yearValStr}">  --%>
			<tr>
				<th  class="view-th"><font color="red">*</font>과정</th>
				<td class="view-td">
					<select name="searchYear" id="searchYear" class="selectype" onchange="javascript:fn_courseList(this.value);">
					<c:forEach var="yearVal" begin="0" end="20" varStatus="status">
					    <c:set var="yearValStr" value="${nowDateNumberType-yearVal}" />
						<c:choose>
							<c:when test="${result.searchYear eq yearValStr}">
								<option value="${yearValStr }" selected>${yearValStr }년</option>
							</c:when>
							<c:otherwise>
								<option value="${yearValStr }" >${yearValStr }년</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</select> 년도
								
					<select name="courseCd"  id="courseCd">
						<c:forEach var="courseList" items="${courseList}" varStatus="status">
							<option value="${courseList.courseCd}" <c:if test="${courseList.courseCd eq result.courseCd}" >selected</c:if> >${courseList.title}</option>
						</c:forEach>
					</select>
				</td>
			</tr>

			<tr>
				<th  class="view-th"><label for="title"><font color="red">*</font>제목</label></th>
				<td  class="view-td"><input type="text" name="title" id="bbsTitle" value="${result.title }" style="width:100%;"/></td>
			</tr>

			<tr>						
				<th  class="view-th"><label for="notiState_03"><font color="red">*</font>상태</label></th>
				<td  class="view-td">
					<input type="radio" id="notiState_03" name="useYn" value="Y" <c:if test="${result.useYn eq 'Y' }">checked</c:if>/>
					<label for="notiState_01" class="lms_lebel">노출</label>
					<input type="radio" id="notiState_04" name="useYn" value="N" <c:if test="${result.useYn eq 'N' }">checked</c:if> />
					<label for="notiState_02" class="lms_lebel">숨김</label>
				</td>
			</tr>
			<tr>
				<th  class="view-th"><font color="red">*</font>내용</th>
				<td  class="view-td">
					<textarea name="content" id="content" style="width:85%;"><c:out value="${result.content}" escapeXml = "false"/></textarea>
				</td>
			</tr>
			<tr>
				<th  class="view-th">첨부파일</th>
				<td  class="view-td">
					<input type="text" id="file1" style="width:50%;" readonly="readonly">
					<span style="display: inline;">
						<a href="#@" class="checkfile">파일선택</a>
						<input type="file" class="file_input_hidden" name="file_atchFileId"  id="file_atchFileId1"  onChange="javascript:checkFile('1',this)" />
					</span>
					<span id="fileSizeName1">0KB / 500M</span>
					<a href="#"  onclick="javascript:addFile();" class="btn">추가</a>
					<div id="fileaddhtml"></div>
					<br/>
					<c:import url="/commbiz/bbs/comBbsFileListImport.do" charEncoding="utf-8">
						<c:param name="param_bbsNoticeId" value="${result.bbsNoticeId}" />
						<c:param name="param_bbsTypeId" value="${result.bbsTypeId }"/>
						<c:param name="param_returnUrl" value="/la/community/goUpdateCommunity?menuId=${menuId}"/>
						<c:param name="param_delYn" value="Y"/>
						<c:param name="updateFlag" value="Y" />
					</c:import>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_validation();">수정</a>
	<a href="#!" onclick="fn_search();">목록</a>
	<a href="#!" onclick="fn_delete();">삭제</a>
</div>