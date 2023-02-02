<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

  
	$(document).ready(function () {
    /* 타이틀 */
		$(document).attr("title", "Q&A > Q&A > Details : K-LINK");
	});

  /* 목록 */
  function fn_search() {
    var reqUrl = "/lu/qna/list";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }
  /* 수정 */
  function fn_modify(seq) {

    $("#bbsNoticeId").val(seq);

    var reqUrl = "/lu/qna/goUpdateBbs";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }
  /* 상세 조회 */
  function fn_detail(seq) {

    document.frmBbs.bbsSeq.value = seq;

    var reqUrl = "/lu/qna/detail";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }

  function fn_egov_downFile(bbsFileId, fileSn) {
    window.open("<c:url value='/commbiz/bbs/comBbsFileDown.do?importComBbsFileId=" + bbsFileId + "&importfileSn=" +
      fileSn + "'/>");
  }

  function fn_delete() {
    if (confirm("Do you want to delete?")) {
      var reqUrl = "/lu/qna/qnaDelete";
      $("#frmBbs").attr("action", reqUrl);
      $("#frmBbs").attr("target", "_self");
      $("#frmBbs").submit();
    }
  }
</script>

<form id="frmBbs" name="frmBbs" method="post" enctype="multipart/form-data">
  <input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>" />
  <input type="hidden" id="bbsNoticeId" name="bbsNoticeId" value="<c:out value='${result.bbsNoticeId}'/>" />
</form>

<div id="read">
  <div class="btn-box">
    <ul>
      <c:if test="${result.insertUser eq loginVO.memId}">
        <li><a href="#" onclick="javascript:fn_modify('${result.bbsNoticeId}');" class="btn-blue">Modify</a></li>
        <li><a href="#" onclick="javascript:fn_delete();" class="btn-blue">Delete</a></li>
      </c:if>
      <li><a href="#" class="btn-white" onclick="javascript:fn_search();">List</a></li>
    </ul>
  </div>
  <table>
    <caption class="sr-only">Q&A Content</caption>
    <tr>
      <th scope="row">Title</th>
      <td colspan="3">${result.title }</td>
    </tr>
    <tr class="mobile-none">
      <th scope="row">Register</th>
      <td>${result.insertUser}</td>
      <th scope="row">Register Date</th>
      <td>${result.insertDate}</td>
    </tr>

    <tr class="mobile-on">
      <th scope="row">Register</th>
      <td colspan="3">${result.insertUser}</td>
    </tr>
    <tr class="mobile-on">
      <th scope="row">Register Date</th>
      <td colspan="3">${result.insertDate}</td>
    </tr>

    <c:if test="${not empty fileList }">
      <tr>
        <th scope="row">Attached Files</th>
        <td colspan="3">
          <c:forEach var="fileList" items="${fileList }" varStatus="status">
            <a href="#"
              onclick="javascript:fn_egov_downFile('${fileList.bbsFileId}','${fileList.fileSn}');">${fileList.orgFileName}</a>
            <br />
          </c:forEach>
        </td>
      </tr>
    </c:if>

    <tr>
      <th scope="row">Question</th>
      <td colspan="3">
        <div class="text-read" style="white-space:pre;">
          <c:out value="${result.content}" escapeXml="false" />
        </div>
      </td>
    </tr>
    <tr>
      <th scope="row">Answer</th>
      <td colspan="3">
        <div class="text-read" style="white-space:pre;">
          <c:out value="${result.replyContent}" escapeXml="false" />
        </div>
      </td>
    </tr>
  </table>
  <div class="btn-box">
    <ul>
      <c:if test="${result.insertUser eq loginVO.memId}">
        <li><a href="#" class="btn-blue" onclick="javascript:fn_modify('${result.bbsNoticeId}');">Modify</a></li>
      </c:if>
      <li><a href="#" class="btn-white" onclick="javascript:fn_search();">List</a></li>
    </ul>
  </div>
</div><!-- E: read -->