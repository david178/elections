'================================================================
'THIS IS THE PRODUCTION ENGLISH PAGE FOR ELECTION NIGHT REPORTING
'================================================================
Imports Oracle.DataAccess.Client
Imports System.Net
Imports System.Web
Imports System.IO

Partial Public Class ENR
    Inherits System.Web.UI.Page
    Private lTotal As Long = 0
    Private lContestTotal As Long = 0
    Private iContestRow As Integer = 0
    Private sMode As String

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.MaintainScrollPositionOnPostBack = True
    End Sub

    Private Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        lTotal = 0
        lContestTotal = 0
    End Sub

    Protected Sub GridView2_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

    'Private Sub GridView3_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowCreated
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        iContestRow = e.Row.RowIndex
    '    End If
    'End Sub

    'Private Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound
    '    lTotal = 0
    'End Sub

    Protected Sub GridView4_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

    Protected Sub gvCityTurnout_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

    Protected Sub gvCityTurnout_RowDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.BackColor = Drawing.Color.White
            lTotal = lTotal + CType(e.Row.Cells(1).Text, Long)
            Dim l1 As Long = CType(e.Row.Cells(1).Text, Long)
            Dim l2 As Long = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)
            lContestTotal = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)

            If l1 <> 0 And l2 <> 0 Then
                e.Row.Cells(3).Text = (l1 / l2).ToString("P2")
            Else
                e.Row.Cells(3).Text = CType(0, Long).ToString("P2")
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total"
            e.Row.Cells(1).Text = lTotal.ToString("N0")
            e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Right
            e.Row.Cells(3).HorizontalAlign = HorizontalAlign.Right
            e.Row.Cells(3).Text = (lTotal / lContestTotal).ToString("P2")
            e.Row.Font.Bold = True
            lTotal = 0
            lContestTotal = 0
        End If
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.BackColor = Drawing.Color.White
            lTotal = lTotal + CType(e.Row.Cells(1).Text, Long)
            Dim l1 As Long = CType(e.Row.Cells(1).Text, Long)
            Dim l2 As Long = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)
            lContestTotal = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)

            If l1 <> 0 And l2 <> 0 Then
                e.Row.Cells(3).Text = (l1 / l2).ToString("P2")
            Else
                e.Row.Cells(3).Text = CType(0, Long).ToString("P2")
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total"
            e.Row.Cells(1).Text = lTotal.ToString("N0")
            e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Right
            e.Row.Cells(3).HorizontalAlign = HorizontalAlign.Right

            If lContestTotal > 0 Then
                e.Row.Cells(3).Text = (lTotal / lContestTotal).ToString("P2")
            Else
                e.Row.Cells(3).Text = CType(0, Long).ToString("P2")
            End If
            e.Row.Font.Bold = True
            lTotal = 0
            lContestTotal = 0
        End If
    End Sub

    Protected Sub GridView4_RowDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.Header Then
            'e.Row.Cells(0).Text = GridView3.DataKeys(iContestRow).Values("CONTEST_TYPE").ToString
        ElseIf e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.BackColor = Drawing.Color.White

            lTotal = lTotal + CType(e.Row.Cells(2).Text, Long)

            Dim l1 As Long = CType(e.Row.Cells(2).Text, Long)
            Dim l2 As Long = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)

            If l1 <> 0 And l2 <> 0 Then
                e.Row.Cells(4).Text = (l1 / l2).ToString("P2")
            Else
                e.Row.Cells(4).Text = CType(0, Long).ToString("P2")
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total"
            e.Row.Cells(2).Text = lTotal.ToString("N0")
            e.Row.Cells(2).HorizontalAlign = HorizontalAlign.Right
            e.Row.Font.Bold = True
            lTotal = 0
        End If
    End Sub

    'Private Sub lnkState_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkState.Click
    '    Dim sURL As String = "http://www.silverstateelection.com"
    '    Dim popupScript As String = "<script language='javascript'>" & _
    '        "window.open('" & sURL & "', '', " & _
    '        "'width=800, height=600, menubar=yes, resizable=yes, scrollbars=yes')" & _
    '        "</script>"

    '    ClientScript.RegisterStartupScript(GetType(String), "", popupScript)
    'End Sub

    'Private Sub btnMobile_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMobile.Click
    '    Dim sURL As String = "http://redrock.clarkcountynv.gov/electionresults/enr.aspx"
    '    Dim popupScript As String = "<script language='javascript'>" & _
    '        "window.open('" & sURL & "', '', " & _
    '        "'width=700, height=750, menubar=yes, resizable=yes, scrollbars=yes')" & _
    '        "</script>"

    '    ClientScript.RegisterStartupScript(GetType(String), "", popupScript)
    'End Sub

    Protected Sub sqlElectionParms_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs)

    End Sub
End Class