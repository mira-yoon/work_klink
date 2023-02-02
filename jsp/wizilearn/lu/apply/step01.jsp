<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
<!--

$(document).ready(function(){
	 

});

function fn_next(){
	if($('input:checkbox[name=agree]').is(':checked') == false){
		alert("To proceed, please read and agree to the terms and conditions.")
		 $("#agree").focus();
		 return;
	}else{
		var reqUrl = "/lu/apply/step02";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").attr("target","_self");
		$("#frmCourse").submit();
	}
}
//-->
</script>
         <div id="apply">
            <div class="step-num">
              <ul>
                <li class="step-on">
                  <span>STEP.1</span>
                  <p>Terms and Conditions</p>
                </li>
                
                <li>
                  <span>STEP.2</span>
                  <p>Application</p>
                </li>
                
            
              </ul>
            </div>
            <form id="frmCourse" name="frmCourse" method="post" action="/lu/apply/step02" >
            <input type="hidden" name="courseCd" id="courseCd" value="${courseVO.courseCd }"  />
            <div class="step">
              <div class="slider">
                <div class="step-1 step-area">
                  <h6>Step. 1 Terms and Conditions</h6>
                  <div class="step-text">
                    <p>Please read carefully and check the box below if you completely understand and agree to the terms and conditions of K-LINK program.</p>
                  </div>
                  <div class="agree-text">
                    <p>A qualified nominee must restrain from any activities that could be a hindrance to the training program such as :</p>
                    <ul>
                      <li>- Engaging in political activities, or any form of employment for profit or gain;</li>
                      <li>- Extending the length of stay for personal conveniences;</li>
                      <li>- Bringing any family members(dependents) to Korea;</li>
                      <li>- And other actions that are not listed but could possibly cause interruptions to the training program.</li>
                    </ul>
                  </div>
                  <input id="agree" type="checkbox" title="agree" alt="agree" name="agree" value="Y"/>
                  <label for="agree">I have read and understand the terms and conditions given above. By agreeing to this, I certify that I may put up with any disadvantages caused by the violation of the terms and conditions.</label>
                </div>
 
              </div>
            </div>
            </form>
            <div class="btn-box"> 
			    <div class="next btn-blue" onclick="javascript:fn_next();">next</div> 
			</div>
		  </div>
        </div><!-- E : main-contents --> 
    </div><!-- E : container -->