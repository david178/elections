<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Results.aspx.vb" Inherits="ElectionResults.Results" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Election Results</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
</head>
<body style="text-align: center;">
    <form id="frmMain" runat="server">
        <asp:HiddenField ID="hElecCode" runat="server" />
        <div id="divMainID" runat="server" style="text-align: left; border-style: none;">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT '0' AS ELECTION_CODE, ' ' AS ELECNAME, NULL AS ELECDATE FROM SYS.DUAL UNION SELECT ER.ELECTION_CODE, WE.ELECNAME || ' (' || TO_CHAR(WE.ELECDATE,'MM/DD/YYYY') || ')' AS ELECNAME, WE.ELECDATE FROM CLARK.CL_ELECTION_RESULTS ER, CLARK.CL_WEB_ELECTION WE WHERE ER.ELECTION_CODE=WE.ELECTION_CODE AND ER.ELECTION_SUBCODE = '00' ORDER BY ELECDATE DESC">
            </asp:SqlDataSource>
            <br />
            Select an election:<br />
            <asp:DropDownList ID="ddlElection" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                DataTextField="ELECNAME" DataValueField="ELECTION_CODE">
            </asp:DropDownList>
            <br />
            <br />
            Select the type of information:<br />
            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True">
                <asp:ListItem Value="" Selected="True"> </asp:ListItem>
                <asp:ListItem Value="1">OFFICIAL ELECTION RESULTS</asp:ListItem>
                <asp:ListItem Value="2">EARLY VOTE TURNOUT SUMMARY</asp:ListItem>
                <asp:ListItem Value="3">STATEMENT OF VOTE (RESULTS BY PRECINCT)</asp:ListItem>
                <asp:ListItem Value="4">VOTER TURNOUT DATA FILE (BY VOTE METHOD)</asp:ListItem>
                <asp:ListItem Value="5">BALLOT QUESTIONS (TEXT AND AUDIO)</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <hr />
        </div>
        <div id="divHeader" runat="server" style="border-style: none; text-align: center;">
            <asp:MultiView ID="MultiView" runat="server" ActiveViewIndex="0">
                <%--Display Nothing--%>
                <asp:View ID="View1" runat="server">
                    <br />
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    <br />
                </asp:View>
                <%--Display Election Results--%>
                <asp:View ID="View2" runat="server">
                    <br />
                    <asp:Button ID="btnPrintVer" runat="server" Text="Print Version" Font-Size="Smaller" />
                    <br />
                    <br />
                    <%--Display Registration and Turnout--%>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, DECODE(CONTEST_TOTAL, 0, 'TOTAL REGISTERED VOTERS UNAVAILABLE', TO_CHAR(CONTEST_TOTAL, 'FM999,999')||' REGISTERED VOTERS') AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2"
                        DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                        Width="100%">
                        <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
                            VerticalAlign="Top" BorderStyle="None" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                <ItemTemplate>
                                    <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                        Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                    <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                        Font-Names="Verdana"></asp:Label>
                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"
                                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" DataMember="DefaultView"
                                        Font-Names="Verdana" Font-Size="10pt" BorderWidth="1px" OnRowDataBound="GridView2_RowDataBound"
                                        ShowHeader="True" ShowFooter="True" Width="500px">
                                        <RowStyle VerticalAlign="Top" Wrap="False" />
                                        <Columns>
                                            <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                HeaderStyle-HorizontalAlign="left" HeaderStyle-BackColor="lightblue">
                                                <ItemStyle Wrap="False" Width="280px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VOTES" HeaderText="Turnout" HeaderStyle-HorizontalAlign="Center"
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
                    <%--Display Registration and Turnout for City Elections--%>
                    <br />
                    <asp:SqlDataSource ID="sqlCityTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, DECODE(CONTEST_TOTAL, 0, 'TOTAL REGISTERED VOTERS UNAVAILABLE', TO_CHAR(CONTEST_TOTAL, 'FM999,999')||' REGISTERED VOTERS') AS CONTEST_TOTAL, UPPER(MUNI_NAME) AS MUNI_NAME, ELECTION_SUBCODE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE <> '00' AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY ELECTION_SUBCODE, TO_NUMBER(CONTEST_ORDER)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCityTurnout"
                        DataKeyNames="MUNI_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                        Width="100%">
                        <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
                            VerticalAlign="Top" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                                <ItemTemplate>
                                    <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("MUNI_NAME") %>' Font-Bold="True"
                                        Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                    <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                        Font-Names="Verdana"></asp:Label>
                                    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE <> '00' AND UPPER(MUNI_NAME)=:OFFICE AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="gvCityTurnout" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource8"
                                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" DataMember="DefaultView"
                                        Font-Names="Verdana" Font-Size="10pt" BorderWidth="1px" OnRowDataBound="gvCityTurnout_RowDataBound"
                                        ShowHeader="True" ShowFooter="True" Width="500px">
                                        <RowStyle VerticalAlign="Top" Wrap="False" />
                                        <Columns>
                                            <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                HeaderStyle-HorizontalAlign="left" HeaderStyle-BackColor="peachPuff">
                                                <ItemStyle Wrap="False" Width="280px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VOTES" HeaderText="Turnout" HeaderStyle-HorizontalAlign="Center"
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
                    <br />
                    <asp:Label ID="lblResultsMsg" runat="server" Text="" Width="500px"></asp:Label>
                    <hr />
                    <%--Display Contests--%>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, VOTE_FOR, DECODE(TOTAL_PRECINCTS,'0','N/A',TOTAL_PRECINCTS) TOTAL_PRECINCTS, PROCESSED_DONE, DECODE((TO_NUMBER(PROCESSED_DONE) / TO_NUMBER(TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(PROCESSED_DONE) / TO_NUMBER(TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(CONTEST_TYPE,'0','Candidate', 'Response') AS CONTEST_TYPE, 'VOTE FOR '||VOTE_FOR AS CONTEST_MSG FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND TO_NUMBER(CONTEST_TYPE) >= 0 ORDER BY TO_NUMBER(CONTEST_ORDER)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4"
                        DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" ShowHeader="false" BorderStyle="None"
                        BorderWidth="0px" Width="100%">
                        <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
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
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, IS_WINNER, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, CONTEST_TYPE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                        BorderStyle="Solid" CellPadding="1" CellSpacing="1" DataMember="DefaultView"
                                        Font-Names="Verdana" Font-Size="10pt" BorderWidth="1px" OnRowDataBound="GridView4_RowDataBound"
                                        ShowHeader="True" ShowFooter="True" Width="500px">
                                        <RowStyle VerticalAlign="Top" Wrap="False" />
                                        <Columns>
                                            <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate" SortExpression="CANDIDATE_FULL_NAME"
                                                HeaderStyle-HorizontalAlign="left" HeaderStyle-BackColor="lightgreen">
                                                <ItemStyle Wrap="False" Width="280px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-BackColor="lightgreen">
                                                <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="IS_WINNER" HeaderText="" Visible="false"></asp:BoundField>
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
                    <br />
                </asp:View>
                <%--Display Early Vote Turnout by Site--%>
                <asp:View ID="View3" runat="server">
                    <asp:Table ID="tblView3a" runat="server" HorizontalAlign="Left" CellSpacing="0" CellPadding="0"
                        Width="100%">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Table ID="tblSummary" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1" Width="100%">
                                    <%--Display Turnout--%>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <asp:Label ID="lblElection" runat="server" Font-Size="Medium" Font-Bold="true" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="tblCityTotals" runat="server">
                                        <asp:TableCell HorizontalAlign="Center">
                                            <br />
                                            <span style="font-size: medium; font-weight: bold;">Turnout Summary by City</span><br />
                                            <br />
                                            <asp:SqlDataSource ID="sqlCityTotals" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DECODE(MUNI_CODE, 'BOC','Boulder City','HEN','Henderson','LV','Las Vegas','MES','Mesquite','NLV','North Las Vegas',MUNI_CODE) AS CITY, TRIM(TO_CHAR(SUM(DECODE(EV_SESSION, EV_SESSION, SITE_TURNOUT, NULL)),'FM999,999')) AS TURNOUT FROM CL_EV_TURNOUT WHERE ELECTION_CODE=:ELECTION_CODE GROUP BY DECODE(MUNI_CODE, 'BOC','Boulder City','HEN','Henderson','LV','Las Vegas','MES','Mesquite','NLV','North Las Vegas',MUNI_CODE) ORDER BY 1">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                                        Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="grdCityTotals" runat="server" CellPadding="3" AutoGenerateColumns="False"
                                                DataSourceID="sqlCityTotals" DataKeyNames="CITY" BorderStyle="Groove" BorderWidth="2px"
                                                ShowFooter="false">
                                                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                                    VerticalAlign="Top" />
                                                <Columns>
                                                    <asp:BoundField DataField="CITY" HeaderText="City" HtmlEncode="true" HeaderStyle-Width="150px"
                                                        HeaderStyle-HorizontalAlign="left">
                                                        <ItemStyle Wrap="False" Width="150px" HorizontalAlign="left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="TURNOUT" HeaderText="Turnout" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle Wrap="False" Width="100px" HorizontalAlign="right" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle BackColor="LightGreen" />
                                            </asp:GridView>
                                            <br />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rEVTotals" runat="Server">
                                        <asp:TableCell Font-Bold="true" Font-Size="11pt" HorizontalAlign="center">Accumulated Totals</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Center">
                                            <br />
                                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT LIST_ORDER, EV_SITE, TRIM(TO_CHAR(SUM(DECODE(EV_SESSION, EV_SESSION, SITE_TURNOUT, NULL)),'FM999,999')) AS TURNOUT FROM CL_EV_TURNOUT WHERE ELECTION_CODE=:ELECTION_CODE GROUP BY LIST_ORDER, EV_SITE ORDER BY LIST_ORDER">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value"
                                                        Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="gvSiteTurnout" runat="server" CellPadding="3" AutoGenerateColumns="False"
                                                DataSourceID="SqlDataSource6" DataKeyNames="EV_SITE" BorderStyle="Groove" BorderWidth="2px"
                                                ShowFooter="true">
                                                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                                    VerticalAlign="Top" />
                                                <Columns>
                                                    <asp:BoundField DataField="EV_SITE" HeaderText="Early Voting Site" HtmlEncode="true"
                                                        HeaderStyle-Width="360px" HeaderStyle-HorizontalAlign="left">
                                                        <ItemStyle Wrap="False" Width="360px" HorizontalAlign="left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="TURNOUT" HeaderText="Turnout" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle Wrap="False" Width="100px" HorizontalAlign="right" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle BackColor="LightGreen" />
                                                <FooterStyle BackColor="LightGray" HorizontalAlign="left" />
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="center" Font-Bold="true" Font-Size="11pt">
                                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell><br /><hr /><br /></asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <asp:Table ID="tblDaily" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1" Width="100%">
                                    <%--Display Daily Turnout--%>
                                    <asp:TableRow ID="rNLV1" runat="server">
                                        <asp:TableCell HorizontalAlign="Center">
                                            <span style="font-size: medium; font-weight: bold;">North Las Vegas In-Office Voting</span><br />
                                            <br />
                                            <asp:PlaceHolder ID="PlaceHolderNLV" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rNLV2" runat="server">
                                        <asp:TableCell>
                                                &nbsp;
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rWeek1" runat="server">
                                        <asp:TableCell HorizontalAlign="Center">
                                            <asp:Label ID="lblWeek1" runat="server" Font-Bold="true" Font-Size="medium" Text="Daily Turnout - Week 1"></asp:Label><br />
                                            <br />
                                            <asp:PlaceHolder ID="PlaceHolderW1" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                                &nbsp;
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rWeek2" runat="server">
                                        <asp:TableCell HorizontalAlign="Center">
                                            <span style="font-size: medium; font-weight: bold;">Daily Turnout - Week 2</span><br />
                                            <br />
                                            <asp:PlaceHolder ID="PlaceHolderW2" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:View>
                <%--Display Statement of Vote--%>
                <asp:View ID="View4" runat="server">
                    <br />
                    NOTE: To download a Report or Data File, right-click on the link and choose <i>Save
                        Target As...</i> (depending on your browser).
                    <br />
                    <br />
                    <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>
                    <br />
                </asp:View>
                <%--Voter Turnout Data File--%>
                <asp:View ID="View5" runat="server">
                    <asp:Table ID="Table1" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                        CellSpacing="1" Width="100%" HorizontalAlign="left">
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="left">
                                The Voted History File is a formatted text file containing a list of voters who voted in the selected election. Voting history is only available for voters as far back as the 1996 General Election. A file layout is provided below:
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="tblLayout" runat="server" CellPadding="3" CellSpacing="1" BorderStyle="Groove"
                                    BorderWidth="2" Width="700px" HorizontalAlign="center">
                                    <asp:TableRow>
                                        <asp:TableCell BackColor="lightblue" Font-Bold="true" Width="150px" BorderStyle="Groove"
                                            BorderWidth="2" HorizontalAlign="left">Column</asp:TableCell>
                                        <asp:TableCell BackColor="lightblue" Font-Bold="true" BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Description</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">IDNUMBER</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Voter Registration Number</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">VOTER_NAME</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Voter Name (Last, First)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">VOTING_METHOD</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Method of Voting (ED=Election Day, EV=Early Vote, MB=Mail Ballot)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">PRECINCT</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Voter Precinct</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">BALLOT_PARTY</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Ballot Party Voted (If partisan election)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">VOTER_PARTY</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Registered Party (At time of election)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">DATE_VOTED</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Date Voter Voted (Session Date for EV, Election Date for ED or MB)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">ELECTION_CODE</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2" HorizontalAlign="left">Code Identifying Election (e.g., 10P for 2010 Primary Election)</asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="center">
                                <asp:Button ID="btnGenerateVH" runat="server" Text="Generate Voter History File" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="left">By clicking on the button above, the file will be generated and you will be prompted to save your file once it is created.  
                                        This process may take up to a minute depending on your connection speed. <strong>PLEASE WAIT</strong> for the File Download dialog to appear...</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:View>
                <%--Display Ballot Questions--%>
                <asp:View ID="View6" runat="server">
                    <br />
                    <asp:Label ID="lblBQMsg" runat="server" Text=""></asp:Label>
                    <br />
                    <br />
                    <asp:PlaceHolder ID="PlaceHolder4" runat="server"></asp:PlaceHolder>
                    <br />
                </asp:View>
            </asp:MultiView>
        </div>
    </form>
</body>
</html>
