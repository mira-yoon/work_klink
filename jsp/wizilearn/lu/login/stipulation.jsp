<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

  /* 타이틀 */
  $(document).ready(function() {
    $(document).attr("title","Memberships > Sign Up > Stipulation  : K-LINK");
  });

  function fn_loginProc() {

    if ($('input:checkbox[name=stipulation01]').is(':checked') == false) {
      alert("Please select agreement");
      $("#stipulation01").focus();
      return;
    } else if ($('input:checkbox[name=stipulation02]').is(':checked') == false) {
      alert("Please select agreement");
      $("#stipulation02").focus();
      return;
    } else if ($('input:checkbox[name=stipulation03]').is(':checked') == false) {
      alert("Please select agreement");
      $("#stipulation03").focus();
      return;
    } else if ($('input:checkbox[name=stipulation04]').is(':checked') == false) {
      alert("Please select agreement");
      $("#stipulation04").focus();
      return;
    } else {
      var url = "/signUp.do";
      var $form = $("#loginProcForm");

      $form.submit();
    }
  }

</script>
<div id="Stipulation">

  <form action="/signUp.do" id="loginProcForm" method="post">

    <div class="stipulation-box">
      <div class="text-box" tabindex="0">
        <h6>Participants Terms and Conditions</h6>
        <span>* Member has a right to reject to give his/her consent regarding program participation. But, if member
          rejects to give his/her consent, there may be some restrictions on providing K-LINK service.</span>
        <ul>
          <li>1) Restrain from engaging in political activities, or any form of employment for profit or gain;</li>
          <li>2) Return to my home country upon completion of my training program, and to resume work in my country;
          </li>
          <li>3) Restrain from extending the length of my training or my stay for personal conveniences;</li>
          <li>4) Restrain from bringing any family members (dependents) to Korea country of training;</li>
          <li>5) Accept that the K-LINK is not liable for any damage or loss of my personal property; and</li>
          <li>6) Accept that the Korean Government will not assume any responsibility for illness, injury, or death
            arising from extracurricular activities, </li>
        </ul>
      </div>
      <div class="check-agree">
        <input id="stipulation01" name="stipulation01" type="checkbox" title="Check if you agree." aria-label="Check if you agree." value="Y" />
        <label for="stipulation01"> I have read and agreed to the following.</label>
      </div>
    </div>

    <div class="stipulation-box">
      <div class="text-box" tabindex="0">
        <h6>Notice of collection and use of personal information</h6>
        <p>Personal information collected will be used partially in K-LINK registration under the protection of K-LINK
          stipulation;</p>
        <span>* Member has a right to reject to give his/her consent regarding providing personal information. But, if
          member rejects to give his/her consent, there may be some restrictions on providing K-LINK service.</span>
        <ul>
          <li>1. Purposes for which personal information is collected and used; The private information is Personal
            Information of a living individual including but not limited to the given(first) name, surname(last) name,
            nationality, organization, department/division, job title/position, email, sub email, mobile and business
            phone etc., which can be used to identify the owner of such information (including information which can be
            used to identify the owner of the information when such information is combined with other information with
            ease). The collected information may be utilized for the following purpose; - To manage members to verify
            identifications for membership services; to distinguish individual; to prevent misbehaving members from
            using services improperly and prevent unauthorized use of services; to confirm intention of membership
            application;</li>
          <li>2. Items of personal information to be collected; The following information shall be collected to verify
            member’s application and provide optimized services: - Required Items: given(first) name, surname(last)
            name, nationality, organization, department/division, job title/position, email, sub email, mobile and
            business phone.</li>
          <li>3. Period for which personal information is held and used; We retain the following information
            <strong>until the member withdraws one’s membership:</strong> given(first) name, surname(last) name,
            nationality, organization, department/division, job title/position, email, sub email, mobile and business
            phone. We retain the informations for following purposes 1) To send out KLINK Webzines via email to all
            registered members; 2) to make statistics on KLINK Program like how many people from which countries have
            participated; 3) to maintain cooperation between participants and KLINK for future business opportunities.
          </li>
        </ul>
      </div>
      <div class="check-agree">
        <input id="stipulation02" name="stipulation02" type="checkbox" title="Check if you agree." aria-label="Check if you agree." value="Y" />
        <label for="stipulation02"> I have read and agreed to the following.</label>
      </div>
    </div>

    <div class="stipulation-box">
      <div class="text-box" tabindex="0">
        <h6>Notice of collection and use of personal information</h6>
        <span>* Member has a right to reject to give his/her consent regarding providing personal information. But, if
          member rejects to give his/her consent, there may be some restrictions on providing K-LINK service.</span>
        <p>K-LINK will not reveal the personal information to any third parties without members’ consent. Once the
          member agreed to provide the information, it will be proceeded in a following way.</p>
        <p>Receiver(the third parties): Public institutions and government agencies like KOICA, KOTRA, KOEXIM, NIA and
          UNESCAP Purposes: Requested in accordance with the regulations in the Basic Act on Telecommunications and
          other related laws in Korea.</p>
        <p>Receiver(the third parties): System maintenance company which will maintain system for about a year.</p>
        <p>Providing Items: given(first) name, surname(last) name, nationality, organization, department/division, job
          title/position, email, sub email, mobile and business phone.</p>
        <p>Given Period: Generally, one year; the file will be deleted immediately after the completion of requested
          purposes.</p>
      </div>
      <div class="check-agree">
        <input id="stipulation03" name="stipulation03" type="checkbox" title="Check if you agree." aria-label="Check if you agree." value="Y" />
        <label for="stipulation03"> I have read and agreed to the following.</label>
      </div>
    </div>

    <div class="stipulation-box">
      <div class="text-box" tabindex="0">
        <h6>Personal Information Management(Protection) Policy</h6>
        <span>* Member has the right to refuse to K-LINK Personal Information Management(Protection) Policy. However, if
          member rejects to give his/her consent, there may be some restrictions on providing K-LINK service.</span>
        <p>1) Korea Leaders Information Network (hereinafter referred to as “K-LINK”) attaches great importance to your
          personal information. In accordance with [Personal Information Management(Protection) Policy of Korea Leaders
          Information Network], K-LINK is safely managing all types of information you are providing.</p>
        <p>2) K-LINK posts [Personal Information Protection Policy of K-LINK] in the web site for you to refer to
          anytime you desire.</p>

        <p class="sub-title">Article 1 (Information Collection and Purpose of Usage)</p>
        <p>1) K-LINK is collecting a minimized level of information, which is aiming to manage members to verify
          identifications for membership services.</p>
        <p>2) K-LINK uses your information to meet the following purpose;</p>
        <ul>
          <li>- to distinguish individual</li>
          <li>- to prevent misbehaving members from using services improperly and prevent unauthorized use of services
          </li>
          <li>- to confirm intention of membership application</li>
        </ul>
        <p>* Member has the right to refuse providing his/her personal information. However, if member rejects to give
          his/her consent, there may be some restrictions on providing K-LINK service.</p>

        <p class="sub-title">Article 2 (Duration of Retaining and Using Personal Information)</p>
        <p>K-LINK retain information to achieve following purposes until the member withdraws one’s membership.</p>
        <p>1) To send out KLINK Webzines via email to all registered members; 2) to make official statistics on KLINK
          Program like how many people from which countries have participated; 3) to maintain cooperation between
          participants and KLINK for future business opportunities.</p>
        <p>Retained Items: given(first) name, surname(last) name, nationality, organization, department/division, job
          title/position, email, sub email, mobile and business phone.</p>

        <p class="sub-title">Article 3 (Providing Information to third Parties)</p>
        <p>K-LINK will not reveal the personal information to any third parties without members’ consent. Once the
          member agreed to provide the information, it will be proceeded in a following way.</p>
        <p>Receiver(the third parties): Public institutions and government agencies like KOICA, KOTRA, KOEXIM, NIA and
          UNESCAP Purposes: Requested in accordance with the regulations in the Basic Act on Telecommunications and
          other related laws in Korea.</p>
        <p>Receiver(the third parties): System maintenance company which will maintain system for about a year.</p>
        <p>Providing Items: given(first) name, surname(last) name, nationality, organization, department/division, job
          title/position, email, sub email, mobile and business phone.</p>
        <p>Given Period: Generally one year; the file will be deleted immediately after the completion of requested
          purposes.</p>

        <p class="sub-title">Article 4 (Providing and Sharing Personal Information)</p>
        <p>he received information to K-LINK is prohibited to be opened to the public or used for the purposes which are
          not agreed by the member.</p>
        <p>Only if the member agreed to provide information, it could given to other public institutions and government
          agencies when requested in accordance with the regulations in the Basic Act on Telecommunications and other
          related laws in Korea. The information given to third parties(system maintenance company) will be maintained
          for about a year, and immediately deleted after accomplishing the original purposes.</p>
        <p>Provided items: given(first) name, surname(last) name, nationality, organization, department/division, job
          title/position, email, sub email, mobile and business phone.</p>
        <p>* Member has the right to refuse providing his/her personal information to the third parties. However, if
          member rejects to give his/her consent, there may be some restrictions on providing K-LINK service.</p>

        <p class="sub-title">Article 5 (Rights of Subject of Information)</p>
        <p>A subject of information has the following rights in connection with the management of his/her personal
          information.</p>
        <ul>
          <li>1) A right to receive information concerning the management of personal information</li>
          <li>2) A right to choose and decide on whether he/she consents to the management of his/her personal
            information</li>
          <li>3) A right to verify whether personal information is managed and to request an inspection of personal
            information</li>
        </ul>

        <p class="sub-title">Article 6 (Items of Personal Information Collected)</p>
        <p>The following information shall be collected to verify member’s application and provide optimized services:
        </p>
        <p>- Required Items: given(first) name, surname(last) name, nationality, organization, department/division, job
          title/position, email, sub email, mobile and business phone.</p>
        <p>* Member has the right to refuse providing his/her personal information. However, if member rejects to give
          his/her consent, there may be some restrictions on providing K-LINK service.</p>

        <p class="sub-title">Article 7 (Process and Method of Deleting Personal Information)</p>
        <p>K-LINK, in principle, delete and destroy Personal Information immediately after the purpose of collection and
          use of such information is accomplished, or membership withdrawal. Personal Information is expired by the
          following process and method;</p>
        <p>- Process of deleting and destroying: personal information shall be deleted and destroyed immediately after
          retention purpose is achieved.</p>
        <p>- Method of deletion and destruction: Personal Information that is documented in paper shall be shredded or
          incinerated; Personal Information that is electronically stored in file format shall be deleted using
          technological method in which the deleted data cannot be restored.</p>

        <p class="sub-title">Article 8 (Countermeasure to protect information)</p>
        <p>K-LINK is seeking for the following technological counter measures to ensure safety and prevent leakage,
          theft, loss, forgery or damage of information in handling your information.</p>
        <ul>
          <li>1) It blocks any access from external sources to protect against information leakage by hacking attempts
            and installs an invasion detecting system to monitor external threats to information.</li>
          <li>2) It regularly backs up all data to prevent damage of information, which might be caused by internal
            system errors.</li>
        </ul>

        <p class="sub-title">Article 9 (Matters Relating to Installation, Operation and Refusal of Automatic Personal
          Information Collection Devices)</p>
        <ul>
          <li>1) K-LINK utilizes a “cookie”, etc. to frequently store and search for user’s information.</li>
          <li>2) Cookies are very small text files that a server used for operation a website sends to a user’s browser
            and are stored at the user’s computer hard disk driver.</li>
        </ul>
        <p>o Purposes of using cookie ; Analyzing frequency and time of users’ visits, Understanding users’ preferences
          and interested areas and tracking trails and participation in, the number of visits to various events, and
          providing personally tailored services based on the foregoing, etc.</p>
        <p>o Users have an option to install cookies. Tool button on the upper part of the web browser > Internet Option
          > Personal Information Tab > Change level of privacy</p>
        <p>o If a user rejects the installation of cookies, he/she may experience difficulties in using our services.
        </p>

        <p class="sub-title">Article 10 (Administrator in charge of information management)</p>
        <p>K-LINK designate Personal Information manager to protect the Personal Information of the number and process
          complaints regarding such information. Please contact to the below Personal Information manager or Personal
          Information administrator in case that you have any question regarding Personal Information of the member.</p>
        <p>- Personal Information manager : Cho, yu Jin / Vice President (Management Support Division), yjcho@nipa.kr
        </p>
        <p>- Personal Information administrator : Kim, kum mi / Deputy Manager(Cyber Security Team), kmk@nipa.kr</p>

        <p class="sub-title">Article 11 (Contact Information of Chief Privacy Officer and Responsible Department)</p>
        <p>Responsible Department for Handling Grievances Regarding Personal Information</p>
        <p>o Reservation Center (privacy.kisa.or.kr) : Tel 118</p>
        <p>o National Police Agency Cyber Bureau (cyberbureau.police.go.kr) : Tel 182</p>
        <p>o Personal Information dispute mediation committee (www.kopico.go.kr) : Tel 02-2100-2499</p>

        <p class="sub-title">Article 12 (Details of Changes to this Privacy Policy)</p>
        <p>(April 4, 2019) Added Article 9 and 11. Updated Contact Information of Administrators.</p>
      </div>
      <div class="check-agree">
        <input id="stipulation04" name="stipulation04" type="checkbox" title="Check if you agree." aria-label="Check if you agree." value="Y" />
        <label for="stipulation04"> I have read and agreed to the following.</label>
      </div>
    </div>

    <div class="btn-box">
      <a href="javascript:void(0);" class="btn-blue btn-next" onclick="javascript:fn_loginProc();">Next</a>
    </div>
  </form>
</div><!-- E : Stipulation -->