<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

  /* 타이틀 */
  $(document).ready(function() {
    $(document).attr("title","Community > VOD Service > Details : K-LINK");
  });

  function fn_list() {
    var reqUrl = "/lu/youtube/youtubeList";
    $("#frmUTub").attr("action", reqUrl);
    $("#frmUTub").attr("target", "_self");
    $("#frmUTub").submit();
  }
</script>
<form id="frmUTub" name="frmUTub" method="post">
  <input type="hidden" name="pageIndex" id="pageIndex" value="${comYoutubeVO.pageIndex}" />
</form>
<div id="read">
  <div class="btn-box">
    <ul>
      <li><a href="#" onclick="javascript:fn_list();" class="btn-white">List</a></li>
    </ul>
  </div>
  <table>
    <caption class="sr-only">VOD Service Content</caption>
    <tr>
      <th scope="row">Title</th>
      <td colspan="3">${result.youtubeTitle }</td>
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
    <tr>
      <th scope="row">contents</th>
      <td colspan="3">
        <iframe class="youtube-iframe" src="https://www.youtube.com/embed/${fn:split(result.youtubeUrl,'=')[1]}" title="YouTube video player" aria-label="YouTube video player"></iframe>
      </td>
    </tr>
    <tr>
      <th scope="row">description</th>
      <td colspan="3">
        <c:out value="${result.youtubeDesc}" escapeXml="false" />
      </td>
    </tr>
  </table>
</div><!-- E: read -->