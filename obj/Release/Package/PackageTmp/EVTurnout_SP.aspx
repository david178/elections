<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EVTurnout_SP.aspx.vb"
    Inherits="ElectionResults.EVTurnout_SP" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Participación Electoral en la Votación Temprana</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <link href="PrintStyle.css" rel="stylesheet" type="text/css" media="print" />
</head>
<body>
    <form id="frmMain" runat="server">
        <div style="text-align: center;">
            <asp:Table ID="tblMain" runat="server" HorizontalAlign="Left" CellSpacing="0" CellPadding="0"
                Width="750px">
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
                            <%--<asp:TableRow ID="tblCityTotals" runat="server">
                                <asp:TableCell HorizontalAlign="Center">
                                    <br />
                                    <font size="medium"><strong>Resumen de Participación Electoral por Ciudad</strong></font><br />
                                    <br />
                                    <asp:SqlDataSource ID="sqlCityTotals" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT DECODE(MUNI_CODE, 'BOC','Boulder City','HEN','Henderson','LV','Las Vegas','MES','Mesquite','NLV','North Las Vegas',MUNI_CODE) AS CITY, TRIM(TO_CHAR(SUM(DECODE(EV_SESSION, EV_SESSION, SITE_TURNOUT, NULL)),'FM999,999')) AS TURNOUT FROM CL_EV_TURNOUT WHERE ELECTION_CODE=(SELECT E.ELECTION_CODE FROM CL_WEB_ELECTION E WHERE DEFAULT_ELEC='Y') GROUP BY DECODE(MUNI_CODE, 'BOC','Boulder City','HEN','Henderson','LV','Las Vegas','MES','Mesquite','NLV','North Las Vegas',MUNI_CODE) ORDER BY 1">
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="grdCityTotals" runat="server" CellPadding="3" AutoGenerateColumns="False"
                                        DataSourceID="sqlCityTotals" DataKeyNames="CITY" BorderStyle="Groove" BorderWidth="2px"
                                        ShowFooter="false">
                                        <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                            VerticalAlign="Top" />
                                        <Columns>
                                            <asp:BoundField DataField="CITY" HeaderText="Ciudad" HtmlEncode="true"
                                                HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="left">
                                                <ItemStyle Wrap="False" Width="150px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TURNOUT" HeaderText="Participación" HeaderStyle-HorizontalAlign="Center">
                                                <ItemStyle Wrap="False" Width="100px" HorizontalAlign="right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <HeaderStyle BackColor="LightGreen" />
                                    </asp:GridView>
                                </asp:TableCell>
                            </asp:TableRow>--%>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Center">
                                    <br />
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
                                        ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="SELECT LIST_ORDER, REPLACE(REPLACE(EV_SITE,'Trailer','Tráiler'),' Mobile Team', ', Equipo Móvil') AS EV_SITE, TRIM(TO_CHAR(SUM(DECODE(EV_SESSION, EV_SESSION, SITE_TURNOUT, NULL)),'FM999,999')) AS TURNOUT FROM CL_EV_TURNOUT WHERE ELECTION_CODE=(SELECT E.ELECTION_CODE FROM CL_WEB_ELECTION E WHERE DEFAULT_ELEC='Y') GROUP BY LIST_ORDER, EV_SITE ORDER BY LIST_ORDER">
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="GridView1" runat="server" CellPadding="3" AutoGenerateColumns="False"
                                        DataSourceID="SqlDataSource1" DataKeyNames="EV_SITE" BorderStyle="Groove" BorderWidth="2px"
                                        ShowFooter="true">
                                        <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="Small" HorizontalAlign="Left"
                                            VerticalAlign="Top" />
                                        <Columns>
                                            <asp:BoundField DataField="EV_SITE" HeaderText="Centro de Votación" HeaderStyle-Width="240px"
                                                HeaderStyle-HorizontalAlign="left" HtmlEncode="false">
                                                <ItemStyle Wrap="False" Width="360px" HorizontalAlign="left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="TURNOUT" HeaderText="Participación" HeaderStyle-HorizontalAlign="Center">
                                                <ItemStyle Wrap="False" Width="100px" HorizontalAlign="right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <HeaderStyle BackColor="LightGreen" />
                                        <FooterStyle BackColor="LightGray" HorizontalAlign="left" />
                                    </asp:GridView>
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
                                    <font size="medium"><strong>North Las Vegas, Votación En Oficina</strong></font><br />
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
                                <asp:TableCell HorizontalAlign="Center">
                                    <asp:Label ID="lblWeek1" runat="server" Font-Bold="true" Font-Size="medium" Text="Participación Diaria - Semana 1"></asp:Label><br />
                                    <br />
                                    <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                                &nbsp;
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow ID="rWeek2" runat="server">
                                <asp:TableCell HorizontalAlign="Center">
                                    <font size="medium"><strong>Participación Diaria - Semana 2</strong></font><br />
                                    <br />
                                    <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
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
