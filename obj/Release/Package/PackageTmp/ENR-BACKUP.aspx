<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ENR-BACKUP.aspx.vb" Inherits="ElectionResults.ENR_BACKUP" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Election Results</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align:left;">
    <br />
    <br />
        To obtain the current election results report for the 2012 General Election, please click on the link below:
        <br />
        <br />
        <strong><asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="http://redrock.clarkcountynv.gov/voterrequests/sr.pdf">2012 General Election Results Reporting</asp:HyperLink></strong>
    </div>
    </form>
</body>
</html>
