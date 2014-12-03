<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SOV_sp.aspx.vb" Inherits="ElectionResults.SOV_sp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Elección General 2010 - Informe del Voto</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="frmMain" runat="server">
        <div style="text-align: left">
            <asp:Table ID="Table2" runat="server" HorizontalAlign="Left" CellSpacing="0" CellPadding="0"
                Width="100%">
                <asp:TableRow>
                    <asp:TableCell><!--#include file="header.htm"--></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Center" Font-Size="Medium" Font-Bold="true">
                        Elección General 2010<br />
                        Informe del Voto<br /><br />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Table ID="tblSOV" runat="server" BorderStyle="None" BorderWidth="0" CellPadding="2"
                            CellSpacing="1" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>AVISO: Para descargar un Reporte o Archivo de Datos, presione el botón derecho del ratón sobre el enlace y escoja <i>Save Target As...</i> (dependiendo de su navegador).</asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell><!--#include file="footer.htm"--></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
</body>
</html>
