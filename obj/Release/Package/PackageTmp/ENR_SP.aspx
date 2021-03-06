<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ENR_SP.aspx.vb" Inherits="ElectionResults.ENR_SP" %>

<%@ Register TagPrefix="aspGraph" TagName="Image" Src="graph.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Informaci�n de Resultados Electorales</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <link href="PrintStyle.css" rel="stylesheet" type="text/css" media="print" />
    <%--<meta http-equiv="refresh" content="30" />--%>
</head>
<body style="text-align: center;">
    <form id="frmMain" runat="server">
        <div id="divHeader" runat="server" style="border-style: none; text-align: center;">
            <br />
            <br />
            <asp:SqlDataSource ID="sqlElectionParms" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT ELECTION_TITLE_SP, ELECTION_DATE_SP, DECODE(RESULTS_MODE,NULL,NULL,'<strong><i>'||DECODE(RESULTS_MODE, 'Unofficial Results', 'Resultados No Oficiales', 'Unofficial Final Results', 'Resultados Finales No Oficiales', 'Official Final Results', 'Resultados Finales Oficiales')||'</i></strong><br>')||'Actualizado '||(SELECT TO_CHAR(MAX(REPORT_DATE),'MM/DD/YYYY HH12:MI AM') FROM ELECTION_RESULTS) AS RESULTS_MODE_SP, DECODE(RESULTS_MSG_SP,NULL,NULL,'<br>'||RESULTS_MSG_SP) AS RESULTS_MSG_SP FROM ELECTION_RESULTS_PARMS">
            </asp:SqlDataSource>
            <asp:FormView ID="frmParams" runat="server" DataSourceID="sqlElectionParms" Width="100%"
                DataKeyNames="ELECTION_TITLE_SP" BorderStyle="None" BorderWidth="0px" EmptyDataText="No election found.">
                <ItemTemplate>
                    <asp:Label ID="ELECTION_TITLELabel" runat="server" Text='<%# Eval("ELECTION_TITLE_SP") %>'
                        Font-Bold="true" Font-Size="Medium">
                    </asp:Label>
                    <br />
                    <asp:Label ID="ELECTION_DATELabel" runat="server" Text='<%# Eval("ELECTION_DATE_SP") %>'
                        Font-Bold="true" Font-Size="Small">
                    </asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="RESULTS_MODELabel" runat="server" Text='<%# Bind("RESULTS_MODE_SP") %>'
                        Font-Size="small">
                    </asp:Label>
                    <br />
                    <asp:Label ID="RESULTS_MSGLabel" runat="server" Text='<%# Bind("RESULTS_MSG_SP") %>'
                        Font-Bold="true" Font-Size="Small" ForeColor="red">
                    </asp:Label>
                </ItemTemplate>
            </asp:FormView>
        </div>
        <div id="divRegAndTurnout" runat="server" style="border-style: none; text-align: center;">
            <br />
            <asp:SqlDataSource ID="sqlTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, REPLACE(REPLACE(UPPER(CONTEST_FULL_NAME), 'REGISTRATION &', 'REGISTRO Y'), 'TURNOUT', 'PARTICIPACI�N ELECTORAL') AS CONTEST_FULL_NAME_SP, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 AND CONTEST_TOTAL > 0 ORDER BY DECODE(SUBSTR(UPPER(CONTEST_FULL_NAME),1,3),'REG',0,'DEM',2,'REP',3,'NP ',4,0)">
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sqlTurnout"
                DataKeyNames="CONTEST_FULL_NAME" ShowHeader="false" BorderStyle="None" BorderWidth="0px"
                Width="100%">
                <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Center"
                    VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False" ItemStyle-BorderStyle="None">
                        <ItemTemplate>
                            <br />
                            <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                Font-Bold="True" Font-Names="Verdana" Font-Size="11pt" Visible="false"></asp:Label>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("CONTEST_FULL_NAME_SP") %>'
                                Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                            <br />
                            <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                Font-Names="Verdana"></asp:Label><strong>&nbsp;Votantes Registrados</strong>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Turnout', 'Votaci�n el D�a Electoral', 'Early Vote Turnout', 'Votaci�n Temprana', 'Mail Turnout', 'Votaci�n por Correo', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_RESULTS WHERE UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
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
                                    <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="M�todo de Votaci�n" SortExpression="CANDIDATE_FULL_NAME"
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
        </div>
        <div id="divMuniRegAndTurnout" runat="server" style="border-style: none; text-align: center;">
            <br />
            <asp:SqlDataSource ID="sqlCityTurnout" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, TO_CHAR(CONTEST_TOTAL, 'FM999,999') AS CONTEST_TOTAL, REPLACE(UPPER(PSD_NAME),' - AT LARGE','') AS MUNI_NAME, LIST_ORDER FROM ENR.ELECTION_SUB_RESULTS WHERE TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER),TO_NUMBER(LIST_ORDER)">
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
                                Font-Names="Verdana"></asp:Label><strong>&nbsp;Votantes Registrados</strong>
                            <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(DECODE(CANDIDATE_FULL_NAME, 'Election Day Turnout', 'Votaci�n el D�a Electoral', 'Early Vote Turnout', 'Votaci�n Temprana', 'Mail Turnout', 'Votaci�n por Correo', CANDIDATE_FULL_NAME)) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM ENR.ELECTION_SUB_RESULTS WHERE REPLACE(UPPER(PSD_NAME),' - AT LARGE','')=:OFFICE AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblOffice" DefaultValue="" Name="OFFICE" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvCityTurnout" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource8"
                                BorderStyle="Solid" CellPadding="1" CellSpacing="1" DataMember="DefaultView"
                                Font-Names="Verdana" Font-Size="10pt" BorderWidth="1px" OnRowDataBound="gvCityTurnout_RowDataBound"
                                ShowHeader="True" ShowFooter="True">
                                <RowStyle VerticalAlign="Top" Wrap="False" />
                                <Columns>
                                    <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="M�todo de Votaci�n" SortExpression="CANDIDATE_FULL_NAME"
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
        <div id="divContests" runat="server" style="border-style: none; text-align: center;">
            <hr />
            <asp:SqlDataSource ID="sqlContests" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME_SP) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Respuesta','Candidato(a)') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG_SP,NULL,'VOTE POR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG_SP)||'<BR>VOTE POR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME ORDER BY TO_NUMBER(S.CONTEST_ORDER)">
            </asp:SqlDataSource>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sqlContests"
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
                            <asp:Label ID="lblPrecincts" Font-Bold="true" Font-Size="small" runat="server" Text="Distritos Reportados: "></asp:Label>
                            <asp:Label ID="lblPrecinctsDone" runat="server" Text='<%# Eval("PROCESSED_DONE") %>'
                                Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;<strong>de</strong>&nbsp;<asp:Label
                                    ID="lblTlPrecincts" runat="server" Text='<%# Eval("TOTAL_PRECINCTS") %>' Font-Bold="True"
                                    Font-Names="Verdana" Font-Size="10pt"></asp:Label>&nbsp;(<asp:Label ID="Label2" runat="server"
                                        Text='<%# Eval("PCT_DONE") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>)
                            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT S.CANDIDATE_ORDER, UPPER(replace(S.CANDIDATE_FULL_NAME,'None of These Candidates','Ninguno de Estos Candidatos')) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(S.TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(S.CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, S.CONTEST_TYPE, DECODE(S.TOTAL,0,'~/GenerateImage.aspx?size=null&color=null&height=10','~/GenerateImage.aspx?size=' || ROUND((S.TOTAL / S.CONTEST_TOTAL) * 100) || '&color=null&height=10') GRAPH_URL FROM ENR.ELECTION_RESULTS S, ENR.ELECTION_RESULTS_CONTESTS C WHERE C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME AND UPPER(C.CONTEST_FULL_NAME_SP)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
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
                                    <asp:BoundField DataField="CANDIDATE_FULL_NAME" HeaderText="Candidato(a)/Respuesta"
                                        SortExpression="CANDIDATE_FULL_NAME" HeaderStyle-HorizontalAlign="left" HeaderStyle-BackColor="lightgreen">
                                        <ItemStyle Wrap="False" Width="255px" HorizontalAlign="left" />
                                    </asp:BoundField>
                                    <asp:ImageField DataImageUrlField="GRAPH_URL" HeaderText="Gr�fica" HeaderStyle-HorizontalAlign="center"
                                        HeaderStyle-BackColor="lightgreen">
                                        <ItemStyle Width="105px" HorizontalAlign="left" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:BoundField DataField="VOTES" HeaderText="Votos" HeaderStyle-HorizontalAlign="Center"
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
        </div>
    </form>
</body>
</html>
