<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ENR_TV.aspx.vb" Inherits="ElectionResults.ENR_TV" %>

<%@ Register TagPrefix="aspGraph" TagName="Image" Src="graph.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Election Results</title>
    <link href="StyleSheet_TV.css" type="text/css" rel="stylesheet" />
    <meta http-equiv="refresh" content="5" />
</head>
<body>
    <form id="frmMain" runat="server">
        <div id="divHeader" runat="server" style="border-style:none;text-align:center;">
            <p style="border-style:none;text-align:center;">
                <asp:SqlDataSource  ID="sqlElectionParms" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT ELECTION_TITLE, DECODE(RESULTS_MODE,NULL,NULL,'<strong><i>'||RESULTS_MODE||'</i></strong><br>')||(SELECT TO_CHAR(MAX(REPORT_DATE),'MM/DD/YYYY HH:MI AM') FROM ELECTION_RESULTS) AS RESULTS_MODE,DECODE(RESULTS_MSG,NULL,NULL,'<br>'||RESULTS_MSG) AS RESULTS_MSG FROM ELECTION_RESULTS_PARMS">
                </asp:SqlDataSource>
                <asp:FormView ID="frmParams" runat="server" DataSourceID="sqlElectionParms" Width="100%"
                    DataKeyNames="ELECTION_TITLE" BorderStyle="None" BorderWidth="0px"  EmptyDataText="No election found.">
                    <ItemTemplate>
                        <br />
                        <asp:Label ID="ELECTION_TITLELabel" runat="server" Text='<%# Eval("ELECTION_TITLE") %>'
                            Font-Bold="true" Font-Size="22pt">
                        </asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="RESULTS_MODELabel" runat="server" Text='<%# Bind("RESULTS_MODE") %>'
                            Font-Size="medium">
                        </asp:Label>
                        <br />
                        <asp:Label ID="RESULTS_MSGLabel" runat="server" Text='<%# Bind("RESULTS_MSG") %>'
                            Font-Bold="true" Font-Size="Small" ForeColor="cyan">
                        </asp:Label>
                    </ItemTemplate>
                </asp:FormView>
            </p>
        </div>
        <div id="divContests" runat="server" style="text-align: center">
            <%--Display Contests--%>
            <asp:SqlDataSource ID="sqlContests" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="">
            </asp:SqlDataSource>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sqlContests"
                DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                BackColor="Black" BorderColor="Black" Width="100%" ShowHeader="False">
                <RowStyle Font-Bold="False" Font-Names="Arial" Font-Size="Large" HorizontalAlign="Center"
                    VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField  ShowHeader="False" ItemStyle-BorderStyle="None">
                        <ItemTemplate>
                            <p style="text-align: center;">
                                <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                    Font-Bold="True" Font-Names="Arial" Font-Size="18pt"></asp:Label>
                                <br />
                                <asp:Label ID="lblContestMsg" runat="server" Text='<%# Eval("CONTEST_MSG") %>' Font-Names="Arial"
                                    Font-Size="14pt"></asp:Label>
                                <%--<br />
                                <asp:Label ID="lblVoteForTxt" Font-Size="14pt" runat="server" Text="VOTE FOR "></asp:Label>
                                <asp:Label ID="lblVoteFor" runat="server" Text='<%# Eval("VOTE_FOR") %>' Font-Names="Arial"
                                    Font-Size="14pt"></asp:Label>--%>
                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, S.CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/GenerateImage.aspx?size=null&color=TV&height=16','~/GenerateImage.aspx?size=' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '&color=TV&height=16') GRAPH_URL FROM ENR.ELECTION_RESULTS S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
                                    CellPadding="4" CellSpacing="1" DataMember="DefaultView" Font-Names="Arial" BackColor="white"
                                    Font-Size="X-Large" BorderWidth="0px" BorderStyle="None" OnRowDataBound="GridView4_RowDataBound"
                                    ShowHeader="True" ShowFooter="False">
                                    <RowStyle VerticalAlign="Top" Wrap="False" />
                                    <Columns>
                                        <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidate/Response" SortExpression="CANDIDATE_FULL_NAME"
                                            HeaderStyle-HorizontalAlign="left">
                                            <ItemStyle Wrap="False" Width="375px" HorizontalAlign="left" BackColor="blue" />
                                        </asp:BoundField>
                                        <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="Graph" HeaderStyle-HorizontalAlign="center">
                                            <ItemStyle Width="115px" HorizontalAlign="left" VerticalAlign="Middle" BackColor="blue" />
                                        </asp:ImageField>
                                        <asp:BoundField DataField="VOTES" HeaderText="Votes" HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Wrap="False" Width="130px" HorizontalAlign="right" BackColor="blue" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CONTEST_TOTAL" HeaderText="" Visible="False"></asp:BoundField>
                                        <asp:TemplateField HeaderText="%/Total" HeaderStyle-HorizontalAlign="center">
                                            <ItemStyle Width="130px" HorizontalAlign="right" BackColor="blue" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle BackColor="Blue" />
                                </asp:GridView>
                            </p>
                            <asp:Label ID="lblPrecincts" Font-Size="14pt" Font-Bold="true" runat="server" Text="Precincts Reporting: "></asp:Label>
                            <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                Font-Names="Arial" Font-Bold="true" Font-Size="14pt"></asp:Label>&nbsp;<asp:Label
                                    ID="Label1" Font-Bold="true" Font-Size="14pt" runat="server" Text="of"></asp:Label>&nbsp;<asp:Label
                                        ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Names="Arial"
                                        Font-Bold="true" Font-Size="14pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                            Text='<%# Eval("PCT_DONE") %>' Font-Names="Arial" Font-Bold="true" Font-Size="14pt"></asp:Label>)
                            <br />
                            <br />
                            <asp:Label ID="lblWebURL" Font-Size="14pt" runat="server" Text="www.ClarkCountyNV.gov/vote"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
