<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Results_pv.aspx.vb" Inherits="ElectionResults.Results_pv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Election Results</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <link href="PrintStyle.css" rel="stylesheet" type="text/css" media="print" />
</head>
<body style="text-align:center;border-style:none;width:500px;">
    <form id="frmMain" runat="server">
        <asp:HiddenField ID="hECode" runat="server" />
        <div style="text-align: center">
            <%--Display Registration and Turnout--%>
            <br />
            <input id="btnPrint" type="button" value="Print" class="NonPrintable" style="font-size:smaller;" onclick="window.print();" />&nbsp;
            <input id="btnClose" type="button" value="Close" class="NonPrintable" style="font-size:smaller;" onclick="window.close();" />
            <br />
            <br />
            <asp:Label ID="lblElectionTitle" runat="server" Text="" Font-Bold="true" Font-Size="medium"></asp:Label>
            <br />
            <br />
            <asp:SqlDataSource ID="sqlElection" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, DECODE(CONTEST_TOTAL, 0, 'TOTAL REGISTERED VOTERS UNAVAILABLE', TO_CHAR(CONTEST_TOTAL, 'FM999,999')||' REGISTERED VOTERS') AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hECode" DefaultValue="" Name="ELECTION_CODE" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sqlElection"
                DataKeyNames="CONTEST_FULL_NAME" BorderStyle="None" BorderWidth="0px" Width="500px">
                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
                    VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <p style="text-align:center;border-style:none;">
                                <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                    Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                    Font-Names="Verdana"></asp:Label>
                                <asp:SqlDataSource ID="sqlContests" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hECode" DefaultValue="" Name="ELECTION_CODE" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="sqlContests"
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
                                    <FooterStyle BackColor="LightGray" />
                                </asp:GridView>
                            </p>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <%--Display Registration and Turnout for City Elections--%>
            <asp:SqlDataSource ID="sqlCityTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, DECODE(CONTEST_TOTAL, 0, 'TOTAL REGISTERED VOTERS UNAVAILABLE', TO_CHAR(CONTEST_TOTAL, 'FM999,999')||' REGISTERED VOTERS') AS CONTEST_TOTAL, UPPER(MUNI_NAME) AS MUNI_NAME, ELECTION_SUBCODE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE <> '00' AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY ELECTION_SUBCODE, TO_NUMBER(CONTEST_ORDER)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hECode" DefaultValue="" Name="ELECTION_CODE" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCityTurnout"
                DataKeyNames="MUNI_NAME" BorderStyle="None" BorderWidth="0px" Width="500px">
                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
                    VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <p style="text-align:center;border-style:none;">
                                <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("MUNI_NAME") %>' Font-Bold="True"
                                    Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                    Font-Names="Verdana"></asp:Label>
                                <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE <> '00' AND UPPER(MUNI_NAME)=:OFFICE AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hECode" DefaultValue="" Name="ELECTION_CODE" PropertyName="Value" />
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
                                    <FooterStyle BackColor="LightGray" />
                                </asp:GridView>
                            </p>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:Label ID="lblResultsMsg" runat="server" Text="" Width="500px"></asp:Label>
            <br />
            <%--Display Contests--%>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, VOTE_FOR, DECODE(TOTAL_PRECINCTS,'0','N/A',TOTAL_PRECINCTS) TOTAL_PRECINCTS, DECODE(CONTEST_TYPE,'0','Candidate', 'Response') AS CONTEST_TYPE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND TO_NUMBER(CONTEST_TYPE) >= 0 ORDER BY TO_NUMBER(CONTEST_ORDER)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hECode" DefaultValue="" Name="ELECTION_CODE" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4"
                DataKeyNames="CONTEST_FULL_NAME,CONTEST_TYPE" BorderStyle="None" BorderWidth="0px"
                Width="500px">
                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
                    VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <p style="text-align:center;border-style:none;">
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
                                        <asp:ControlParameter ControlID="hECode" DefaultValue="" Name="ELECTION_CODE" PropertyName="Value" />
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
                                    <FooterStyle BackColor="LightGray" />
                                </asp:GridView>
                            </p>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
