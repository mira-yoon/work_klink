<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

/* 타이틀 */
$(document).ready(function () {
	$(document).attr("title", "Q&A > Q&A > Modify : K-LINK");
});

function fn_save(){
	if(confirm("Do you want to register?")){
		var reqUrl = "/lu/qna/updateBbs";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target","_self");
		$("#frmBbs").submit();
	}
}

function fn_cancel(){
	var reqUrl = "/lu/qna/list";
	$("#frmBbs").attr("action", reqUrl);
	$("#frmBbs").attr("target","_self");
	$("#frmBbs").submit();	
}

 
function fn_modify(){
	
	var reqUrl = "/lu/qna/goUpdateBbs";
	$("#frmBbs").attr("action", reqUrl);
	$("#frmBbs").attr("target","_self");
	$("#frmBbs").submit();	
}

function checkFile(param,addFileCntStr){
	$("#file"+addFileCntStr).val($("#file_atchFileId"+addFileCntStr).val());
	
	var fileName = $("#file"+addFileCntStr).val();
	var bbsType = $("#bbsType").val();
	
	var fileExt = fileName.slice(fileName.indexOf(".")+1).toLowerCase();
	
	if(fileExt == "exe"){
		alert("This file type cannot be registered.");
		$("#file"+addFileCntStr).val("");
		return false;
	}
	
	var fileSize = param.files[0].size;
	
	if(fileSize > 10000000){
		alert("You can not upload more than 10M size.");
		$("#file"+addFileCntStr).val("");
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
		$("#fileSizeName"+addFileCntStr).html( filesizeNumber +" / 10M");
	}
}	

var addFileCnt = 1;
<c:forEach var="fileList" items="${fileList }" varStatus="status">
	addFileCnt = addFileCnt + 1;
</c:forEach>
function addFile(){
	//if(addFileCnt < 5){
	addFileCnt += 1;
	var htmlText="";
	htmlText += "<div class=\"input-file-box\">"
	htmlText += "<input class=\"upload-name\" type=\"text\" id=\"file" + addFileCnt + "\" disabled=\"disabled\" title=\"the file name\" aria-label=\"the file name\" />";
	htmlText += "<input type=\"file\" name=\"file_atchFileId\" id=\"file_atchFileId" + addFileCnt + "\" class=\"upload-hidden\" onChange=\"javascript: checkFile(this,'" + addFileCnt + "');\" aria-hidden=\"true\" />";
	htmlText += "<label for=\"file_atchFileId" + addFileCnt + "\">Upload</label>";
	htmlText += "<span id=\"fileSizeName" + addFileCnt + "\" title=\"the file size\" aria-label=\"the file size\">0KB / 10M</span>";
	htmlText += "</div>"
	
	$("#fileaddhtml").append(htmlText);
	//}else{
	//	alert("You can register up to 5 attachments at a time.");
	//}
}

function fn_egov_downFile(bbsFileId, fileSn){
	window.open("<c:url value='/commbiz/bbs/comBbsFileDown.do?importComBbsFileId="+bbsFileId+"&importfileSn="+fileSn+"'/>");
}

function fn_egov_deleteFile(bbsFileId, fileSn){
	if(confirm("Are you sure you want to delete this file?")){
	$.ajax({
		url:"/commbiz/bbs/comBbsFileDelete.do",
		type:"get",
		data:{"importComBbsFileId" : bbsFileId, "importfileSn" : fileSn},
		success:function(result){
			fn_modify();
		},
		error:function(e){
			console.log("ERROR!!!!!!!!!!!");
		}
	})
	}
}

// $label에 focus된 것 처럼 보이게 하기 (for 웹접근성)
$(document).on('focusin focusout', ".upload-hidden", function (e) {
	var $btnUpload = $(this);
	var $label = $btnUpload.parent().find("label");
	e.type == 'focusin' ? $label.addClass('file-focus') : $label.removeClass('file-focus');
});

</script>
	<div id="write">
		<div class="btn-box">
			<ul>
				<li><a href="#" onclick="javascript:fn_save();" class="btn-blue">Save</a></li>
				<li><a href="#" onclick="javascript:fn_cancel();" class="btn-white">Cancel</a></li>
			</ul>
		</div>
            
		<form id="frmBbs" name="frmBbs" method="post"  enctype="multipart/form-data" >
			<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" /> 	 
			<input type="hidden" id="bbsId" name="bbsId" value="<c:out value='${bbsInfo.bbsId }'/>" />
			<input type="hidden" id="bbsType" name="bbsType" value="<c:out value='${bbsInfo.bbsType}'/>" />
			<input type="hidden" id="commentYn" name="commentYn" value="<c:out value='${bbsInfo.commentYn }'/>" />
			<input type="hidden" id="fileYn" name="fileYn" value="<c:out value='${bbsInfo.fileYn }'/>" />
			<input type="hidden" id="bbsSecertYn" name="bbsSecertYn" value="<c:out value='${bbsInfo.bbsSecertYn }'/>" />
			<input type="hidden" name="bbsCompanyIdArr"  value="<c:out value='${siteId }'/>"/> 
			<input type="hidden" id="deleteYn" name="deleteYn" value="N" />
			<input type="hidden" id="bbsNoticeId" name="bbsNoticeId" value="${result.bbsNoticeId }" />

			<table>
				<caption class="sr-only">Modify Q&A</caption>
				<tr>
					<th scope="row">Title</th>
					<td><input type="text" title="Enter the title" name="title" aria-label="Enter the title" value="${result.title }" /></td>
				</tr>

				<tr>
					<td colspan="2">
						<div class="text-write">
						<textarea name="content" id="content" title="Write down the content here." aria-label="Write down the content here.">${result.content }</textarea>
						</div>
					</td>
				</tr>
			</table>
					
			<div class="file">
				<c:if test="${not empty fileList }">
				<div class="upload">
						<c:forEach var="fileList" items="${fileList }" varStatus="status">
							<span>${fileList.orgFileName}</span>
							<a href="#" onclick="javascript:fn_egov_deleteFile('${fileList.bbsFileId}','${fileList.fileSn}')" ><i class="fa fa-times-circle"></i></a><br />
						</c:forEach>                
				</div>
				</c:if>
				<c:if test="${fn:length(fileList)<5 }">

				<div class="input-file" id="fileaddhtml">
					<div class="input-file-box">
						<input class="upload-name" type="text" id="file1" disabled="disabled" title="the file name" aria-label="the file name" />
						<input type="file" accept="image/*" name="file_atchFileId" id="file_atchFileId1" class="upload-hidden" onChange="javascript: checkFile(this,'1');" aria-hidden="true" />
						<label for="file_atchFileId1">Upload</label>
						<span id="fileSizeName1" title="the file size" aria-label="the file size">0KB / 10M</span>
					</div>
				</div>
				<a href="#" onclick="javascript:addFile();" class="btn-blue"> ADD </a>

				</c:if>
			</div>            
		</form>            
</div><!-- E : write --> 

