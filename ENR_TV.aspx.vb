'================================================================================
'THIS IS THE PRODUCTION ENGLISH PAGE FOR ELECTION NIGHT REPORTING ON CHANNEL 4 TV
'================================================================================
Imports Oracle.DataAccess.Client
Imports System.Net
Imports System.Web
Imports System.IO

Partial Public Class ENR_TV
    Inherits System.Web.UI.Page
    Private lTotal As Long = 0
    Private lContestTotal As Long = 0
    Private iContestRow As Integer = 0
    Private sMode As String

    Private Sub GridView3_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            iContestRow = e.Row.RowIndex
        End If
    End Sub

    Private Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound
        lTotal = 0
    End Sub

    Protected Sub GridView4_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

    Protected Sub GridView4_RowDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells(0).Text = GridView3.DataKeys(iContestRow).Values("CONTEST_TYPE").ToString
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
        End If
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sSQL As String = ""
        Dim sContestOrder As String = ""
        Dim sMaxContest As String = ""
        Dim cn As New OracleConnection(ConfigurationManager.AppSettings("ELECP-ENR"))

        Try

            sSQL = "select distinct max(to_number(contest_order)) from enr.election_results"

            Dim cmd As New OracleCommand(sSQL)
            cmd.Connection = cn
            cn.Open()
            sMaxContest = cmd.ExecuteScalar.ToString
            'cmd.Connection.Close()
            cmd.Dispose()

            If Session("vContestOrder") = "" Then
                sContestOrder = "0"
            Else
                sContestOrder = Session("vContestOrder")

                If sContestOrder = sMaxContest Then
                    sContestOrder = "0"
                End If

            End If

            sSQL = "select distinct min(to_number(contest_order)) from enr.election_results where to_number(contest_order) > " & sContestOrder

            cmd = New OracleCommand(sSQL)
            cmd.Connection = cn
            'cn.Open()
            Session("vContestOrder") = cmd.ExecuteScalar.ToString
            cmd.Connection.Close()
            cmd.Dispose()

            sqlContests.SelectCommand = "SELECT DISTINCT UPPER(C.CONTEST_FULL_NAME) AS CONTEST_FULL_NAME, S.CONTEST_ORDER, S.TOTAL_PRECINCTS, S.PROCESSED_DONE, DECODE((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS)), 1,'100',TRIM(TO_CHAR((TO_NUMBER(S.PROCESSED_DONE) / TO_NUMBER(S.TOTAL_PRECINCTS) * 100), '990.00')))||' %' AS PCT_DONE, DECODE(S.CONTEST_TYPE,'4','Response','Candidate') AS CONTEST_TYPE, DECODE(C.CONTEST_MSG,NULL,'VOTE FOR '||S.VOTE_FOR,UPPER(C.CONTEST_MSG)||'<br />VOTE FOR '||S.VOTE_FOR) AS CONTEST_MSG FROM ENR.ELECTION_RESULTS S,ENR.ELECTION_RESULTS_CONTESTS C WHERE TO_NUMBER(S.CONTEST_TYPE) >= 0 AND C.CONTEST_FULL_NAME = S.CONTEST_FULL_NAME and S.CONTEST_ORDER = " & Session("vContestOrder") & " ORDER BY TO_NUMBER(S.CONTEST_ORDER)"
            sqlContests.DataBind()
            GridView3.DataBind()

        Finally
            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If
        End Try
    End Sub
End Class