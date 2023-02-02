<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

	$(document).ready(function () {
		var title = "Community > Community > : K-LINK";

		var year = $(".tab-link.tab-on").data("year");
		if (year) {
			title = "Community > Community > " + year + " Program List : K-LINK";
		}

		/* 타이틀 */
		$(document).attr("title", title);

		//탭메뉴
		$('#tabArea .tab-link').click(function () {
			var tab_id = $(this).attr('data-tab');

			$('#tabArea .tab-link').removeClass('tab-on');
			$('.tab-content').removeClass('current');

			$(this).addClass('tab-on');
			$("#" + tab_id).addClass('current');
		});

		// 탭메뉴 버튼에 타이틀 넣기
		var $tab_box = $(".tab-box");
		$tab_box.children("button").each(function(){
			var $this = $(this);
			if ($this.hasClass("tab-on")) {
				$this.attr("title", "the year of " + $this.text() + "-selected");
      } else {
        $this.attr("title", "the year of " + $this.text());
      }
		});

		// 탭 컨텐츠에 제목 넣기
		var $tab_content = $(".tab-content")[0];
		$tab_content.insertAdjacentHTML("afterbegin","<h3 class='sr-only'>"+ year +" Program List</h3>")

		//제목글자수 제한
		$(".community-list span").each(function () {
			var length = 40;
			$(this).each(function () {
				if ($(this).text().length >= length) {
					$(this).text($(this).text().substr(0, length) + '...')
				}
			});
		});
	});


	function fn_searchList(courseCd) {
		$("#courseCd").val(courseCd);
		var reqUrl = "/lu/community/communityList";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target", "_self");
		$("#frmBbs").submit();
	}


	function fn_search(year) {
		$("#year").val(year);
		var reqUrl = "/lu/community/communityCourseList";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target", "_self");
		$("#frmBbs").submit();
	}


</script>
<div id="community">
	<div id="tabArea">
		<form id="frmBbs" name="frmBbs" method="post">
			<input type="hidden" name="courseCd" id="courseCd" />
			<input type="hidden" name="pageIndex" id="pageIndex" value="1" />
			<input type="hidden" name="year" id="year" value="${courseVO.year}" />
		</form>

		<div class="tab-box">
			<c:forEach var="listYearValue" items="${listYear }" varStatus="status">
				<c:choose>
					<c:when test="${listYearValue eq courseVO.year}">
						<button type="button" class="tab-link tab-on" data-tab="tab-${status.count}" data-year="${listYearValue}"  onclick="javascript:fn_search('${listYearValue}')">${listYearValue}</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="tab-link" data-tab="tab-${status.count}" data-year="${listYearValue}" onclick="javascript:fn_search('${listYearValue}')">${listYearValue}</button>
					</c:otherwise>
				</c:choose>	
			</c:forEach>
		</div>

		<div id="tab-1" class="tab-content current">

			<div class="board">


				<c:if test="${empty courseScheduleList }">
					<p style="text-align:center">EMPTY</p>
				</c:if>

				<c:forEach var="resultList" items="${courseScheduleList }" varStatus="status">
					<c:if test="${status.first}">
						<ul class="community-list">
					</c:if>
					<c:if test="${not status.first}">
						<c:if test="${status.count mod 3 eq 1}">
							<ul class="community-list">
						</c:if>
					</c:if>
					<li>
						<span>${resultList.titleStr }</span>
						<p>${resultList.dayStart}~${resultList.dayEnd}</p>
						<div class="btn-box-cen">
							<a href="#" onclick="javascript:fn_searchList('${resultList.courseCd}');">Entrance</a>
						</div>
					</li>
					<c:if test="${status.count mod 3 eq 0}">
						</ul>
					</c:if>
					<c:if test="${status.count mod 3 ne 0}">
						<c:if test="${status.last}">
							</ul>
						</c:if>
					</c:if>
				</c:forEach>

			</div>
		</div>
	</div>
</div><!-- E : community -->
