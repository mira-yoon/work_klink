<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
  /* 웹 접근성 마크 팝업창 */
  function openWindow(URL){
    window.open(URL, 'popup', 'width=850, height=850, scrollbars=yes, toolbal=no, location=no, status=no, menubar=no, resizable=no');
  }

  $(document).ready(function(){

    /* 패밀리사이트 */
    var btnSite = $(".btn-site");
    var siteLinkUl = $(".sitelink ul");

    //클릭해서 패밀리사이트 목록 열고 닫기
    btnSite.click(function(){
      openSiteLinkUl();
    });

    //Enter키로 패밀리사이트 목록 열고 닫기
    btnSite.keypress(function (e) {
      if (e.keyCode === 13) {
        e.preventDefault();
        openSiteLinkUl();
      }
    });

    //포커스아웃 되었을 때 닫히기
    $(".sitelink ul li:last-child a").on("blur", function(){	
      siteLinkUl.hide();
    });

    //바깥 클릭하면 닫히기
    $('html').click(function(e) { 
      if(!$(e.target).hasClass("btn-site")) {	
        siteLinkUl.hide();
      } 
    });

    function openSiteLinkUl(){
      if (siteLinkUl.is(":visible")) {
        siteLinkUl.hide();
      } else {
        siteLinkUl.show();
      }
    }

  });  
</script>
<div id="footer">
  <div class="box-area">
    <div class="footer-logo">
      <ul>
        <li><a href="https://english.msit.go.kr/eng/index.do" title="Open the linked website in a new window." target="_blank" class="logo-mist">Ministry of science and ICT</a>
        </li>
        <li><a href="http://www.nipa.kr/eng/index.do" title="Open the linked website in a new window." target="_blank" class="logo-nipa">Nipa</a></li>
      </ul>
    </div>
    <div class="footerContent">
      <ul>
        <li><a href="/lu/PrivacyPolicy/content">Privacy Policy</a></li>
      </ul>
      <div class="sitelink">
        <button type="button" class="btn-site" title="Visit related websites."
          aria-label="Visit related websites.">Family Sites</button>
        <ul>
          <li><a href="https://www.crms.go.kr/en/index.do" title="Open the linked website in a new window." target="_blank"
              rel="noopener noreferrer"><span>CRMS</span></a></li>
          <li><a href="https://www.kca.kr/eng/" title="Open the linked website in a new window." target="_blank"
              rel="noopener noreferrer"><span>KCA</span></a></li>
          <li><a href="https://www.kait.or.kr/eng_index.jsp" title="Open the linked website in a new window." target="_blank"
              rel="noopener noreferrer"><span>KAIT</span></a></li>
          <li><a href="http://www.tta.or.kr/eng/index.jsp" title="Open the linked website in a new window." target="_blank"
              rel="noopener noreferrer"><span>TTA</span></a></li>
          <li><a href="http://rra.go.kr/en/index.do" title="Open the linked website in a new window." target="_blank" rel="noopener noreferrer"><span>RRA</span></a></li>
        </ul>
      </div>
      <address>
        <p>(27872) Jeongtong-ro 10, Deoksan-eup, Jincheon-gun, Chungcheongbuk-do | TEL +82) 43-931-5537</p>
        <p>Copyright (C) 2019 K-LINK all rights reserved.</p>
      </address>
      <div class="wa-mark">
        <a href="#" title="pdf 파일보기 - 새 창으로 열기" target="_blank" onclick="javascript:openWindow('/pdf/2021-1058 정보통신접근성 품질인증서-K-Link.pdf'); return false;">
          <img src="/images/common/wa_mark.png" alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)">
        </a>
      </div>
    </div>
  </div>
</div>

<script async src="https://www.googletagmanager.com/gtag/js?id=UA-152939984-1"
  integrity="sha384-Ne81SFcRNEMbMSXF9HqOVnlcS+Nb0g4GnT1USBJHdzrLEKz8ZEdXdFgtwzTabIc3" crossorigin="anonymous"></script>

<script>
  window.dataLayer = window.dataLayer || [];

  function gtag() {
    dataLayer.push(arguments);
  }
  gtag('js', new Date());

  gtag('config', 'UA-152939984-1');
</script>