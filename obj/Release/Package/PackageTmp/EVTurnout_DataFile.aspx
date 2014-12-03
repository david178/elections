<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EVTurnout_DataFile.aspx.vb"
    Inherits="ElectionResults.EVTurnout_DataFile" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Early Voting Turnout Data File</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .style1
        {
            width: 31px;
            height: 31px;
        }
        .modalBackground
        {
            background-color: Gray;
            -ms-filter: alpha(opacity=60);
            -ms-opacity: 0.60;
        }
        .updateProgress
        {
            border-width: 5px;
            border-style: solid;
            background-color: #FFFFFF;
            position: absolute;
            height: 50px;
            width: 290px;
        }
    </style>
    <script type="text/javascript">
        function showProgress() {
            $find('mdlPopup').show();
        } 
    </script>
</head>
<body>
    <form id="frmMain" runat="server">
    <asp:HiddenField ID="hElecCode" runat="server" />
    <div style="text-align: left">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="Server" />
        <asp:SqlDataSource ID="sqlEVSessions" runat="server" ConnectionString="<%$ ConnectionStrings:ELECP-ELWEB %>"
            ProviderName="<%$ ConnectionStrings:ELECP-ELWEB.ProviderName %>" SelectCommand="select '- ALL -' ev_vote_date from dual union select distinct to_char(t.ev_session,'MM/DD/YYYY') ev_vote_date from cl_ev_turnout t, cl_web_election e where e.default_elec='Y' and t.election_code=e.election_code and t.ev_session < trunc(sysdate) order by 1">
        </asp:SqlDataSource>
        <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>--%>
        <br />
        Early voting turnout files contain a list of voters who voted early for the current
        election. Please note that the information in the files are subject to change as
        a result of being audited, as we may occasionally find and correct a clerical error.
        The daily file for the current early voting session is available after midnight.
        Auditing for the current early voting session is usually completed by 12 noon the
        following day. All files are formatted in ASCII comma delimited text and supported
        by most database and spreadsheet programs.
        <br />
        <br />
        Select the early voting session date:
        <asp:DropDownList ID="ddlSession" runat="server" DataSourceID="sqlEVSessions" DataValueField="ev_vote_date"
            DataTextField="ev_vote_date" AutoPostBack="True" />
        <br />
        <br />
        <i>NOTE: If no dates are listed in the session date dropdown, then no data for this
            election has been posted yet.</i>
        <br />
        <br />
        By clicking the button below, the file will be generated and you will be prompted
        to save your file once it is created. This process may take up to a minute depending
        on your connection speed, so <strong>PLEASE WAIT</strong> for the <i>File Download</i>
        dialog to appear...
        <br />
        <br />
        <asp:Button ID="btnGenerateFile" runat="server" Text="Generate File: EVTurnout_Cumulative.txt"
            OnClientClick="showProgress();" />
        <br />
        <br />
        <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
        <br />
        <%--Early Voting Turnout Data Files--%>
        <asp:Table ID="tblLayout" runat="server" CellPadding="2" CellSpacing="0" BorderStyle="Groove"
            BorderWidth="2" Width="100%">
            <asp:TableHeaderRow>
                <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="left" BackColor="lightblue"
                    Font-Bold="true" BorderStyle="Groove">
                        FILE LAYOUT
                </asp:TableHeaderCell>
            </asp:TableHeaderRow>
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
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Voter Name (Last, First Middle)</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">PRECINCT</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Voter's Precinct</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">BALLOT_PARTY</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Ballot Party Voted (If partisan election)</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">CONGRESS</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Congressional District</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">SENATE</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">State Senate District</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">ASSEMBLY</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">State Assembly District</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">COMMISSION</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">County Commission District</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">EDUCATION</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">State Board of Education District</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">REGENT</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">University Board of Regents District</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">SCHOOL</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Clark County School District</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">CITY</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Incorporated City</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">WARD</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">City Ward</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">TOWNSHIP</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Township</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">REG_STATUS</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Voter's registration status</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">EV_VOTE_SITE</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Early Voting Site (MBT## = Mobile Teams, TRL## = Mobile Trailers)</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">EV_VOTE_DATE</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Date Voted</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">ELECTION_NAME</asp:TableCell>
                <asp:TableCell BorderStyle="Groove" BorderWidth="2">Name of Current Election</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    <asp:ModalPopupExtender ID="mdlPopup" runat="server" TargetControlID="pnlPopup" PopupControlID="pnlPopup"
        BackgroundCssClass="modalBackground" />
    <asp:Panel ID="pnlPopup" runat="server" CssClass="updateProgress">
        <div id="imageDiv">
            <div style="float: left; margin: 9px">
                <img src="Images/wait_animated.gif" alt="" width="32px" height="32px" /></div>
            <div style="padding-top: 17.5px; font-family: Arial,Helvetica,sans-serif; font-size: 12px;">
                Creating file. Please wait...
            </div>
        </div>
    </asp:Panel>
    </form>
</body>
</html>
