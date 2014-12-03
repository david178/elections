<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ENR.aspx.vb" Inherits="ElectionResults.ENR" %>

<%@ Register TagPrefix="aspGraph" TagName="Image" Src="graph.ascx" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">--%>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Election Results</title>

    
    
    <!-- Refresh Every 30mins -->
    <!-- <meta http-equiv="refresh" content="1800" /> -->
    <!-- Style -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="css/mediaQueries.css" rel="stylesheet" />
    <link href="css/dropdown.css" rel="stylesheet" />
    <link href="css/animate.css" rel="stylesheet" />
    <link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet" />
    


</head>
<body  ng-app="main" ng-controller="DemoCtrl" > <!-- style="text-align: center;" -->
    <form id="frmMain" runat="server">
    
    
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
            <a href="/" class="navbar-brand"><img id="CountyLogo" title="Visit the County's Homepage" alt="Visit the County's Homepage" src="resources/img_icons/brightened2ico.ico" />
              <div id="logoTitle" >2014 Primary Election</div></a>
            </div>
            <nav class="collapse navbar-collapse " role="navigation">
              <ul class="nav navbar-nav navbar-right">
                <li>
                    <a target="_blank" href="http://www.silverstateelection.com/">
                    <i class="fa fa-bar-chart-o" style="margin-right:8px;" ></i>StateWide</a>
                  </li>
                  <li>
                      <a target="_blank" href="http://www.clarkcountynv.gov/depts/election/Pages/ENR.aspx">
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
                 <div class="col-md-3" id="leftCol" >
                  <!-- Future General Filter by Race Options (ng-show/hide tables) -->
<%--                  <div class="well">

                </div>--%>

              </div>  
              <div class="col-md-9">
              

                <!-- Head Description Block -->
                <div class="headerAdjust" id="headDescription">

                  <h1 id="sec0">Official Final Results</h1>
                    <div id="timeStamp"> <a href="javascript:history.go(0)">Click to refresh the page</a></div>

                    <i style="font-size:12px; color:gray;">This page automatically refreshes every 30 minutes.</i>

                  </br></br>

                  Statewide election results are available on the <a title="" href="http://www.silverstateelection.com/" >Secretary of State's website.</a>

                </div>
                


                <br/>
                


                <!-- Filter by Section Options (ng-show/hide tables) -->
                <div class="headerAdjust" id="filterSection">
                                                
                    <span class="custom-dropdown custom-dropdown--white">
                        <select class="custom-dropdown__select custom-dropdown__select--white" ng-model="myDropDown">
                            <option value="all">All Turnout & Races</option>
                            <option value="turnonly">Turnout Only</option>
                            <option value="raceonly">Races Only</option>
                            <option value="munionly">Muni Races Only</option>
                            <option value="senateonly">Senate Races Only</option>
                            <option value="congressonly">Congress</option>
                            <option value="questionsonly">Questions Only</option>
                        </select>
                    </span>
                    
                </div>
                
                
                
                
                
                




                <!-- divider -->
                <hr class="cssFade" ng-show="myDropDown=='all' || myDropDown=='turnonly'" ng-hide="myDropDown=='munionly'  || myDropDown=='senateonly'  || myDropDown=='congressonly'  || myDropDown=='questionsonly'"  >
                


                <!-- Turnout ngSection -->
                <div class="cssFade" ng-show="myDropDown=='all' || myDropDown=='turnonly'" ng-hide="myDropDown=='munionly'  || myDropDown=='senateonly'  || myDropDown=='congressonly'  || myDropDown=='questionsonly'" >
                

                <!-- Turnout -->
                <h2 id="sec1" class="flag" style="line-height: 1.428571429 !important;">Turnout</h2>

                <p> <!-- heading text --> </p>
              
                <div class="row" >
                    
                    
                    
                    
            <!-- LIVE TURNOUT DATA -->
             <div id="divRegAndTurnout" runat="server" style="border-style: none; text-align: center;" >
                 
                    <!-- orig data source -->
                 <%--  \<asp:SqlDataSource ID="sqlTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL > 0 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
                    </asp:SqlDataSource>
                    --%>

                     <asp:SqlDataSource ID="sqlTurnout1" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL = 775859 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
                    </asp:SqlDataSource>
                    
                     <asp:SqlDataSource ID="sqlTurnout2" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL = 347560 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
                    </asp:SqlDataSource>

                     <asp:SqlDataSource ID="sqlTurnout3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL = 243079 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
                    </asp:SqlDataSource>
                    
                     <asp:SqlDataSource ID="sqlTurnout4" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL = 185220 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
                    </asp:SqlDataSource>
                    
                    <!-- CONTEST_FULL_NAME='REGISTRATION & TURNOUT' AND -->
                    
                    
                    
                    
                    
                    

                    
                    
               <div class="col-md-6">


                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTurnout1"
                        DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                        Width="100%"   >

                        <Columns>
                            

                            <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                <ItemTemplate>
                                    <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                        Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt"></asp:Label><br />
                                        <i class="icon-ok" style=""></i> <!-- Ok -->
                                    <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                        Font-Names="Trebuchet MS"></asp:Label><strong>&nbsp;Registered Voters</strong>  <%--<i class="icon-flag icon-4x pull-left icon-border"></i>--%>
                                        

                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Edge Turnout', 'Election Day Turnout', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
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
                                                </asp:BoundField>
                                                <asp:BoundField DataField="VOTES" HeaderText="Total" >
                                                    <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                                <asp:TemplateField HeaderText="%/Reg" >
                                                    <ItemStyle Width="110px" HorizontalAlign="right" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle  HorizontalAlign="left" />
<%--                                            <HeaderStyle Font-Size="11pt" />--%>
                                        </asp:GridView>
                                    
                                    </div> <!-- end panel class div -->
                                                                                            

                                </ItemTemplate>
                            </asp:TemplateField>
                            

                        </Columns>
                        

                    </asp:GridView>

             </div>  <!-- end cold-md-6 -->
             
             
             
             
             
             

              <div class="col-md-6">
                  
                 

                    <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTurnout2"
                        DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                        Width="100%"   >

                        <Columns>
                            

                            <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                <ItemTemplate>
                                    <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                        Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt"></asp:Label><br />
                                        <i class="icon-ok" style=""></i> <!-- Ok -->
                                    <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                        Font-Names="Trebuchet MS"></asp:Label><strong>&nbsp;Registered Voters</strong>
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Edge Turnout', 'Election Day Turnout', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    
                                    

                                     <!-- panel -->
                                    <div class="panel panel-default">

                                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"
                                            CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                        Font-Size="10pt" OnRowDataBound="GridView2_RowDataBound" ShowHeader="True" ShowFooter="True" CssClass="table ng-scope ng-table" GridLines="None">
                                            <RowStyle VerticalAlign="Top" Wrap="False" />
                                            <Columns>
                                                <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                    >
                                                    <ItemStyle Wrap="False" Width="230px" HorizontalAlign="left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="VOTES" HeaderText="Total" >
                                                    <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                                <asp:TemplateField HeaderText="%/Reg" >
                                                    <ItemStyle Width="110px" HorizontalAlign="right" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle  HorizontalAlign="left" />
                                        </asp:GridView>
                                    
                                        </div> <!-- end panel class div -->
                                 

                                </ItemTemplate>
                            </asp:TemplateField>
                            

                        </Columns>
                        

                    </asp:GridView>
                    

             </div>  <!-- end cold-md-6 -->
             
             
             
             
              <div class="col-md-6">


                    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTurnout3"
                        DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                        Width="100%"   >

                        <Columns>
                            

                            <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                <ItemTemplate>
                                    <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                        Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt"></asp:Label><br />
                                        <i class="icon-ok" style=""></i> <!-- Ok -->
                                    <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                        Font-Names="Trebuchet MS"></asp:Label><strong>&nbsp;Registered Voters</strong>
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Edge Turnout', 'Election Day Turnout', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    
                                    
                                    <!-- panel -->
                                   <div class="panel panel-default">

                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"
                                        CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                        Font-Size="10pt" OnRowDataBound="GridView2_RowDataBound" ShowHeader="True" ShowFooter="True" CssClass="table ng-scope ng-table" GridLines="None">
                                        <RowStyle VerticalAlign="Top" Wrap="False" />
                                        <Columns>
                                            <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                >
                                                <ItemStyle Wrap="False" Width="230px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VOTES" HeaderText="Total" >
                                                <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                            <asp:TemplateField HeaderText="%/Reg" >
                                                <ItemStyle Width="110px" HorizontalAlign="right" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle  HorizontalAlign="left" />
                                    </asp:GridView>
                                    
                                    </div> <!-- end panel -->
                                    
                                    

                                </ItemTemplate>
                            </asp:TemplateField>
                            

                        </Columns>
                        

                    </asp:GridView>

             </div>  <!-- end cold-md-6 -->
             
             
             
             
             <div class="col-md-6">


                    <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTurnout4"
                        DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                        Width="100%"   >

                        <Columns>
                            

                            <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                <ItemTemplate>
                                    <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                        Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="11pt"></asp:Label><br />
                                        <i class="icon-ok" style=""></i> <!-- Ok -->
                                    <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                        Font-Names="Trebuchet MS"></asp:Label><strong>&nbsp;Registered Voters</strong>
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Edge Turnout', 'Election Day Turnout', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    
                                    
                                   <!-- panel -->
                                   <div class="panel panel-default">


                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"
                                        CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                        Font-Size="10pt" OnRowDataBound="GridView2_RowDataBound" ShowHeader="True" ShowFooter="True" CssClass="table ng-scope ng-table" GridLines="None"  >
                                        <RowStyle VerticalAlign="Top" Wrap="False" />
                                        <Columns>
                                            <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                >
                                                <ItemStyle Wrap="False" Width="230px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VOTES" HeaderText="Total" >
                                                <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                            <asp:TemplateField HeaderText="%/Reg" >
                                                <ItemStyle Width="110px" HorizontalAlign="right" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle  HorizontalAlign="left" />
                                    </asp:GridView>
                                    
                                    </div> <!-- end panel -->
                                    
                                    

                                </ItemTemplate>
                            </asp:TemplateField>
                            

                        </Columns>
                        

                    </asp:GridView>

             </div>  <!-- end cold-md-6 -->
             
             

           </div> <!-- end divRegAndTurnout -->
                
                
                
                
                


                </div> <!-- end row -->
              </div> <!-- End Turnout ngSection -->
                
                
                
                
                
                

                

                <!-- divider -->
                <hr class="cssFade" ng-show="myDropDown=='all' || myDropDown=='raceonly'  || myDropDown=='munionly'  || myDropDown=='senateonly'  || myDropDown=='congressonly' || myDropDown=='questionsonly' " ng-hide="myDropDown=='turnonly'" >
                
                
                
                <!-- Races ngSection -->
                <div class="cssFade" ng-show="myDropDown=='all' || myDropDown=='raceonly'  || myDropDown=='munionly'  || myDropDown=='senateonly'  || myDropDown=='congressonly' || myDropDown=='questionsonly' " ng-hide="myDropDown=='turnonly'" >

                <!-- Races -->
                <h2 id="sec2" class="flag" style="line-height: 1.428571429 !important;">Races</h2>
                
                <p> <!-- heading text --> </p>

                <div class="row">


                 
                  
                  
                <!-- LIVE MuniRegAndTurnout DATA -->
                <div id="divMuniRegAndTurnout" runat="server" style="border-style: none; text-align: center;">
                    
                   
                    <asp:SqlDataSource ID="sqlCityTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL, REPLACE(UPPER(PSD_NAME),' - AT LARGE','') AS MUNI_NAME, LIST_ORDER FROM ENR.ELECTION_SUB_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER),TO_NUMBER(LIST_ORDER)">
                    </asp:SqlDataSource>

                    
                    
                    
                    
                    
                    
                    

                <div class="col-md-6">
                                   


                    <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCityTurnout"
                        DataKeyNames="MUNI_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                        Width="100%">
                        <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
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
                                    <asp:GridView ID="gvCityTurnout" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource8"
                                        CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Trebuchet MS"
                                        Font-Size="10pt" BorderWidth="1px" OnRowDataBound="gvCityTurnout_RowDataBound"
                                        ShowHeader="True" ShowFooter="True" CssClass="table ng-scope ng-table" GridLines="None">
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
                                    <br />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    
                    
                    
                    
                 </div>  <!-- end cold-md-6 -->
             
             
             

                </div>
                
                
                
                
                










                  
                  
                  
                  
                  
                  
                    <!-- LIVE Contests DATA -->
                    <div id="divContests" runat="server" style="border-style: none; text-align: center;">

                    <asp:SqlDataSource ID="sqlContests" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
                    </asp:SqlDataSource>
                    
                    
                    
                    
                    <div class="col-md-12">
                                   
                                   
                                   

                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sqlContests"
                        DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                        Width="100%" ShowHeader="False" ShowFooter="False">
                        <RowStyle Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="Small" HorizontalAlign="Center"
                            VerticalAlign="Top" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                <ItemTemplate>
                                    <br />
                                    <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                        Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                                    <br />
                                    <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Names="Verdana"
                                        Font-Size="11pt"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                                    <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                        Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                            ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                            Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                                Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/GenerateImage.aspx?size=null&color=null&height=10','~/GenerateImage.aspx?size=' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '&color=null&height=10') GRAPH_URL FROM ENR.ELECTION_RESULTS S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
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
                                        ShowFooter="True" CssClass="table ng-scope ng-table" GridLines="None"> <%--BorderWidth="1px"--%>
                                        <RowStyle VerticalAlign="Top" Wrap="False" />
                                        <Columns>
                                            <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                                HeaderStyle-HorizontalAlign="left" > <%--   HeaderStyle-BackColor="lightgreen"--%>
                                                <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="Graph" HeaderStyle-HorizontalAlign="center" >
                                                
                                                <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                            </asp:ImageField>
                                            <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Center" >
                                                <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                            <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="center" >
                                                <ItemStyle Width="110px" HorizontalAlign="right" />
                                            </asp:TemplateField>
                                        </Columns>
<%--                                        <HeaderStyle BackColor="LightGreen" Font-Bold = "true" />--%>
                                        <FooterStyle HorizontalAlign="left" /> <%--    BackColor="LightGray" --%>
                                    </asp:GridView>
                                    
                                                                        
                                   </div> <!-- end panel class div -->
                                 
                                    
                                    

                                    

                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    
                    
                                        
                    
                 </div>  <!-- end cold-md-6 -->
             
                </div>
                  

                  
                  
       

                </div>
                </div> <!-- end ng-show | Races -->

                <!-- Footer -->
                <hr>
                <h4>
                  <a class="footerAdjust" href="http://www.clarkcountynv.gov/pages/copyright.aspx">© 2014 Clark County, NV</a>
                </h4>
                <hr>
              </div> 
            </div>
          </div>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          <!-- Legacy GridViews -->
          
                          
            <!-- LIVE HEADER DATA -->
        <%--        <div id="divHeader" runat="server" style="border-style: none; text-align: center;">
                    <br />
                    <br />
                    <asp:SqlDataSource ID="sqlElectionParms" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT ELECTION_TITLE, ELECTION_DATE, DECODE(RESULTS_MODE,NULL,NULL,'<strong><i>'||RESULTS_MODE||'</i></strong><br>')||'Updated '||(SELECT TO_CHAR(MAX(REPORT_DATE),'MM/DD/YYYY HH12:MI AM') FROM ELECTION_RESULTS) AS RESULTS_MODE,DECODE(RESULTS_MSG,NULL,NULL,'<br>'||RESULTS_MSG) AS RESULTS_MSG FROM ELECTION_RESULTS_PARMS">
                    </asp:SqlDataSource>
                    <asp:FormView ID="frmParams" runat="server" DataSourceID="sqlElectionParms" Width="100%"
                        DataKeyNames="ELECTION_TITLE" BorderStyle="None" BorderWidth="0px" EmptyDataText="No election found.">
                        <ItemTemplate>
                            <asp:Label ID="ELECTION_TITLELabel" runat="server" Text='<%# Eval("ELECTION_TITLE") %>'
                                Font-Bold="true" Font-Size="Medium">
                            </asp:Label>
                            <br />
                            <asp:Label ID="ELECTION_DATELabel" runat="server" Text='<%# Eval("ELECTION_DATE") %>'
                                Font-Bold="true" Font-Size="Small">
                            </asp:Label>
                            <br />
                            <br />
                            <asp:Label ID="RESULTS_MODELabel" runat="server" Text='<%# Bind("RESULTS_MODE") %>'
                                Font-Size="small">
                            </asp:Label>
                            <br />
                            <asp:Label ID="RESULTS_MSGLabel" runat="server" Text='<%# Bind("RESULTS_MSG") %>'
                                Font-Bold="true" Font-Size="Small" ForeColor="red">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:FormView>
                </div>--%>
                
                
                

          
          
                  <!-- LIVE TURNOUT DATA -->
<%--        <div id="divRegAndTurnout" runat="server" style="border-style: none; text-align: center;" >
            <br /><br />
            <asp:SqlDataSource ID="sqlTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL > 0 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTurnout"
                DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                Width="100%">
                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Center"
                    VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                        <ItemTemplate>
                            <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                            <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                Font-Names="Verdana"></asp:Label><strong>&nbsp;Registered Voters</strong>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Edge Turnout', 'Election Day Turnout', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"
                                CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Verdana"
                                Font-Size="10pt" OnRowDataBound="GridView2_RowDataBound" ShowHeader="True" ShowFooter="True">
                                <RowStyle VerticalAlign="Top" Wrap="False" />
                                <Columns>
                                    <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                        HeaderStyle-HorizontalAlign="left" HeaderStyle-BackColor="lightblue">
                                        <ItemStyle Wrap="False" Width="230px" HorizontalAlign="left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VOTES" HeaderText="Total" HeaderStyle-HorizontalAlign="Center"
                                        HeaderStyle-BackColor="lightblue">
                                        <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                    <asp:TemplateField HeaderText="%/Reg" HeaderStyle-HorizontalAlign="center" HeaderStyle-BackColor="lightblue">
                                        <ItemStyle Width="110px" HorizontalAlign="right" />
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="LightGray" HorizontalAlign="left" />
                            </asp:GridView>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>--%>
        
        
        
        

        
        
        
                          
            <!-- LIVE MuniRegAndTurnout DATA -->
<%--                <div id="div1" runat="server" style="border-style: none; text-align: center;">
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL, REPLACE(UPPER(PSD_NAME),' - AT LARGE','') AS MUNI_NAME, LIST_ORDER FROM ENR.ELECTION_SUB_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER),TO_NUMBER(LIST_ORDER)">
                </asp:SqlDataSource>
                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCityTurnout"
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
                                <asp:GridView ID="gvCityTurnout" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource8"
                                    CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Verdana"
                                    Font-Size="10pt" BorderWidth="1px" OnRowDataBound="gvCityTurnout_RowDataBound"
                                    ShowHeader="True" ShowFooter="True">
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
                                <br />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
                --%>
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
            <!-- LIVE Contests DATA -->
<%--                    <div id="div2" runat="server" style="border-style: none; text-align: center;">
            <hr />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<BR>VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
            </asp:SqlDataSource>
            <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataSourceID="sqlContests"
                DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                Width="100%" ShowHeader="False" ShowFooter="False">
                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Center"
                    VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                        <ItemTemplate>
                            <br />
                            <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                            <br />
                            <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Names="Verdana"
                                Font-Size="11pt"></asp:Label>
                            <br />
                            <br />
                            <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Precincts Reporting: "></asp:Label>
                            <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>of</strong>&nbsp;<asp:Label
                                    ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                    Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                        Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/GenerateImage.aspx?size=null&color=null&height=10','~/GenerateImage.aspx?size=' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '&color=null&height=10') GRAPH_URL FROM ENR.ELECTION_RESULTS S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                CellPadding="1" CellSpacing="1" DataMember="DefaultView" Font-Names="Verdana"
                                Font-Size="10pt" BorderWidth="1px" OnRowDataBound="GridView4_RowDataBound" ShowHeader="True"
                                ShowFooter="True">
                                <RowStyle VerticalAlign="Top" Wrap="False" />
                                <Columns>
                                    <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                        HeaderStyle-HorizontalAlign="left" HeaderStyle-BackColor="lightgreen">
                                        <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                    </asp:BoundField>
                                    <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="Graph" HeaderStyle-HorizontalAlign="center"
                                        HeaderStyle-BackColor="lightgreen">
                                        <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Center"
                                        HeaderStyle-BackColor="lightgreen">
                                        <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                    <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="center" HeaderStyle-BackColor="lightgreen">
                                        <ItemStyle Width="110px" HorizontalAlign="right" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="LightGreen" />
                                <FooterStyle BackColor="LightGray" HorizontalAlign="left" />
                            </asp:GridView>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>--%>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        



          
     
    </form>
    
    
    

    
    
    
    
    
    
    



    



    

    <!-- Libs -->
    <!-- jQuery lib -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <!-- Bootstrap lib -->
    <script type="text/javascript" src="js/lib/bootstrap.min.js"></script>
    <!-- Angular -->
    <script type="text/javascript" data-require="angular.js@*" data-semver="1.2.0-rc3-nonmin" src="http://code.angularjs.org/1.2.0-rc.3/angular.js"></script>
    <!-- ngTable (Angular Plugin) -->
    <script type="text/javascript" data-require="ng-table@*" data-semver="0.3.0" src="http://bazalt-cms.com/assets/ng-table/0.3.0/ng-table.js"></script>
    <script data-require="angular-animate@*" data-semver="1.2.1" src="http://code.angularjs.org/1.2.1/angular-animate.js"></script>
    
    <!-- Scripts -->
    <script src="js/app.js"></script>
    <script src="js/scrollButton.js"></script>
    <script src="js/timeStamp.js"></script>
    <script src="js/controller.js"></script>

</body>
</html>
