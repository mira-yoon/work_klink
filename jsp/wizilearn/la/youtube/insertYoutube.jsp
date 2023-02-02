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
		initEditor();
	});
	
	/* 목록 */
	function fn_search(){
		var reqUrl = "/la/youtube/listYoutube";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target","_self");
		$("#frmUTub").submit();
	}
	/* 등록 */
	function fn_save(){
		var reqUrl = "";
		var checkType = $("input[name='youtubeType']:checked").val();
		if(checkType == "url"){
			var data =oEditors.getById["content"].getIR();
			var text = data.replace(/[<][^>]*[>]/gi, "");
			if(text=="" && data.indexOf("img") <= 0){
				alert("컨텐츠 소개를 입력해 주세요.");
				oEditors.getById["content"].exec("FOCUS"); 
				return
			}
			$("#youtubeDesc").val(data);
		}else{
			$("#youtubeDesc").val($("#contentYoutube").val());
		}
		
		if($("#youtubeTitle").val() == ""){
			alert("유튜브 명을 입력해 주세요.");
			$("#youtubeTitle").focus();
			return
		}
		if(checkType == "url"){
			if($("#youtubeUrl").val() == ""){
				alert("유튜브 URL을 입력해 주세요.");
				$("#youtubeUrl").focus();
				return
			}
			reqUrl = "/la/youtube/insertYoutube";
		}else{
			if($("#file").val() == ""){
				alert("동영상을 등록해 주세요.");
				return
			}
			reqUrl = "/la/youtube/insertYoutubeMovie";
		}
		
		if(confirm("입력한 정보를 등록하시겠습니까?")){
			$("#frmUTub").attr("action", reqUrl);
			$("#frmUTub").attr("target","_self");
			$("#frmUTub").submit();
		}
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
	
	function fn_choice(param){
		if(param === "url"){
			$(".urlYoutube").show();
			$(".movieYoutube").hide();
		}else{
			$(".urlYoutube").hide();
			$(".movieYoutube").show();
		}
	}
	
	function checkFile(idx, param){
		$("#file").val($("#file_atchFileId").val());
		var fileName = $("#file").val();
		var fileExt = fileName.slice(fileName.indexOf(".")+1).toLowerCase();
		if(fileExt == "exe"){
			alert("등록할 수 없는 파일 형식입니다.");
			$("#file").val("");
			return false;
		}
		var fileSize = param.files[0].size;
		var filesizeNumber = "";
		if(fileSize>1000000){
			filesizeNumber = ((fileSize/1000000).toFixed(2))+" M";
		}else if(fileSize>1000){
			filesizeNumber = ((fileSize/1000).toFixed(2))+" KB";
		}else{
			filesizeNumber = fileSize+" B";
		}
		$("#fileSizeName").html( filesizeNumber);
	}
	
	function checkThumb(idx, param){
		$("#file"+idx).val($("#file_atchFileId"+idx).val());
		var fileName = $("#file"+idx).val(); 
		var fileExt = fileName.slice(fileName.indexOf(".")+1).toLowerCase();
		if(!(fileExt == "gif" || fileExt == "jpg" || fileExt == "png" || fileExt == "jpeg" || fileExt == "bmp")){
			alert("파일 형식은 이미지만 가능합니다.");
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
	}
</script>
<form id="frmUTub" name="frmUTub" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>">
	<input type="hidden" id="youtubeDesc" name="youtubeDesc" value=""/>
	<div class="title-name-1">카테고리 등록</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>등록 타입</th>
				<td>
					<input type="radio" name="youtubeType" value="url" onchange="javascript:fn_choice(this.value);" checked/> URL 등록&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="youtubeType" value="video" onchange="javascript:fn_choice(this.value);"/> 유튜브 업로드
				</td>
			</tr>
			<tr>
				<th>유튜브 제목</th>
				<td>
					<input type="text" id="youtubeTitle" name="youtubeTitle" value="" style="width: 100%;"/>
				</td>
			</tr>
			<tr class="urlYoutube">
				<th>유튜브 URL</th>
				<td>
					<input type="text" id="youtubeUrl" name="youtubeUrl" value="" style="width: 100%;"/>
				</td>
			</tr>
			<tr class="movieYoutube" style="display:none;">
				<th>유튜브 영상</th>
				<td>
					<input type="text" id="file" style="width:50%;" readonly="readonly">
					<span style="display: inline;">
						<a href="#@" class="checkfile">파일선택</a>
						<input type="file" accept="video/*" class="file_input_hidden" name="file_atchFileId"  id="file_atchFileId"  onChange="javascript:checkFile('1',this)" />
					</span>
					<span id="fileSizeName">0KB</span>
				</td>
			</tr>
			<tr>
				<th  class="view-th">썸네일</th>
				<td  class="view-td" id="fileaddhtml">
					<input type="text" id="file1" style="width:50%;" readonly="readonly">
					<span style="display: inline;">
						<a href="#@" class="checkfile">파일선택</a>
						<input type="file" accept="image/*" class="file_input_hidden" name="file_atchFileId"  id="file_atchFileId1"  onChange="javascript:checkThumb('1',this)" />
						
					</span>
					<span id="fileSizeName1">0KB / 500M</span>
				</td>
			</tr>
			<tr class="urlYoutube">
				<th>유튜브 소개</th>
				<td>
					<textarea name="content" id="content" style="width:85%;"></textarea>
				</td>
			</tr>
			<tr class="movieYoutube" style="display:none;">
				<th>유튜브 소개</th>
				<td>
					<textarea name="contentYoutube" id="contentYoutube" style="width:85%;"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="javascript:void(0);" onclick="fn_save();">저장</a>
	<a href="javascript:void(0);" onclick="fn_search();">목록</a>
</div>