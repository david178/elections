<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Results_sp.aspx.vb" Inherits="ElectionResults.Results_sp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Resultados Electorales Históricos</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" \>
</head>
<body>
    <form id="frmMain" runat="server">
        <asp:HiddenField ID="hElecCode" runat="server" />
        <div style="text-align:left;border-style:none;">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT '0' AS ELECTION_CODE, ' ' AS ELECNAME, NULL AS ELECDATE FROM SYS.DUAL UNION SELECT ER.ELECTION_CODE, WE.ELECNAME || ' (' || WE.ELECDATE || ')' AS ELECNAME, WE.ELECDATE FROM CLARK.CL_ELECTION_RESULTS ER, CLARK.CL_WEB_ELECTION WE WHERE ER.ELECTION_CODE=WE.ELECTION_CODE AND ER.ELECTION_SUBCODE = '00' ORDER BY ELECDATE DESC">
            </asp:SqlDataSource>
            <br />
            Seleccione una elección:<br />
            <asp:DropDownList ID="ddlElection" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                DataTextField="ELECNAME" DataValueField="ELECTION_CODE">
            </asp:DropDownList>
            <br />
            <br />
            Seleccione el tipo de información:<br />
            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True">
                <asp:ListItem Value="" Selected="True"> </asp:ListItem>
                <asp:ListItem Value="1">RESULTADOS ELECTORALES OFICIALES (EN INGLÉS)</asp:ListItem>
                <asp:ListItem Value="2">RESUMEN DE LA PARTICIPACIÓN ELECTORAL EN LA VOTACIÓN TEMPRANA</asp:ListItem>
                <asp:ListItem Value="3">INFORME DEL VOTO (RESULTADOS POR DISTRITO ELECTORAL)</asp:ListItem>
                <asp:ListItem Value="4">ARCHIVO DE DATOS DE PARTICIPACIÓN ELECTORAL (POR MÉTODO DE VOTACIÓN)</asp:ListItem>
                <asp:ListItem Value="5">PREGUNTAS EN LA BOLETA (TEXTO Y AUDIO)</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:MultiView ID="MultiView" runat="server" ActiveViewIndex="0">
                <%--Display Nothing--%>
                <asp:View ID="View1" runat="server">
                    <br />
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    <br />
                </asp:View>
                <%--Display Election Results--%>
                <asp:View ID="View2" runat="server">
                    <%--Display Registration and Turnout--%>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DISTINCT UPPER(CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, CONTEST_ORDER, DECODE(CONTEST_TOTAL, 0, 'TOTAL REGISTERED VOTERS UNAVAILABLE', TO_CHAR(CONTEST_TOTAL, 'FM999,999')||' REGISTERED VOTERS') AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CONTEST_ORDER)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2"
                        DataKeyNames="CONTEST_FULL_NAME" BorderStyle="None" BorderWidth="0px" Width="500px">
                        <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
                            VerticalAlign="Top" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <p align="center">
                                        <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("CONTEST_FULL_NAME") %>'
                                            Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                        <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                            Font-Names="Verdana"></asp:Label>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                            ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value" Type="String" />
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
                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="sqlCityTurnout"
                        DataKeyNames="MUNI_NAME" BorderStyle="None" BorderWidth="0px" Width="500px">
                        <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="center"
                            VerticalAlign="Top" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <p align="center">
                                        <asp:Label ID="lblOffice" runat="server" Text='<%# Eval("MUNI_NAME") %>' Font-Bold="True"
                                            Font-Names="Verdana" Font-Size="11pt"></asp:Label><br />
                                        <asp:Label ID="lblVoters" runat="server" Text='<%# Eval("CONTEST_TOTAL") %>' Font-Bold="True"
                                            Font-Names="Verdana"></asp:Label>
                                        <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                            ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE <> '00' AND UPPER(MUNI_NAME)=:OFFICE AND TO_NUMBER(CONTEST_TYPE) < 0 ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value" Type="String" />
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
                            <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value" Type="String" />
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
                                            ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT CANDIDATE_ORDER, UPPER(CANDIDATE_FULL_NAME) CANDIDATE_FULL_NAME, TRIM(TO_CHAR(TOTAL,'FM999,999')) AS VOTES, IS_WINNER, TRIM(TO_CHAR(CONTEST_TOTAL,'FM999,999')) AS CONTEST_TOTAL, CONTEST_TYPE FROM CLARK.CL_ELECTION_RESULTS WHERE ELECTION_CODE=:ELECTION_CODE AND ELECTION_SUBCODE = '00' AND UPPER(CONTEST_FULL_NAME)=:OFFICE ORDER BY TO_NUMBER(CANDIDATE_ORDER)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value" Type="String" />
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
                            <asp:TableCell Font-Bold="true" Font-Size="11pt" HorizontalAlign="left">Totales Acumulados</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="left">
                                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                    ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT LIST_ORDER, EV_SITE, TRIM(TO_CHAR(SUM(DECODE(EV_SESSION, EV_SESSION, SITE_TURNOUT, NULL)),'FM999,999')) AS TURNOUT FROM CL_EV_TURNOUT WHERE ELECTION_CODE=:ELECTION_CODE GROUP BY LIST_ORDER, EV_SITE ORDER BY LIST_ORDER">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hElecCode" Name="ELECTION_CODE" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource6"
                                    DataKeyNames="EV_SITE" BorderStyle="Groove" CellPadding="3" BorderWidth="2px"
                                    ShowFooter="true">
                                    <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                        VerticalAlign="Top" />
                                    <Columns>
                                        <asp:BoundField DataField="EV_SITE" HeaderText="Centro de Votación" HeaderStyle-HorizontalAlign="left">
                                            <ItemStyle Wrap="False" Width="300px" HorizontalAlign="left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TURNOUT" HeaderText="Totales" HeaderStyle-HorizontalAlign="Center">
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
                                <font size="medium"><strong>N. Las Vegas, Votación En Oficina</strong></font><br />
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
                                <font size="medium"><strong>Participación Diaria - Semana 1</strong></font><br />
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
                                <font size="medium"><strong>Participación Diaria - Semana 2</strong></font><br />
                                <br />
                                <asp:PlaceHolder ID="PlaceHolderW2" runat="server"></asp:PlaceHolder>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:View>
                <%--Display Statement of Vote--%>
                <asp:View ID="View4" runat="server">
                    <br />
                    AVISO: Para descargar un Reporte o Archivo de Datos, presione el botón derecho del ratón sobre el enlace y escoja Save Target As... (dependiendo de su navegador).
                    <br />
                    <br />
                    <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>
                    <br />
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
                                El Archivo Historial de Votación es un archivo de texto con formato que contiene la lista de votantes que votaron en la elección seleccionada.  El diseño del archivo se presenta a continuación:
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
                                            BorderWidth="2">Columna</asp:TableCell>
                                        <asp:TableCell BackColor="lightblue" Font-Bold="true" BorderStyle="Groove" BorderWidth="2">Descripción</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">IDNUMBER</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">Número de Registro de Votante</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">VOTERNAME</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">Nombre del Votante (Apellido, Nombre)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">VOTING METHOD</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">Método de Votación (ED = Día de la Elección, EV = Votación Temprana, MB = Votación por Correo/En Ausencia)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">PRECINCT</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">Distrito Electoral</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">BALLOT PARTY</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">Partido de Boleta Electoral Votada (Si es Elección Partidista)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">DATE VOTED</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">Fecha Cuando Votó el Votante (Fecha de Sesión para EV, Día de la Elección para ED o MB)</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">ELECTION CODE</asp:TableCell>
                                        <asp:TableCell BorderStyle="Groove" BorderWidth="2">Código Identificando la Elección (p.ej., 10P para la Elección Primaria del 2010)</asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="left">
                                <asp:Button ID="btnGenerateVH" runat="server" Text="Generar Archivo Historial de Votación" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Al presionar el botón abajo, se creará el archivo y se le pedirá que guarde su archivo cuando éste sea creado.  Este proceso puede tardar hasta un minuto dependiendo en la velocidad de su conexión. <strong>POR FAVOR ESPERE</strong> a que aparezca el diálogo para el Descargo del Archivo...</asp:TableCell>
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
