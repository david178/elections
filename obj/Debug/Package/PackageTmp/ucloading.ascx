<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ucloading.ascx.vb" Inherits="ElectionResults.ucloading" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Panel ID="pnlProgress" runat="server" CssClass="modalpopup">
    <div class="popupcontainerLoading">
        <div class="popupbody">
            <table width="100%">
                <tr>
                    <td align="center">
                        <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/wait_animated.gif"/>
                    </td>
                    <td valign="middle">
                        <asp:Label ID="lblLoading" runat="server" Text='Please wait...'
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Panel>
<asp:LinkButton ID="LinkButton5" runat="server" Text=""></asp:LinkButton>
<asp:ModalPopupExtender ID="mpeProgress" runat="server" TargetControlID="LinkButton5"
    X="500" Y="0" PopupControlID="pnlProgress" BackgroundCssClass="modalBackground">
</asp:ModalPopupExtender>