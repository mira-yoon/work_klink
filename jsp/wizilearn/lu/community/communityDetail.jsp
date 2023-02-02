<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

  $(document).ready(function() {
    /* 타이틀 */
    $(document).attr("title","Community > Community > Daily List > Details : K-LINK");
  });

  function fn_savecomment() {
    if ($("textarea[name='content']").val() == '') {
      $("textarea[name='content']").focus();
      return false;
    } else if (confirm("Do you want to register?")) {
      var reqUrl = "/lu/community/insertCommunityComment";
      $("#frmBbs").attr("action", reqUrl);
      $("#frmBbs").attr("target", "_self");
      $("#frmBbs").submit();
    }
  }

  function fn_list() {
    var reqUrl = "/lu/community/communityList";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }

  function fn_modify() {

    var reqUrl = "/lu/community/communityUpdate";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }

  function fn_delete() {
    if (confirm("Do you want to delete?")) {
      var reqUrl = "/lu/community/communityDelete";
      $("#frmBbs").attr("action", reqUrl);
      $("#frmBbs").attr("target", "_self");
      $("#frmBbs").submit();
    }
  }

  function fn_commentdelete(seq) {

    $("#commentId").val(seq);

    var reqUrl = "/lu/community/deleteCommunityComment";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }

  function fn_egov_downFile(bbsFileId, fileSn) {
    window.open("<c:url value='/commbiz/bbs/comBbsFileDown.do?importComBbsFileId=" + bbsFileId + "&importfileSn=" +
      fileSn + "'/>");
  }

  function fn_egov_deleteFile(bbsFileId, fileSn) {
    if (confirm("해당 파일을 삭제하시겠습니까?")) {
      $.ajax({
        url: "/commbiz/bbs/comBbsFileDelete.do",
        type: "get",
        data: {
          "importComBbsFileId": bbsFileId,
          "importfileSn": fileSn
        },
        success: function (result) {
          deleteFile(bbsFileId, fileSn);
        },
        error: function (e) {
          console.log("ERROR!!!!!!!!!!!");
        }
      })
    }
  }
</script>
<div id="read">
  <div class="btn-box">
    <ul>
      <c:if test="${result.insertUser eq loginVO.memId}">
        <li><a href="#" onclick="javascript:fn_modify();" class="btn-blue">Modify</a></li>
        <li><a href="#" onclick="javascript:fn_delete();" class="btn-blue">Delete</a></li>
      </c:if>
      <li><a href="#" onclick="javascript:fn_list();" class="btn-white">List</a></li>
    </ul>
  </div>
  <table>
    <caption class="sr-only">Community Content</caption>
    <tr>
      <th scope="row">Title</th>
      <td colspan="3">${result.title }</td>
    </tr>
    <tr class="mobile-none">
      <th scope="row">Register</th>
      <td>${result.insertUser }</td>
      <th scope="row">Register Date</th>
      <td>${result.insertDate }</td>
    </tr>

    <tr class="mobile-on">
      <th scope="row">Register</th>
      <td colspan="3">${result.insertUser }</td>
    </tr>
    <tr class="mobile-on">
      <th scope="row">Register Date</th>
      <td colspan="3">${result.insertDate }</td>
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
      <td colspan="4">
        <div class="text-read">
          <c:if test="${not empty imgfileResult }">
            <c:forEach var="imgfileResult" items="${imgfileResult }" varStatus="status">
              <img src="/commbiz/bbs/getImage.do?bbsFileId=${imgfileResult.bbsFileId}&fileSn=${imgfileResult.fileSn}"
                alt="a photo of the program" style="width:100%" title="${imgfileResult.orgFileName}" />
            </c:forEach>
          </c:if>
          ${result.content }
        </div>
      </td>
    </tr>
  </table>


  <c:forEach var="resultList" items="${resultList }" varStatus="status">
    <div class="comment-box comment-read">
      <span><strong>${resultList.insertUser}(${resultList.insertUserLastNameStr}
          ${resultList.insertUserNameStr})</strong>| ${resultList.insertDate}</span>
      <p>${resultList.content}</p>
      <c:if test="${resultList.insertUser eq loginVO.memId}">
        <div class="btn-box">
          <ul>
            <!--li><a href="#" onclick="javascript:fn_commentmodify();" class="btn-white">Modify</a></li-->
            <li><a href="#" onclick="javascript:fn_commentdelete('${resultList.commentId}');"
                class="btn-blue">Delete</a></li>
          </ul>
        </div>
      </c:if>

      <div class="m-comment">
        <i class="fa fa-ellipsis-v"></i>
      </div>
    </div>
  </c:forEach>

  <form id="frmBbs" name="frmBbs" method="post">
    <input type="hidden" name="courseCd" id="courseCd" value="${result.courseCd}" />
    <input type="hidden" name="bbsNoticeId" id="bbsNoticeId" value="${result.bbsNoticeId}" />
    <input type="hidden" name="pageIndex" id="pageIndex" value="${result.pageIndex}" />
    <input type="hidden" name="commentId" id="commentId" />

    <div class="comment-box comment-write">
      <span><strong>${loginVO.memId}</strong></span>
      <label for="content" class="sr-only">Comment</label>
      <textarea name="content" id="content" title="Write a comment here" aria-label="Write a comment here"></textarea>
      <div class="btn-box">
        <ul>
          <li><a href="#" class="btn-blue" onclick="javascript:fn_savecomment();">Save</a></li>
        </ul>
      </div>
    </div>
  </form>

</div><!-- E : read -->