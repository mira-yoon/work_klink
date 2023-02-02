<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	$(document).ready(function(){
		//input 숫자만 허용
		$("input:text[numberonly]").on("keyup", function() {
	 	  $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	});
	
	function fn_validation(){
		var orgName = $("#orgName").val();
		var orgNameFull = $("#orgNameFull").val();
		var orgStep = $("#orgStep").val();
		var orgUrl = $("#orgUrl").val();
		
		if(orgName == ''){
			alert("기관명을 입력해 주세요.");
			$("input[name=orgName]").focus();
			return;
		}
		if(orgNameFull == ''){
			alert("기관명(전체)를 입력해 주세요.");
			$("input[name=orgNameFull]").focus();
			return;
		}
		if(orgStep == ''){
			alert("정렬순서를 입력해 주세요.");
			$("input[name=orgStep]").focus();
			return;
		}
		if(orgUrl == ''){
			alert("기관 홈페이지를 입력해 주세요.");
			$("input[name=orgUrl]").focus();
			return;
		}
		fn_save();
	}
	
	function fn_save(){
		var reqUrl = "/la/organization/insertOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
	/* 리스트 조회 */
	function fn_search(){		 
		var reqUrl = "/la/organization/listOrganization";
		$("#frmOrganization").attr("action", reqUrl);
		$("#frmOrganization").attr("target","_self");
		$("#frmOrganization").submit();
	}
	function checkFile(idx, param){
		
		$("#file"+idx).val($("#file_atchFileId"+idx).val());
		
		var fileName = $("#file"+idx).val();
		var bbsType = $("#bbsType").val();
		
		var fileExt = fileName.slice(fileName.indexOf(".")+1).toLowerCase();
		
		if(fileExt == "exe"){
			alert("등록할 수 없는 파일 형식입니다.");
			$("#file"+idx).val("");
			return false;
		}
		
		var fileSize = param.files[0].size;
		
		if(fileSize > 10000000){
			alert("전체 사이즈 10M이상 업로드 할수 없습니다.");
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
			$("#fileSizeName"+idx).html( filesizeNumber +" / 10M");
		}
	}
</script>
<form id="frmOrganization" name="frmOrganization" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"> 
	<div class="title-name-1">기관관리 등록</div>
	<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>첨부파일</th>
				<td id="fileaddhtml">
					<input type="text" id="file1" style="width:50%;" readonly="readonly">
					<span style="display: inline;">
						<a href="#@" class="checkfile">파일선택</a>
						<input type="file" class="file_input_hidden" name="file_atchFileId"  id="file_atchFileId1" accept="image/*" onChange="javascript:checkFile('1',this)" />
					</span>
					<span id="fileSizeName1">0KB / 10M</span>
				</td>
			</tr>
			<tr>  
				<th><font color="red">*</font>정렬순서</th>
				<td><input type="text" id="orgStep" name="orgStep" numberOnly=""/></td>
			</tr>
			<tr>
				<th><font color="red">*</font>기관명</th>
				<td><input type="text" id="orgName" name="orgName" value="" maxlength="40"/></td>
			</tr>
			<tr>
				<th><font color="red">*</font>기관명(전체)</th>
				<td><input type="text" id="orgNameFull" name="orgNameFull" value="" maxlength="40"/></td>
			</tr>
			<tr>  
				<th><font color="red">*</font>기관 홈페이지</th>
				<td><input type="text" id="orgUrl" name="orgUrl" value=""/></td>
			</tr>  
			<tr>
				<th><font color="red">*</font>상태</th>
				<td>
					<input type="radio" name="useYn" value="Y" checked/>공개
					<input type="radio" name="useYn" value="N"/>비공개
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_validation();">저장</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>