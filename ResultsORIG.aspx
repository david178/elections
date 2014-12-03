<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ResultsORIG.aspx.vb" Inherits="ElectionResults.ResultsORIG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Election Results</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="frmMain" runat="server">
        <div style="text-align: left">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT '0' AS ELECTION_CODE, ' ' AS ELECNAME, NULL AS ELECDATE FROM SYS.DUAL UNION SELECT ER.ELECTION_CODE, WE.ELECNAME || ' (' || WE.ELECDATE || ')' AS ELECNAME, WE.ELECDATE FROM CLARK.CL_ELECTION_RESULTS ER, CLARK.CL_WEB_ELECTION WE WHERE ER.ELECTION_CODE=WE.ELECTION_CODE AND ER.ELECTION_SUBCODE = '00' ORDER BY ELECDATE DESC">
            </asp:SqlDataSource>
            <asp:Table ID="tblMain" runat="server" HorizontalAlign="Left" CellSpacing="0" CellPadding="0">
                <asp:TableRow>
                    <asp:TableCell>
                        &nbsp;
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        Select an election:
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="left">
                        <asp:DropDownList ID="ddlElection" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                            DataTextField="ELECNAME" DataValueField="ELECTION_CODE">
                        </asp:DropDownList>&nbsp;
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        &nbsp;
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        Select the type of information:
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="left">
                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="" Selected="True"> </asp:ListItem>
                            <asp:ListItem Value="1">OFFICIAL ELECTION RESULTS</asp:ListItem>
                            <asp:ListItem Value="2">EARLY VOTE TURNOUT SUMMARY</asp:ListItem>
                            <asp:ListItem Value="3">STATEMENT OF VOTE (RESULTS BY PRECINCT)</asp:ListItem>
                            <asp:ListItem Value="4">VOTER TURNOUT DATA FILE (BY VOTE METHOD)</asp:ListItem>
                            <asp:ListItem Value="5">BALLOT QUESTIONS (TEXT AND AUDIO)</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:MultiView ID="MultiView" runat="server" ActiveViewIndex="0">
                            <%--Display Nothing--%>
                            <asp:View ID="View1" runat="server">
                                <asp:Table ID="tblView1" runat="server" HorizontalAlign="Left" CellSpacing="0" CellPadding="0"
                                    Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:View>
                            <%--Display Election Results--%>
                            <asp:View ID="View2" runat="server">
                                <asp:Table ID="tblView2" runat="server" HorizontalAlign="Left" CellSpacing="0" CellPadding="0"
                                    Width="530px">
                                    <%--Display Registration and Turnout--%>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            &nbsp;
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlElection" DefaultValue="" Name="ELECTION_CODE"
                                                        PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2"
                                                DataKeyNames="CONTEST_FULL_NAME" BorderStyle="None" BorderWidth="0px" Width="100%">
                                                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                                    VerticalAlign="Top" />
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <p align="center">
                                                                <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                                                    Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                                                <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                                                    Font-Names="Verdana"></asp:Label><strong>&nbsp;REGISTERED VOTERS</strong>
                                                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddlElection" DefaultValue="" Name="ELECTION_CODE"
                                                                            PropertyName="SelectedValue" />
                                                                        <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                                            Type="String" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <asp:Table ID="tblHeaderRow1" runat="server" Width="100%" BorderStyle="Ridge" BorderWidth="0"
                                                                    CellPadding="1" CellSpacing="1">
                                                                    <asp:TableRow>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="300px"
                                                                            HorizontalAlign="left" BackColor="lightblue">
                                                                            <asp:Label ID="Label1" runat="server" Text="Voting Method" Font-Bold="True"></asp:Label>
                                                                        </asp:TableCell>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="110px"
                                                                            HorizontalAlign="center" BackColor="lightblue" Font-Bold="true">Turnout</asp:TableCell>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="110px"
                                                                            HorizontalAlign="center" BackColor="lightblue" Font-Bold="true">%/Reg</asp:TableCell>
                                                                    </asp:TableRow>
                                                                </asp:Table>
                                                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"
                                                                    BorderStyle="Solid" CellPadding="1" CellSpacing="1" DataMember="DefaultView"
                                                                    Font-Names="Verdana" Font-Size="10pt" BorderWidth="1px" OnRowDataBound="GridView2_RowDataBound"
                                                                    ShowHeader="false" ShowFooter="True">
                                                                    <RowStyle VerticalAlign="Top" Wrap="False" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                                            HeaderStyle-HorizontalAlign="left">
                                                                            <ItemStyle Wrap="False" Width="300px" HorizontalAlign="left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="VOTES" HeaderText="Turnout" HeaderStyle-HorizontalAlign="Center">
                                                                            <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                                                        <asp:TemplateField HeaderText="%/Reg" HeaderStyle-HorizontalAlign="center">
                                                                            <ItemStyle Width="110px" HorizontalAlign="right" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="LightGray" />
                                                                </asp:GridView>
                                                            </p>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    
                                    <%--Display Registration and Turnout for City Elections--%>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:SqlDataSource ID="sqlCityTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL, UPPER(MUNI_NAME) AS MUNI_NAME, ELECTION_SUBCODE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE <> '00' AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY ELECTION_SUBCODE, TO_NUMBER(CONTEST_ORDER)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlElection" DefaultValue="" Name="ELECTION_CODE"
                                                        PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCityTurnout"
                                                DataKeyNames="MUNI_NAME" BorderStyle="None" BorderWidth="0px" Width="100%">
                                                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                                    VerticalAlign="Top" />
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <p align="center">
                                                                <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("MUNI_NAME") %>'
                                                                    Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                                                <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                                                    Font-Names="Verdana"></asp:Label><strong>&nbsp;REGISTERED VOTERS</strong>
                                                                <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE <> '00' AND UPPER(MUNI_NAME)=:OFFICE AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddlElection" DefaultValue="" Name="ELECTION_CODE"
                                                                            PropertyName="SelectedValue" />
                                                                        <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                                            Type="String" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <asp:Table ID="tblHeaderRow1" runat="server" Width="100%" BorderStyle="Ridge" BorderWidth="0"
                                                                    CellPadding="1" CellSpacing="1">
                                                                    <asp:TableRow>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="300px"
                                                                            HorizontalAlign="left" BackColor="PeachPuff">
                                                                            <asp:Label ID="Label1" runat="server" Text="Voting Method" Font-Bold="True"></asp:Label>
                                                                        </asp:TableCell>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="110px"
                                                                            HorizontalAlign="center" BackColor="PeachPuff" Font-Bold="true">Turnout</asp:TableCell>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="110px"
                                                                            HorizontalAlign="center" BackColor="PeachPuff" Font-Bold="true">%/Reg</asp:TableCell>
                                                                    </asp:TableRow>
                                                                </asp:Table>
                                                                <asp:GridView ID="gvCityTurnout" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource8"
                                                                    BorderStyle="Solid" CellPadding="1" CellSpacing="1" DataMember="DefaultView"
                                                                    Font-Names="Verdana" Font-Size="10pt" BorderWidth="1px" OnRowDataBound="gvCityTurnout_RowDataBound"
                                                                    ShowHeader="false" ShowFooter="True">
                                                                    <RowStyle VerticalAlign="Top" Wrap="False" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Voting Method" SortExpression="CANDIDATE_FULL_NAME"
                                                                            HeaderStyle-HorizontalAlign="left">
                                                                            <ItemStyle Wrap="False" Width="300px" HorizontalAlign="left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="VOTES" HeaderText="Turnout" HeaderStyle-HorizontalAlign="Center">
                                                                            <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                                                        <asp:TemplateField HeaderText="%/Reg" HeaderStyle-HorizontalAlign="center">
                                                                            <ItemStyle Width="110px" HorizontalAlign="right" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="LightGray" />
                                                                </asp:GridView>
                                                            </p>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    
                                    <asp:TableRow>
                                        <asp:TableCell><hr /></asp:TableCell>
                                    </asp:TableRow>
                                                       
                                    <%--Display Contests--%>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, VOTE_FOR, TOTAL_PRECINCTS, DECODE(CONTEST_TYPE,'0','Candidate', 'Response') AS CONTEST_TYPE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND TO_NUMBER(CONTEST_TYPE) >= 0 ORDER BY TO_NUMBER(CONTEST_ORDER)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlElection" DefaultValue="" Name="ELECTION_CODE"
                                                        PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4"
                                                DataKeyNames="CONTEST_FULL_NAME" BorderStyle="None" BorderWidth="0px" Width="100%">
                                                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                                    VerticalAlign="Top" />
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <p align="center">
                                                                <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                                                    Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                                                <strong>VOTE FOR </strong>
                                                                <asp:Label ID="lblVoteFor" runat="server" Text='<%# Eval("VOTE_FOR") %>' Font-Bold="True"
                                                                    Font-Names="Verdana" Font-Size="10pt"></asp:Label><asp:Label ID="lblPrecincts" Font-Bold="true"
                                                                        runat="server" Text="&nbsp;&nbsp;-&nbsp;&nbsp;PRECINCTS: "></asp:Label><asp:Label
                                                                            ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                                                            Font-Names="Verdana" Font-Size="10pt"></asp:Label>
                                                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, IS_WINNER, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, CONTEST_TYPE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddlElection" DefaultValue="" Name="ELECTION_CODE"
                                                                            PropertyName="SelectedValue" />
                                                                        <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                                                            Type="String" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <asp:Table ID="tblHeaderRow2" runat="server" Width="100%" BorderStyle="Ridge" BorderWidth="0"
                                                                    CellPadding="1" CellSpacing="1">
                                                                    <asp:TableRow>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="300px"
                                                                            HorizontalAlign="left" BackColor="lightgreen">
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("CONTEST_TYPE") %>' Font-Bold="True"></asp:Label>
                                                                        </asp:TableCell>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="110px"
                                                                            HorizontalAlign="center" BackColor="lightgreen" Font-Bold="true">Votes</asp:TableCell>
                                                                        <asp:TableCell BorderStyle="Ridge" BorderColor="gray" BorderWidth="1px" Width="110px"
                                                                            HorizontalAlign="center" BackColor="lightgreen" Font-Bold="true">%/Total</asp:TableCell>
                                                                    </asp:TableRow>
                                                                </asp:Table>
                                                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                                                    BorderStyle="Solid" CellPadding="1" CellSpacing="1" DataMember="DefaultView"
                                                                    Font-Names="Verdana" Font-Size="10pt" BorderWidth="1px" OnRowDataBound="GridView4_RowDataBound"
                                                                    ShowHeader="false" ShowFooter="True">
                                                                    <RowStyle VerticalAlign="Top" Wrap="False" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="" SortExpression="CANDIDATE_FULL_NAME"
                                                                            HeaderStyle-HorizontalAlign="left">
                                                                            <ItemStyle Wrap="False" Width="300px" HorizontalAlign="left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="VOTES" HeaderText="" HeaderStyle-HorizontalAlign="Center">
                                                                            <ItemStyle Wrap="False" Width="110px" HorizontalAlign="right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="IS_WINNER" HeaderText="" Visible="false"></asp:BoundField>
                                                                        <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                                                        <asp:TemplateField HeaderText="" HeaderStyle-HorizontalAlign="center">
                                                                            <ItemStyle Width="110px" HorizontalAlign="right" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <HeaderStyle BackColor="LightGreen" />
                                                                    <FooterStyle BackColor="LightGray" />
                                                                </asp:GridView>
                                                            </p>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:View>
                            <%--Display Early Vote Turnout by Site--%>
                            <asp:View ID="View3" runat="server">
                                <asp:Table ID="tblView3a" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1">
                                    <%--Display Turnout--%>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rEVTurnoutMsg" runat="server">
                                        <asp:TableCell>
                                            <asp:Label ID="lblEVTurnout" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rEVTotals" runat="Server">
                                        <asp:TableCell Font-Bold="true" Font-Size="11pt" HorizontalAlign="left">Accumulated Totals</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT LIST_ORDER, EV_SITE, TRIM(TO_CHAR(SUM(DECODE(EV_SESSION, EV_SESSION, SITE_TURNOUT, NULL)),'FM999,999')) AS TURNOUT FROM CL_EV_TURNOUT WHERE ELECTION_CODE=:ELECTION_CODE GROUP BY LIST_ORDER, EV_SITE ORDER BY LIST_ORDER">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlElection" DefaultValue="" Name="ELECTION_CODE"
                                                        PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource6"
                                                DataKeyNames="EV_SITE" BorderStyle="Groove" CellPadding="3" BorderWidth="2px" ShowFooter="true">
                                                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                                    VerticalAlign="Top" />
                                                <Columns>
                                                    <asp:BoundField DataField="EV_SITE" HeaderText="Early Voting Site" HeaderStyle-HorizontalAlign="left">
                                                        <ItemStyle Wrap="False" Width="300px" HorizontalAlign="left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="TURNOUT" HeaderText="Turnout" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemStyle Wrap="False" Width="100px" HorizontalAlign="right" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle BackColor="LightBlue" />
                                                <FooterStyle BackColor="LightGray" />
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <asp:Table ID="tblView3b" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1" Width="100%">
                                    <%--Display Daily Turnout--%>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left" Font-Bold="true" Font-Size="11pt">
                                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rNLV1" runat="server">
                                        <asp:TableCell HorizontalAlign="left">
                                            <font size="medium"><strong>N. Las Vegas In-Office Voting</strong></font><br />
                                            <br />
                                            <asp:PlaceHolder ID="PlaceHolderNLV" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="rNLV2" runat="server">
                                        <asp:TableCell>
                                                &nbsp;
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell ID="rWeek1" runat="server" HorizontalAlign="left">
                                            <font size="medium"><strong>Daily Turnout - Week 1</strong></font><br />
                                            <br />
                                            <asp:PlaceHolder ID="PlaceHolderW1" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                                &nbsp;
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell ID="rWeek2" runat="server" HorizontalAlign="left">
                                            <font size="medium"><strong>Daily Turnout - Week 2</strong></font><br />
                                            <br />
                                            <asp:PlaceHolder ID="PlaceHolderW2" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:View>
                            <%--Display Statement of Vote--%>
                            <asp:View ID="View4" runat="server">
                                <asp:Table ID="tblView4" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>NOTE: To download a Report or Data File, right-click on the link and choose <i>Save Target As...</i> (depending on your browser).</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:View>
                            <%--Voter Turnout Data File--%>
                            <asp:View ID="View5" runat="server">
                                <asp:Table ID="Table1" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            The Voted History File is a formatted text file containing a list of voters who voted in the selected election. Voting history is only available for voters as far back as the 1996 General Election. A file layout is provided below:
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <asp:Table ID="tblLayout" runat="server" CellPadding="3" CellSpacing="1" BorderStyle="Groove"
                                                BorderWidth="2" Width="100%">
                                                <asp:TableRow>
                                                    <asp:TableCell BackColor="lightblue" Font-Bold="true" Width="150px" BorderStyle="Groove"
                                                        BorderWidth="2">Column</asp:TableCell>
                                                    <asp:TableCell BackColor="lightblue" Font-Bold="true" BorderStyle="Groove" BorderWidth="2">Description</asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">IDNUMBER</asp:TableCell>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">Voter Registration Number</asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">VOTER_NAME</asp:TableCell>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">Voter Name (Last, First)</asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">VOTING_METHOD</asp:TableCell>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">Method of Voting (ED=Election Day, EV=Early Vote, MB=Mail Ballot)</asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">PRECINCT</asp:TableCell>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">Voter Precinct</asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">BALLOT_PARTY</asp:TableCell>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">Ballot Party Voted (If Partisan Election)</asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">DATE_VOTED</asp:TableCell>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">Date Voter Voted (Session Date for EV, Election Date for ED or MB)</asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">ELECTION_CODE</asp:TableCell>
                                                    <asp:TableCell BorderStyle="Groove" BorderWidth="2">Code Identifying Election (e.g., 10P for 2010 Primary Election)</asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:Button ID="btnGenerateVH" runat="server" Text="Generate Voter History File" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>By clicking on the button above, the file will be generated and you will be prompted to save your file once it is created.  
                                        This process may take up to a minute depending on your connection speed. <strong>PLEASE WAIT</strong> for the File Download dialog to appear...</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:View>
                            <%--Display Ballot Questions--%>
                            <asp:View ID="View6" runat="server">
                                <asp:Table ID="Table2" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <asp:Label ID="lblBQMsg" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="left">
                                            <asp:PlaceHolder ID="PlaceHolder4" runat="server"></asp:PlaceHolder>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:View>
                        </asp:MultiView>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>&nbsp;</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
</body>
</html>
