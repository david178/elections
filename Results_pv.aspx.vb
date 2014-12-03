Imports Oracle.DataAccess.Client
Imports System.Net
Imports System.Web
Imports System.IO

Partial Public Class Results_pv
    Inherits System.Web.UI.Page
    Private lTotal As Long = 0
    Private lContestTotal As Long = 0
    Private iContestRow As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Request.QueryString("c")) Then
            hECode.Value = Trim(Request.QueryString("c"))
            lblElectionTitle.Text = Trim(Request.QueryString("e"))

            Dim ipos As Integer = InStr(lblElectionTitle.Text, "(")
            Dim dtDate As Date

            If ipos > 0 Then
                dtDate = Left(Right(lblElectionTitle.Text, Len(lblElectionTitle.Text) - ipos), Len(Right(lblElectionTitle.Text, Len(lblElectionTitle.Text) - ipos)) - 1)

                If CType(dtDate.Year, Integer) <= 1972 And Right(hECode.Value, 1) = "P" Then
                    lblResultsMsg.Text = "<strong>NOTE: State offices only are available for this election. Election information may not be available for turnout, precincts and/or contests.</strong><br><br><hr width ='500px' />"
                ElseIf CType(dtDate.Year, Integer) <= 1972 And Right(hECode.Value, 1) <> "P" Then
                    lblResultsMsg.Text = "<strong>NOTE: Election information may not be available for turnout, precincts and/or contests.</strong><br><br><hr width ='500px' />"
                Else
                    lblResultsMsg.Text = ""
                End If
            End If
        Else
            lblElectionTitle.Text = ""
        End If
    End Sub

    Protected Sub gvCityTurnout_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

    Protected Sub GridView2_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

    Protected Sub GridView4_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

    Protected Sub gvCityTurnout_RowDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.BackColor = Drawing.Color.White
            lTotal = lTotal + CType(e.Row.Cells(1).Text, Long)
            lContestTotal = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)
            If e.Row.Cells(1).Text = "0" Then
                e.Row.Cells(3).Text = "0.00 %"
            Else
                e.Row.Cells(3).Text = (CType(e.Row.Cells(1).Text, Long) / CType(e.Row.DataItem("CONTEST_TOTAL"), Long)).ToString("P2")
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total"
            e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Left
            e.Row.Cells(1).Text = lTotal.ToString("N0")
            e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Right
            e.Row.Cells(3).HorizontalAlign = HorizontalAlign.Right
            If lTotal = 0 Then
                e.Row.Cells(3).Text = "0.00 %"
            Else
                e.Row.Cells(3).Text = (lTotal / lContestTotal).ToString("P2")
            End If
            e.Row.Font.Bold = True
            lTotal = 0
            lContestTotal = 0
        End If
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.BackColor = Drawing.Color.White
            lTotal = lTotal + CType(e.Row.Cells(1).Text, Long)
            lContestTotal = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)
            If e.Row.Cells(1).Text = "0" Then
                e.Row.Cells(3).Text = "0.00 %"
            Else
                e.Row.Cells(3).Text = (CType(e.Row.Cells(1).Text, Long) / CType(e.Row.DataItem("CONTEST_TOTAL"), Long)).ToString("P2")
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total"
            e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Left
            e.Row.Cells(1).Text = lTotal.ToString("N0")
            e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Right
            e.Row.Cells(3).HorizontalAlign = HorizontalAlign.Right
            If lTotal = 0 Then
                e.Row.Cells(3).Text = "0.00 %"
            Else
                e.Row.Cells(3).Text = (lTotal / lContestTotal).ToString("P2")
            End If
            e.Row.Font.Bold = True
            lTotal = 0
            lContestTotal = 0
        End If
    End Sub

    Private Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        lTotal = 0
        lContestTotal = 0
    End Sub

    Private Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        lTotal = 0
    End Sub

    Protected Sub GridView4_RowDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells(0).Text = GridView3.DataKeys(iContestRow).Values("CONTEST_TYPE").ToString
        ElseIf e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.BackColor = Drawing.Color.White

            lTotal = lTotal + CType(e.Row.Cells(1).Text, Long)

            If e.Row.DataItem("IS_WINNER") = "1" Then
                e.Row.Font.Bold = True
            Else
                e.Row.Font.Bold = False
            End If

            Dim l1 As Long = CType(e.Row.Cells(1).Text, Long)
            Dim l2 As Long = CType(e.Row.DataItem("CONTEST_TOTAL"), Long)

            If l1 <> 0 And l2 <> 0 Then
                e.Row.Cells(4).Text = (l1 / l2).ToString("P2")
            Else
                e.Row.Cells(4).Text = CType(0, Long).ToString("P2")
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total"
            e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Left
            e.Row.Cells(1).Text = lTotal.ToString("N0")
            e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Right
            e.Row.Font.Bold = True
            lTotal = 0
        End If
    End Sub

    Private Sub GridView3_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            iContestRow = e.Row.RowIndex
        End If
    End Sub
End Class