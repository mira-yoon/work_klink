<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

	/* 타이틀 */
  $(document).ready(function() {
    $(document).attr("title","Community > VOD Service : K-LINK");
	var $pagination = $("ul.pagination");
		$pagination.children("li").each(function() {
			var $this = $(this).children("a");

			if ($this.hasClass("select")) {
				$this.attr("title", "page" + $this.text() + "-selected");
			} else {
				$this.attr("title", "page" + $this.text());
			}
		});
  });

	/* 조회 */
	function fn_search(param1) {
		$("#pageIndex").val(param1);
		var reqUrl = "/lu/youtube/youtubeList";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").attr("target", "_self");
		$("#frmUTub").submit();
	}
	/* 상세 조회 */
	function fn_detail(seq) {

		$("#youtubeId").val(seq);
		var reqUrl = "/lu/youtube/goDetailYoutube";
		$("#frmUTub").attr("action", reqUrl);
		$("#frmUTub").submit();

	}

</script>

<div id="community">
	<h2 class="sr-only">VOD Service List</h2>
	<div class="board">
		<div class="search-box">
			<form id="frmUTub" name="frmUTub" method="post">
				<input type="hidden" name="youtubeId" id="youtubeId" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${comYoutubeVO.pageIndex}" />
				<div class="text-input">
					<input type="text" title="Type your search." aria-label="Type your search." name="searchKeyword" value="${comYoutubeVO.searchKeyword}" />
				</div>
				<button class="btn-search" type="submit" onclick="javascript:fn_search('1');">
					<i class="fa fa-search" title="Search" aria-label="Search"></i>
					<span>Search</span>
				</button>
				<div class="total">
					<p>Total : <span>${totalCount}</span></p>
				</div>
			</form>
		</div>

		<ul class="card-board">
			<c:forEach var="result" items="${resultList }" varStatus="status">
				<li>
					<a href="javascript:void(0)" onclick="javascript:fn_detail('${result.youtubeId }'); return false;" title="Click here to watch video">
						<div class="community-title">
							<span><c:out value="${result.youtubeTitle }" /></span>
							<div class="lookup"><i class="fa fa-globe" aria-hidden="true"></i></div>
						</div>
						<div class="community-img">
							<c:choose>
								<c:when test="${not empty result.youtubeFileId}">
									<img src="/commbiz/youtube/getImage.do?youtubeFileId=${result.youtubeFileId}"
										alt="video thumnail image" />
								</c:when>
								<c:otherwise>
									<img src="http://img.youtube.com/vi/${fn:split(result.youtubeUrl,'=')[1]}/mqdefault.jpg"
										alt="${result.youtubeTitle }" />
								</c:otherwise>
							</c:choose>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>

		<c:if test="${empty resultList}">
			<ul class="card-board" style="height:200px;padding:20px;">
				<center>No posts have been submitted.</center>
			</ul>
		</c:if>
		<c:if test="${not empty resultList}">
			<div id="number">
				<ul class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="uimage" jsFunction="fn_search" />
				</ul>
			</div>
		</c:if>
	</div>
</div><!-- E: community -->