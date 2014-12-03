  <%@ Page Language="vb" AutoEventWireup="false" Codebehind="ENR.aspx.vb" Inherits="ElectionResults.ENR" %>
  <%@ Register TagPrefix="aspGraph" TagName="Image" Src="graph.ascx" %>
<%--  <%@ OutputCache Duration="60" VaryByParam="None" %>--%>
  <%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">--%>
  <!DOCTYPE html>
  <html lang="en">
  <head id="Head1" runat="server">
      <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
      <!-- Refresh Every 30mins -->
      <meta http-equiv="refresh" content="1800" />
      <title>Elections</title>
      <!-- Style -->
      <link href="css/bootstrap.min.css" rel="stylesheet" />
      <link href="css/styles.css" rel="stylesheet" />
      <link href="css/mediaQueries.css" rel="stylesheet" />
      <!-- fonts -->
      <link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet" />
      <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0/css/font-awesome.css" rel="stylesheet" />
  </head>
  <body id="theBody" ng-app="main" ng-controller="mainController" >
      <form id="frmMain" runat="server">

     <!-- header DATA -->
     <asp:SqlDataSource ID="sqlHeaderParms" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT ELECTION_TITLE, ELECTION_DATE, DECODE(RESULTS_MODE,NULL,NULL,'<strong>'||RESULTS_MODE||'</strong><br>')||'Updated '||(SELECT TO_CHAR(MAX(REPORT_DATE),'MM/DD/YYYY HH12:MI AM') FROM ELECTION_RESULTS) AS RESULTS_MODE,DECODE(RESULTS_MSG,NULL,NULL,'<br>'||RESULTS_MSG) AS RESULTS_MSG FROM ELECTION_RESULTS_PARMS">
    </asp:SqlDataSource>     
     <!-- elec mode DATA -->
     <asp:SqlDataSource ID="sqlElecMode" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT ELECTION_TITLE, ELECTION_DATE, DECODE(RESULTS_MODE,NULL,NULL,' '||RESULTS_MODE||' ')||' ' AS RESULTS_MODE,DECODE(RESULTS_MSG,NULL,NULL,'<br>'||RESULTS_MSG) AS RESULTS_MSG FROM ELECTION_RESULTS_PARMS">
    </asp:SqlDataSource>  
    <!-- last update DATA -->
    <asp:SqlDataSource ID="sqlLastUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
       ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT ELECTION_TITLE, ELECTION_DATE, DECODE(RESULTS_MODE,NULL,NULL,'<strong></strong>')||'Updated '||(SELECT TO_CHAR(MAX(REPORT_DATE),'MM/DD/YYYY HH12:MI AM') FROM ELECTION_RESULTS) AS RESULTS_MODE,DECODE(RESULTS_MSG,NULL,NULL,'<br>'||RESULTS_MSG) AS RESULTS_MSG FROM ELECTION_RESULTS_PARMS">
    </asp:SqlDataSource>    

      <!-- Modal Shade -->
      <div id="modalShade">
          <!-- refinePopUp -->
          <div id="refinePopUp" class='mobileOverflow'>

              <!-- refinePopUp_Top -->
              <div id="refinePopUp_Top">
                  <!-- backButton -->
                  <a id="backButton"  ng-click="applySettings()" class="btn btn-primary" >
                  <i class="fa fa-chevron-left fa-lg" ></i>&nbsp;Ok</a>
                 <label style="font-size:16px;">Refine</label>
              </div>
                          
              <!-- refinePopUp_Mid -->
              <div id="refinePopUp_Mid">
                  <div id="refinePopUp_MidInner">
                      
                  <!-- Check/Uncheck All -->
                    <div class=“centerPull”>
                      <!-- Show All Link -->
                      <a class="bold"  ng-click="showAllResults()" >Show All&nbsp;</a>
                      <div style="font-weight: bold; display: inline-block; ">/</div>
                      <!-- None Link -->
                      <a class="bold"  ng-click="showNoResults()" >&nbsp;None</a>
                    </div>
                         
                        <hr/>

                  <ul>
                     <li>
                        <div class=“setting”>
                      <input id="turnoutBox" class="css-checkbox" type="checkbox" ng-model="turnout" ng-change="storageChange(turnout, 'turnout')" />
  					<label for="turnoutBox" name="turnoutBox_lbl" class="css-label">&nbsp;Turnout</label>
                      </div>
                    </li>
                    <li>
                        <div class=“setting”>
                      <input id="congressBox" class="css-checkbox" type="checkbox" ng-model="congress" ng-change="storageChange(congress, 'congress')" />
  					<label for="congressBox" name="congressBox_lbl" class="css-label">&nbsp;Congress</label>
                      </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="governorBox" class="css-checkbox" type="checkbox" ng-model="governor" ng-change="storageChange(governor, 'governor')" />
  					<label for="governorBox" name="governorBox_lbl" class="css-label">&nbsp;Governor</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                       <input id="secretaryBox" class="css-checkbox" type="checkbox" ng-model="secretary" ng-change="storageChange(secretary, 'secretary')" />
  					 <label for="secretaryBox" name="secretaryBox_lbl" class="css-label">&nbsp;Secretary</label>
                      </div>
                     </li>
                     <li>
                        <div class=“setting”>
                       <input id="treasurerBox" class="css-checkbox" type="checkbox" ng-model="treasurer" ng-change="storageChange(treasurer, 'treasurer')" />
  					 <label for="treasurerBox" name="treasurerBox_lbl" class="css-label">&nbsp;St Treasurer</label>
                      </div>
                     </li>
                    <li>  
                        <div class=“setting”>
                        <input id="controllerBox" class="css-checkbox" type="checkbox" ng-model="controller" ng-change="storageChange(controller, 'controller')" />
  					<label for="controllerBox" name="controllerBox_lbl" class="css-label">&nbsp;Controller</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                       <input id="attorneyBox" class="css-checkbox" type="checkbox" ng-model="attorney" ng-change="storageChange(attorney, 'attorney')" />
  					 <label for="attorneyBox" name="attorneyBox_lbl" class="css-label">&nbsp;Attorney</label>
                      </div>
                     </li>
                    <li>
                        <div class=“setting”>
                        <input id="senateBox" class="css-checkbox" type="checkbox" ng-model="senate" ng-change="storageChange(senate, 'senate')" />
  					<label for="senateBox" name="senateBox_lbl" class="css-label">&nbsp;Senate</label>
                        </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="assemblyBox" class="css-checkbox" type="checkbox" ng-model="assembly" ng-change="storageChange(assembly, 'assembly')" />
  					<label for="assemblyBox" name="assemblyBox_lbl" class="css-label">&nbsp;Assembly</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="countyBox" class="css-checkbox" type="checkbox" ng-model="county" ng-change="storageChange(county, 'county')" />
  					<label for="countyBox" name="countyBox_lbl" class="css-label">&nbsp;County (all)</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="administratorBox" class="css-checkbox" type="checkbox" ng-model="administrator" ng-change="storageChange(administrator, 'administrator')" />
  					<label for="administratorBox" name="administratorBox_lbl" class="css-label">&nbsp;Administrator</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                       <input id="supremeBox" class="css-checkbox" type="checkbox" ng-model="supreme" ng-change="storageChange(supreme, 'supreme')" />
  					 <label for="supremeBox" name="supremeBox_lbl" class="css-label">&nbsp;Supreme</label>
                      </div>
                     </li>

                    <li>
                        <div class=“setting”>
                        <input id="constableBox" class="css-checkbox" type="checkbox" ng-model="constable" ng-change="storageChange(constable, 'constable')" />
  					<label for="constableBox" name="constableBox_lbl" class="css-label">&nbsp;Constable</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="judgeBox" class="css-checkbox" type="checkbox" ng-model="judge" ng-change="storageChange(judge, 'judge')" />
  					<label for="judgeBox" name="judgeBox_lbl" class="css-label">&nbsp;Judge</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="regentBox" class="css-checkbox" type="checkbox" ng-model="regent" ng-change="storageChange(regent, 'regent')" />
  					<label for="regentBox" name="regentBox_lbl" class="css-label">&nbsp;Regent</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="boardBox" class="css-checkbox" type="checkbox" ng-model="board" ng-change="storageChange(board, 'board')" />
  					<label for="boardBox" name="boardBox_lbl" class="css-label">&nbsp;Board</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="trusteeBox" class="css-checkbox" type="checkbox" ng-model="trustee" ng-change="storageChange(trustee, 'trustee')" />
  					<label for="trusteeBox" name="trusteeBox_lbl" class="css-label">&nbsp;Trustee</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                        <input id="sheriffBox" class="css-checkbox" type="checkbox" ng-model="sheriff" ng-change="storageChange(sheriff, 'sheriff')" />
  					<label for="sheriffBox" name="sheriffBox_lbl" class="css-label">&nbsp;Sheriff</label>
                         </div>
                    </li>
                    <li>
                        <div class=“setting”>
                      <input id="peaceBox" class="css-checkbox" type="checkbox" ng-model="peace" ng-change="storageChange(peace, 'peace')" />
  					<label for="peaceBox" name="peaceBox_lbl" class="css-label">&nbsp;Peace</label>
                         </div>
                    </li>
                     <li>
                        <div class=“setting”>
                       <input id="questionBox" class="css-checkbox" type="checkbox" ng-model="question" ng-change="storageChange(question, 'question')" />
  					 <label for="questionBox" name="questionBox_lbl" class="css-label">&nbsp;Question</label>
                      </div>
                     </li>
                    </ul>
                    </div>
                </div>

              <!-- refinePopUp_Bottom -->
              <div id="refinePopUp_Bottom">
                  <!-- Featured Only Link -->
                  <a class="bold" id="bluelink2" ng-click="defaultSettings()" >featured only</a> | <!-- style="display:inline;" -->
                  <!-- Default button -->
                  <a class="btn btn-primary" id="A3" class="btn btn-primary"   ng-click="applySettings()" > <!-- saveSettings() -->
                  Ok</a>
              </div>
              </div>
          </div>

      
        <!-- toTop Button -->
        <a id="goTop">Top</a>
        
         <!-- header -->
         <header class="navbar navbar-default navbar-static-top " role="banner">
          <div class="container">
            <div class="navbar-header">
              <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a href="" class="navbar-brand"><img id="CountyLogo" title="Visit the County's Homepage" alt="Visit the County's Homepage" src="resources/img_icons/brightened2ico.ico" />

                    <!-- Header Tag -->
                    <asp:FormView ID="headerfrmParams" runat="server" DataSourceID="sqlHeaderParms" Width="100%"
                        DataKeyNames="ELECTION_TITLE" BorderStyle="None" BorderWidth="0px" EmptyDataText="No election found.">
                        <ItemTemplate>
                            <asp:Label ID="ELECTION_TITLELabel" runat="server" Text='<%# Eval("ELECTION_TITLE") %>'
                                CssClass="logoTitleStyle engFit">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:FormView>

                  </a>
              </div>
              <nav class="collapse navbar-collapse " role="navigation">
                <ul class="nav navbar-nav navbar-right">
                  <li>
                      <a target="_blank" href="http://www.silverstateelection.com/">
                      <i class="fa fa-bar-chart-o" style="margin-right:8px;" ></i>StateWide</a>
                    </li>
                    <li>
                        <a target="_blank" href="http://www.clarkcountynv.gov/vote">
                        <i class="fa fa-bookmark" style="margin-right:8px;" ></i>Full Site</a>
                      </li>
                      <li>
                          <a target="_blank" href="http://redrock.clarkcountynv.gov/electionresults/enr.aspx">
                          <i class="fa fa-print" style="margin-right:8px;" ></i>Print</a>
                        </li>
                      </ul>
                    </nav>
                  </div>
                </header>
                

               <div class="container">
                 <div class="row">
                   <div class="col-md-3" id="leftCol" ></div>  
                <div class="col-md-9">
                
                  <!-- Head Description Block -->
                  <div class="headerAdjust"  id="headDescription" >

                        <!-- Elec Mode -->
                        <asp:FormView ID="headerfrmParams2" runat="server" DataSourceID="sqlElecMode" Width="100%"
                            DataKeyNames="ELECTION_TITLE" BorderStyle="None" BorderWidth="0px" EmptyDataText="No election found.">
                            <ItemTemplate>
                                <!-- Elec Mode Tag -->
                                <div class="elecmodeHeader">Clark County, NV</div> <div style="display:inline-block">&nbsp;<i class="fa fa-ellipsis-v fa-md"></i> &nbsp; <asp:Label ID="RESULTS_MODELabel" runat="server" Text='<%# Bind("RESULTS_MODE") %>' 
                                    CssClass="elecmodeHeader_sub">
                                </asp:Label>  </div>
                            </ItemTemplate>
                        </asp:FormView>

                        <!-- Last Update -->
                        <asp:FormView ID="headerfrmParams3" runat="server" DataSourceID="sqlLastUpdate" Width="100%"
                            DataKeyNames="ELECTION_TITLE" BorderStyle="None" BorderWidth="0px" EmptyDataText="No election found.">
                            <ItemTemplate>
                                <!-- Last Update Tag -->
                                <asp:Label ID="RESULTS_MODELabel" runat="server" Text='<%# Bind("RESULTS_MODE") %>' >
                                </asp:Label>
                                <!-- Manual Refresh link -->
                                <a href="javascript:history.go(0)">Click to refresh the page</a>
                                <br />
                            </ItemTemplate>
                        </asp:FormView>

                      <i style="font-size:12px; color:gray;">This page automatically refreshes every 30 minutes.</i>

                    <br/><br/>

                    Statewide election results are available on the <a target="_blank" href="http://www.silverstateelection.com/" >Secretary of State's website.</a>
                    
                    <br/><br/>

                    <!-- No Contest AlertBox -->
                    <div id="noContestAlert" class="alert alert-info" role="alert">
                        <strong>Heads up! </strong> 
                        Make sure to tap the <a ng-click="showAllResults()" class="alert-link">  See All link </a>, or choose <a ng-click="showPopUp()" class="alert-link">  Refine Results </a> to show contests.
                    </div>


                     <!-- Quick Direct -->
                     <div id="quickDirect">
                         <!-- Quick Header-->
                         <div id="quickHeader">
                             <div id="quickHeader_Inner" style="display: inline-block; color:black; "> <i class="fa fa-hand-o-down fa-md"></i> Tap to hide</div>
                             <div style="display: inline-block; font-weight: bold; color:black;"> | </div>
                             <a title="" ng-click="showPopUp()"  href="" style="font-weight:bold;" >
                               &nbsp;Refine Results 
                             </a>
                         </div>
                     
                           <div class="btn-group" style="display: inline-block;">
                             <a ng-click="hideTags('turnout')" ng-show="turnout" class="btn btn-default  cssFade" style="background-color: #0d77b6 !important; color: white !important;">turnout <i  class="fa fa-times-circle" ></i></a> <!-- href="#turnoutSec" -->
                             <a ng-click="hideTags('congress')" ng-show="congress" class="btn btn-default cssFade"  style="background-color: #0d77b6 !important; color: white !important;">congress <i  class="fa fa-times-circle"></i></a> <!-- href="#congressSec" -->
                             <a ng-click="hideTags('governor')" ng-show="governor" class="btn btn-default cssFade"  style="background-color: #0d77b6 !important; color: white !important;">governor <i  class="fa fa-times-circle"></i></a> <!-- href="#governorSec" -->
                             <a ng-click="hideTags('secretary')" ng-show="secretary" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">secretary <i  class="fa fa-times-circle"></i></a> <!-- href="#secretarySec" -->
                             <a ng-click="hideTags('treasurer')" ng-show="treasurer" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">st treasurer <i  class="fa fa-times-circle"></i></a> <!-- href="#treasurerSec" -->
                             <a ng-click="hideTags('controller')" ng-show="controller" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">controller <i  class="fa fa-times-circle"></i></a> <!-- href="#controllerSec" -->
                             <a ng-click="hideTags('attorney')" ng-show="attorney" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">attorney <i  class="fa fa-times-circle"></i></a> <!-- href="#attorneySec" -->
                             <a ng-click="hideTags('senate')" ng-show="senate" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">senate <i  class="fa fa-times-circle"></i></a> <!-- href="#senateSec" -->
                             <a ng-click="hideTags('assembly')" ng-show="assembly" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">assembly <i  class="fa fa-times-circle"></i></a> <!-- href="#assemblySec" -->
                             <a ng-click="hideTags('county')" ng-show="county" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">county <i  class="fa fa-times-circle"></i></a> <!-- href="#countySec" -->
                             <a ng-click="hideTags('administrator')" ng-show="administrator" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">administrator <i  class="fa fa-times-circle"></i></a> <!-- href="#administratorSec" -->
                             <a ng-click="hideTags('supreme')" ng-show="supreme" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">supreme <i  class="fa fa-times-circle"></i></a> <!-- href="#supremeSec" -->
                             <a ng-click="hideTags('constable')" ng-show="constable" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">constable <i  class="fa fa-times-circle"></i></a> <!-- href="#constableSec" -->
                             <a ng-click="hideTags('judge')" ng-show="judge" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">judge <i  class="fa fa-times-circle"></i></a> <!-- href="#judgeSec" -->
                             <a ng-click="hideTags('regent')" ng-show="regent" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">regent <i  class="fa fa-times-circle"></i></a> <!-- href="#regentSec" -->        
                             <a ng-click="hideTags('board')" ng-show="board" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">board <i  class="fa fa-times-circle"></i></a> <!-- href="#boardSec" -->
                             <a ng-click="hideTags('trustee')" ng-show="trustee" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">trustee <i  class="fa fa-times-circle"></i></a> <!-- href="#trusteeSec" -->
                             <a ng-click="hideTags('sheriff')" ng-show="sheriff" class="btn btn-default cssFade"  style="background-color: #0d77b6 !important; color: white !important;">sheriff <i  class="fa fa-times-circle"></i></a> <!-- href="#sheriffSec" -->
                             <a ng-click="hideTags('peace')" ng-show="peace" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">peace <i  class="fa fa-times-circle"></i></a> <!-- href="#peaceSec" -->
                             <a ng-click="hideTags('question')" ng-show="question" class="btn btn-default cssFade"   style="background-color: #0d77b6 !important; color: white !important;">question <i  class="fa fa-times-circle"></i></a> <!-- href="#questionSec" -->

                               <!-- See All Results link -->
                               <a id="seeAllLink" title="" ng-click="showAllResults()" href="" style="display: inline-block; font-weight:bold; margin-left:6px !important;" > <!-- display:inline-block; float:left;  -->
                                  See All <i class="fa fa-chevron-right"></i> <!-- <i class="fa fa-chevron-circle-right"></i> --> <!-- ng-show="allLink"  -->
                               </a> 
                           
                           </div>
                     </div>
                  </div>
                  

    
                  
                  <!-- Turnout -->
                  <div id="turnoutSec" class="cssFade" ng-show="turnout">
                      
                  <hr />
                  <!-- Turnout Header -->
                  <h2 id="turnoutHeader" class="flag" style="line-height: 1.428571429 !important;">Turnout</h2>
                  <br/>
                
                  <div class="row" >
                      
              <!-- LIVE TURNOUT DATA -->
               <div id="divRegAndTurnout" runat="server" style="border-style: none; text-align: center;" >
                  
                   <!-- SQL by REGISTRATION & TURNOUT -->
                   <asp:SqlDataSource ID="sqlTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                            ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS_STAGING WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL > 0 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
                    </asp:SqlDataSource>
<%--                    <!-- ( muni ) -->
                    <asp:SqlDataSource ID="sqlCityTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL, REPLACE(UPPER(PSD_NAME),' - AT LARGE','') AS MUNI_NAME, LIST_ORDER FROM ENR.ELECTION_SUB_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER),TO_NUMBER(LIST_ORDER)">
                    </asp:SqlDataSource>--%>
                      
                 <!-- REGISTRATION & TURNOUT -->
                 <div class="col-md-12">
                      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTurnout"
                          DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                          Width="100%" >
                          <Columns>
                              <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                  <ItemTemplate>
                                      <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                          Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt"></asp:Label><br />
                                          <i class="icon-ok" style=""></i> <!-- Ok -->
                                      <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                          Font-Names="Trebuchet MS"></asp:Label><strong>&nbsp;Registered Voters</strong>  <%--<i class="icon-flag icon-4x pull-left icon-border"></i>--%>
                                      <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                          ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Edge Turnout', 'Election Day Turnout', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS_STAGING WHERE UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                          <SelectParameters>
                                              <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                  Type="String" />
                                          </SelectParameters>
                                      </asp:SqlDataSource>
         
                                       <!-- panel -->
                                      <div class="panel panel-default">
                                          <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"
                                              CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                          Font-Size="10pt" OnRowDataBound="GridView2_RowDataBound" ShowHeader="True" ShowFooter="True" CssClass="tableFontAdjust table ng-scope ng-table" GridLines="None">
                                              <RowStyle VerticalAlign="Top" Wrap="False" />
                                              <Columns>
                                                  <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                      >
                                                      <ItemStyle Wrap="False" Width="230px" HorizontalAlign="left" />
                                                      <HeaderStyle  HorizontalAlign="Left" />
                                                  </asp:BoundField>
                                                  <asp:BoundField DataField="VOTES" HeaderText="Total" HeaderStyle-HorizontalAlign="Right" >
                                                      <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                                      <HeaderStyle  HorizontalAlign="Right" />
                                                  </asp:BoundField>
                                                  <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                                  <asp:TemplateField HeaderText="%/Reg" >
                                                      <ItemStyle Width="110px" HorizontalAlign="right" />
                                                      <HeaderStyle  HorizontalAlign="Right" />
                                                  </asp:TemplateField>
                                              </Columns>
                                              <FooterStyle  HorizontalAlign="left" />
                                              <HeaderStyle  />
                                          </asp:GridView>
                                      </div> <!-- end panel class div -->
                                                                                              
                                  </ItemTemplate>
                              </asp:TemplateField>
                          </Columns>
                      </asp:GridView>
               </div>  <!-- end cold-md-6 -->

<%--                  <!-- MUNI TURNOUT -->
                  <div class="col-md-12">
                  <asp:GridView ID="GridView20" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCityTurnout"
                      DataKeyNames="MUNI_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                      Width="100%">
                      <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("MUNI_NAME") %>' Font-Bold="True"
                                      Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                  <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                      Font-Names="Verdana"></asp:Label><strong>&nbsp;Registered Voters</strong>
                                  <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Edge Turnout', 'Election Day Turnout', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_SUB_RESULTS WHERE REPLACE(UPPER(PSD_NAME),' - AT LARGE','')=:OFFICE AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                      <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="gvCityTurnout" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource8"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Verdana"
                                      Font-Size="10pt" BorderWidth="1px" OnRowDataBound="gvCityTurnout_RowDataBound"
                                      ShowHeader="True" ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" HeaderStyle-BackColor="peachPuff">
                                              <ItemStyle Wrap="False" Width="230px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Total" HeaderStyle-HorizontalAlign="Center"
                                              HeaderStyle-BackColor="peachPuff">
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Reg" HeaderStyle-HorizontalAlign="center" HeaderStyle-BackColor="peachPuff">
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle BackColor="LightGray" HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->

                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->--%>
               </div> <!-- END divRegAndTurnout -->
               </div> <!-- END row -->
               
               </div> <!-- END turnout section -->
               
               

               
   


                  <hr/>

                  <!-- Featured Races -->
                  <h2 id="featuredRacesHeader" class="flag" style="line-height: 1.428571429 !important;">Featured Races</h2>

<%--                  <a id="refineButton" class="contentright" title="" ng-click="showPopUp()"  href="" style="font-weight:bold;" > <!-- margin-left:6px !important; --> <!-- display:inline-block; float:left;  -->
                      Refine Results <i class="fa fa-chevron-circle-right"></i>
                  </a>--%>

                  <div class="row">
   
                  <!-- LIVE Contests DATA -->
                  <div id="divContests" runat="server" style="border-style: none; text-align: center;">
                  <!-- SQL by all Races -->
                  <asp:SqlDataSource ID="sqlContests" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>  
                  

                  <!-- SQL by Congress Races -->
                  <asp:SqlDataSource ID="sqlCongress" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%CONGRESS%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Governor Races -->
                  <asp:SqlDataSource ID="sqlGovernor" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%GOVERN%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Controller Races -->
                  <asp:SqlDataSource ID="sqlController" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%CONTROLLER%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Senate Races -->
                  <asp:SqlDataSource ID="SqlSenate" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%SENATE%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Assembly Races -->
                  <asp:SqlDataSource ID="sqlAssembly" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%ASSEMBLY%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by County (all) Races -->
                  <asp:SqlDataSource ID="SqlCounty" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%COUNTY%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Administrator Races -->
                  <asp:SqlDataSource ID="sqlAdministrator" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%ADMINISTRATOR%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Constable Races -->
                  <asp:SqlDataSource ID="sqlConstable" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%CONSTABLE%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Judge Races -->
                  <asp:SqlDataSource ID="sqlJudge" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%JUDGE%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Regent Races -->
                  <asp:SqlDataSource ID="sqlRegent" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%REGENT%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Board -->
                  <asp:SqlDataSource ID="SqlBoard" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%BOARD%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Trustee (Overton) -->
                  <asp:SqlDataSource ID="SqlTrustee" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%OVERTON%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Sheriff Races -->
                  <asp:SqlDataSource ID="SqlSheriff" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%SHERIFF%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Peace Races -->
                  <asp:SqlDataSource ID="SqlPeace" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%PEACE%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Supreme Races -->
                  <asp:SqlDataSource ID="SqlSupreme" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%SUPREME%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Secretary Races -->
                  <asp:SqlDataSource ID="SqlSecretary" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%SECRETARY%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Treasurer Races -->
                  <asp:SqlDataSource ID="SqlTreasurer" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%STATE TREASURER%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  <!-- SQL by Attorney Races -->
                  <asp:SqlDataSource ID="SqlAttorney" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                      ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%ATTORNEY%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                  </asp:SqlDataSource>
                  

                 <!-- All Races ngSection -->
                 <div class="cssFade" ng-show="allResults" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView20" runat="server" AutoGenerateColumns="False" DataSourceID="sqlContests"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />   <%--Wrap="True" --%>
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol mobileFix" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" > 
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL"  ShowHeader="False"  >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>                          
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end All Races ngSection -->
                  
                  
                  
   
                 <!-- filteredResults -->                 
                 <div ng-show="filteredResults">

                 <!-- Congress ngSection -->
                 <div class="cssFade" ng-show="congress" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView21" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCongress"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />   <%--Wrap="True" --%>
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol mobileFix" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" > 
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL"  ShowHeader="False"  >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>                          
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Congress Races ngSection -->


                 <!-- Governor ngSection -->
                 <div class="cssFade" ng-show="governor" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView9" runat="server" AutoGenerateColumns="False" DataSourceID="sqlGovernor"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" > 
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>                 
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Governor Races ngSection -->


                 <!-- Controller ngSection -->
                 <div class="cssFade" ng-show="controller" >
                  <div class="col-md-12">       
                  <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="sqlController"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                       
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Controller Races ngSection -->
                  

                 <!-- Senate ngSection -->
                 <div class="cssFade" ng-show="senate" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView10" runat="server" AutoGenerateColumns="False" DataSourceID="SqlSenate"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                         <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Senate Races ngSection -->


                 <!-- Assembly ngSection -->
                 <div class="cssFade" ng-show="assembly" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView11" runat="server" AutoGenerateColumns="False" DataSourceID="sqlAssembly"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Assembly Races ngSection -->


                 <!-- County (all) ngSection -->
                 <div class="cssFade" ng-show="county" >
                  <div class="col-md-12"> 
                  <asp:GridView ID="GridView23" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCounty"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->

                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>  
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end County (all) Races ngSection -->
                  

                 <!-- Administrator ngSection -->
                 <div class="cssFade" ng-show="administrator" >
                  <div class="col-md-12">     
                  <asp:GridView ID="GridView13" runat="server" AutoGenerateColumns="False" DataSourceID="sqlAdministrator"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Administrator Races ngSection -->


                 <!-- Constable ngSection -->
                 <div class="cssFade" ng-show="constable" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView14" runat="server" AutoGenerateColumns="False" DataSourceID="sqlConstable"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->

                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Constable Races ngSection -->


                 <!-- Judge ngSection -->
                 <div class="cssFade" ng-show="judge" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView15" runat="server" AutoGenerateColumns="False" DataSourceID="sqlJudge"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol mobileFix" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>             
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Judge Races ngSection -->


                 <!-- Regent ngSection -->
                 <div class="cssFade" ng-show="regent" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView16" runat="server" AutoGenerateColumns="False" DataSourceID="sqlRegent"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default"> 
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" > 
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>          
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Regent Races ngSection -->


                 <!-- Board ngSection -->
                 <div class="cssFade" ng-show="board" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="sqlBoard"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default"> 
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" > 
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>          
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Board Races ngSection -->
                  

                 <!-- Trustee ngSection -->
                 <div class="cssFade" ng-show="trustee" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTrustee"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default"> 
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" > 
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>          
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Trustee Races ngSection -->
                  

                 <!-- Sheriff ngSection -->
                 <div class="cssFade" ng-show="sheriff" >
                  <div class="col-md-12">
                  <asp:GridView ID="GridView18" runat="server" AutoGenerateColumns="False" DataSourceID="SqlSheriff"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->

                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Sheriff Races ngSection -->


                 <!-- Peace ngSection -->
                 <div class="cssFade" ng-show="peace" >
                  <div class="col-md-12">       
                  <asp:GridView ID="GridView19" runat="server" AutoGenerateColumns="False" DataSourceID="SqlPeace"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->

                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Peace Races ngSection -->
                  
    
                 <!-- Supreme ngSection -->
                 <div class="cssFade" ng-show="supreme" >
                  <div class="col-md-12">     
                  <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataSourceID="sqlSupreme"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Supreme Races ngSection -->
                  

                 <!-- Secretary of State ngSection -->
                 <div class="cssFade" ng-show="secretary" >
                  <div class="col-md-12">     
                  <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" DataSourceID="SqlSecretary"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Secretary Races ngSection -->
                  

                 <!-- Treasurer ngSection -->
                 <div class="cssFade" ng-show="treasurer" >
                  <div class="col-md-12">     
                  <asp:GridView ID="GridView12" runat="server" AutoGenerateColumns="False" DataSourceID="SqlTreasurer"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Treasurer Races ngSection -->
                  
  
                 <!-- Attorney ngSection -->
                 <div class="cssFade" ng-show="attorney" >
                  <div class="col-md-12">     
                  <asp:GridView ID="GridView22" runat="server" AutoGenerateColumns="False" DataSourceID="SqlAttorney"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>

                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol mobileFix" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->
                                   
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
                  </div> <!-- end Attorney Races ngSection -->
                  

                  </div>  <%--  END filteredResults --%>

                  </div><%--  END runat server --%>
                  </div><%--  END row --%>
                  
                  
 


               <!-- Question -->
                  
               <!-- filteredResults -->                 
               <div ng-show="filteredResults">
                    
               <div class="row" class="cssFade" ng-show="question">
                      
               <!-- Question DATA -->
               <div id="divQuestion" runat="server" style="border-style: none; text-align: center;" >
                   
                <!-- SQL by Question -->
                <asp:SqlDataSource ID="SqlQuestion" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS_STAGING S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME  AND  UPPER(C.CONTEST_FULL_NAME) LIKE '%QUESTION%' ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                </asp:SqlDataSource>

                      
                 <!-- QUESTIONS -->
                  <div class="col-md-12">
                  <asp:GridView ID="GridView17" runat="server" AutoGenerateColumns="False" DataSourceID="SqlQuestion"
                      DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                      Width="100%" ShowHeader="False" ShowFooter="False">
                      <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                          VerticalAlign="Top" />
                      <Columns>
                          <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                              <ItemTemplate>
                                  <br />
                                  <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                      Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt" CssClass="mobileFont"></asp:Label>
                                  <br />
                                  <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Bold="True" 
                                  Font-Names="Trebuchet MS"></asp:Label>
                                  <br />
                                  <br />
                                  <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                  <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                      Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                          ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                          Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                              Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/resources/pngs/0.png','~/resources/pngs/' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '.png') GRAPH_URL FROM ENR.ELECTION_RESULTS_STAGING S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                          <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                              Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                      
                                  <!-- panel -->
                                  <div class="panel panel-default">
                                  <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                      CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                      Font-Size="10pt"  OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                      ShowFooter="True" CssClass="table ng-scope ng-table mobileRemoveCol" GridLines="None" RowStyle-Width="100%">
                                      <RowStyle VerticalAlign="Top" Wrap="False" />
                                      <Columns>
                                          <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                              HeaderStyle-HorizontalAlign="left" >
                                              <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                          </asp:BoundField>
                                          <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="" HeaderStyle-HorizontalAlign="center" >
                                              <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                          </asp:ImageField>
                                          <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Right" >
                                              <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                          </asp:BoundField>
                                          <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                          <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="right" >
                                              <ItemStyle Width="110px" HorizontalAlign="right" />
                                          </asp:TemplateField>
                                      </Columns>
                                      <FooterStyle HorizontalAlign="left" />
                                  </asp:GridView>
                                  </div> <!-- end panel class div -->

                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                  </asp:GridView>
                  </div>  <!-- end cold-md-12 -->
               </div> <!-- END divQuestion -->
               </div> <!-- END row -->

            </div> <!-- END filteredResults section -->


                <!-- Footer -->
                <hr/>
                <h4>
                    <a class="footerAdjust" style="font-size:14px;" href="http://www.clarkcountynv.gov/pages/copyright.aspx">&copy; 2014 Clark County, NV</a>
                    <!-- Universal lang select -->
                    <div style="float:right; font-size:14px; margin-top:3px;"> 
                        <a href="http://redrock.clarkcountynv.gov/melectionresults">ENG</a> |
                        <a style="" href="http://redrock.clarkcountynv.gov/melectionresults/enr_sp.aspx"> SP</a> |
                        <a style="" href="http://redrock.clarkcountynv.gov/melectionresults/enr_fil.aspx"> FIL&nbsp;&nbsp;</a>
                    </div>
                </h4>
                <hr/>
            </div> 
            </div>
        </div>
      </form>
      <!-- Libs -->
      <!-- jQuery lib -->
      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
      <!-- Bootstrap lib -->
      <script type="text/javascript" src="js/lib/bootstrap.min.js"></script>
      <!-- Angular -->
      <script type="text/javascript" data-require="angular.js@*" data-semver="1.2.0-rc3-nonmin" src="https://code.angularjs.org/1.2.0-rc.3/angular.js"></script>
      <script data-require="angular-animate@*" data-semver="1.2.1" src="https://code.angularjs.org/1.2.1/angular-animate.js"></script>
      <!-- Scripts -->
      <script src="js/app.js"></script>
      <script src="js/scrollButton.js"></script>
      <script src="js/persist.js"></script>
      <script src="js/controller.js"></script>
  </body>
  </html>