Imports Oracle.DataAccess.Client
Imports System.Net
Imports System.Web
Imports System.IO

Partial Public Class Results_sp
    Inherits System.Web.UI.Page
    Private lTotal As Long = 0
    Private lEVTotal As Long = 0
    Private lContestTotal As Long = 0
    Private sElectionCode As String = ""
    Private iContestRow As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.MaintainScrollPositionOnPostBack = True

        If Not Page.IsPostBack Then
            If Not IsNothing(Request.QueryString("ecode")) Then
                If Request.QueryString("ecode") <> "" Then
                    sElectionCode = Request.QueryString("ecode")
                    hElecCode.Value = sElectionCode
                    ddlElection.SelectedValue = sElectionCode

                    If Not IsNothing(Request.QueryString("ecat")) Then
                        If Request.QueryString("ecat") <> "" Then
                            ddlCategory.SelectedValue = Request.QueryString("ecat")

                            Select Case ddlCategory.SelectedValue
                                Case "1"
                                    MultiView.ActiveViewIndex = 1
                                    GridView1.DataBind()
                                    GridView3.DataBind()
                                Case "2"
                                    MultiView.ActiveViewIndex = 2
                                    GetEVTurnoutGridResults()
                                Case "3"
                                    MultiView.ActiveViewIndex = 3
                                    GetSOVGridResults()
                                Case "4"
                                    MultiView.ActiveViewIndex = 4
                                Case "5"
                                    MultiView.ActiveViewIndex = 5
                                    GetBallotQuestionGridResults()
                                Case Else
                                    MultiView.ActiveViewIndex = 0
                            End Select
                        Else
                            ddlCategory.SelectedValue = 1
                        End If
                    Else
                        ddlCategory.SelectedValue = 1
                    End If
                Else
                    MultiView.ActiveViewIndex = 1
                End If
            End If
        Else
            sElectionCode = ddlElection.SelectedValue
            hElecCode.Value = sElectionCode
        End If
    End Sub

    Protected Sub GridView2_DataBound(ByVal sender As System.Object, ByVal e As System.EventArgs)
        lTotal = 0
    End Sub

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
            e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Left
            e.Row.Cells(0).Text = "Total"
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

    Private Sub GetEVTurnoutGridResults()
        Dim cn As New OracleConnection(ConfigurationManager.AppSettings("ELECP-WEB"))
        Dim sSQL As String
        Dim rdr As OracleDataReader
        Dim iSessions As Integer = 0
        Dim iSites As Integer = 0
        Dim x As Integer = 0
        Dim y As Integer = 0
        Dim z As Integer = 0
        Dim lTotal As Long = 0
        Dim lEVTotal As Long = 0
        Dim iTry As Integer = 0

        Try
            'Get the number of EV sessions
            sSQL = "select count(distinct ev_session) from cl_ev_turnout where election_code='" & sElectionCode & "'"

            Dim cmd As New OracleCommand(sSQL)
            cmd.Connection = cn
            cn.Open()
            iSessions = cmd.ExecuteScalar
            'cmd.Connection.Close()
            cmd.Dispose()

            If iSessions > 0 Then
                rEVTurnoutMsg.Visible = False
                rEVTotals.Visible = True
                rWeek1.Visible = True
                rWeek2.Visible = True

                'Get the number of EV sessions -- use list_order in case a site name changes from 1st to 2nd week
                sSQL = "select count(distinct list_order) from cl_ev_turnout where election_code='" & sElectionCode & "'"

                cmd = New OracleCommand(sSQL)
                cmd.Connection = cn
                'cn.Open()
                iSites = cmd.ExecuteScalar
                'cmd.Connection.Close()
                cmd.Dispose()

                Dim lSessionTurnout(iSites - 1, iSessions - 1) As Long

                'Setup link to EV Schedule
                Dim sUrl As String = "EV_Schedules/" & sElectionCode & "_EV_SCHED.pdf"

                If bUrlIsValid(sUrl) Then
                    Dim hlSched As New HyperLink

                    hlSched.Text = "Horario de la Votación Temprana"
                    hlSched.NavigateUrl = sUrl

                    PlaceHolder1.Controls.Add(hlSched)
                End If

                If iSessions > 14 Then
                    'Display turnout for NLV In-Office Voting
                    rNLV1.Visible = True
                    rNLV2.Visible = True

                    Dim tblNLV As Table = New Table()
                    Dim trNLV As TableRow = New TableRow()
                    Dim tcNLV As TableCell = New TableCell()
                    Dim lblTextNLV As Label = New Label

                    PlaceHolderNLV.Controls.Add(tblNLV)
                    lEVTotal = 0

                    'Create table header row
                    sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                        "where rownum <= " & (iSessions - 14) & " order by 1"

                    cmd = New OracleCommand(sSQL)
                    cmd.Connection = cn
                    'cn.Open()
                    rdr = cmd.ExecuteReader

                    If rdr.HasRows Then
                        tblNLV.CellPadding = 3
                        tblNLV.CellSpacing = 0

                        tcNLV = New TableCell
                        lblTextNLV = New Label

                        lblTextNLV.Text = "Sitio de Votación En Oficina"
                        tcNLV.Controls.Add(lblTextNLV)
                        tcNLV.Wrap = False
                        tcNLV.Font.Bold = True
                        tcNLV.BackColor = Drawing.Color.LightBlue
                        tcNLV.BorderStyle = BorderStyle.Groove
                        tcNLV.BorderWidth = 2
                        tcNLV.Width = 240
                        tcNLV.HorizontalAlign = HorizontalAlign.Left
                        trNLV.Cells.Add(tcNLV)

                        While rdr.Read
                            tcNLV = New TableCell
                            lblTextNLV = New Label

                            lblTextNLV.Text = rdr.GetValue(0).ToString
                            tcNLV.Controls.Add(lblTextNLV)
                            tcNLV.Wrap = False
                            tcNLV.Font.Bold = True
                            tcNLV.BackColor = Drawing.Color.LightBlue
                            tcNLV.BorderStyle = BorderStyle.Groove
                            tcNLV.BorderWidth = 2
                            tcNLV.HorizontalAlign = HorizontalAlign.Center
                            trNLV.Cells.Add(tcNLV)
                        End While

                        tcNLV = New TableCell
                        lblTextNLV = New Label

                        lblTextNLV.Text = "Total"
                        tcNLV.Controls.Add(lblTextNLV)
                        tcNLV.Wrap = False
                        tcNLV.Font.Bold = True
                        tcNLV.BackColor = Drawing.Color.LightGray
                        tcNLV.BorderStyle = BorderStyle.Groove
                        tcNLV.BorderWidth = 2
                        tcNLV.HorizontalAlign = HorizontalAlign.Center
                        trNLV.Cells.Add(tcNLV)
                        tblNLV.Rows.Add(trNLV)

                        rdr.Close()
                        'cmd.Connection.Close()
                        cmd.Dispose()

                        For x = 1 To iSites
                            sSQL = "select distinct ev_site, muni_code from cl_ev_turnout where election_code='" & sElectionCode & _
                                "' and list_order='" & CStr(x) & "' and muni_code = 'NLV' and upper(ev_site) like '%CLERK%'"

                            cmd = New OracleCommand(sSQL)
                            cmd.Connection = cn
                            'cn.Open()
                            rdr = cmd.ExecuteReader

                            If rdr.HasRows Then
                                trNLV = New TableRow()
                                tcNLV = New TableCell()
                                lblTextNLV = New Label

                                rdr.Read()

                                If rdr.GetValue(1).ToString <> "CC" And UCase(Left(rdr.GetValue(0).ToString, 11)) = "MOBILE TEAM" Then
                                    lblTextNLV.Text = rdr.GetValue(0).ToString & " (" & rdr.GetValue(1).ToString() & ")"
                                Else
                                    lblTextNLV.Text = rdr.GetValue(0).ToString
                                End If

                                tcNLV.Controls.Add(lblTextNLV)
                                tcNLV.Wrap = False
                                tcNLV.BorderStyle = BorderStyle.Groove
                                tcNLV.BorderWidth = 2
                                tcNLV.HorizontalAlign = HorizontalAlign.Left
                                trNLV.Cells.Add(tcNLV)

                                rdr.Close()
                                'cmd.Connection.Close()
                                cmd.Dispose()

                                sSQL = "select dtSession, lTurnout, rownum from (select dtSession, lTurnout from " & _
                                    "(select to_char(ev_session, 'mm/dd') dtSession, to_char(sum(site_turnout),'FM999,999') lTurnout from cl_ev_turnout " & _
                                    "where election_code='" & sElectionCode & "' and list_order='" & CStr(x) & _
                                    "' group by ev_session order by 1)) where rownum <= " & (iSessions - 14) & " order by 1"

                                cmd = New OracleCommand(sSQL)
                                cmd.Connection = cn
                                'cn.Open()
                                rdr = cmd.ExecuteReader

                                z = 0

                                While rdr.Read
                                    tcNLV = New TableCell
                                    lblTextNLV = New Label

                                    If Not IsDBNull(rdr.GetValue(1)) Then
                                        lblTextNLV.Text = rdr.GetValue(1).ToString

                                        If IsNumeric(rdr.GetValue(1)) Then
                                            lSessionTurnout(x - 1, z) += CLng(rdr.GetValue(1))
                                            lTotal += CLng(rdr.GetValue(1))
                                        End If
                                    Else
                                        lblTextNLV.Text = ""
                                    End If

                                    tcNLV.Controls.Add(lblTextNLV)
                                    tcNLV.Wrap = False
                                    'If lblTextNLV.Text = "" Then
                                    '    tcNLV.BackColor = Drawing.Color.LightGray
                                    'End If
                                    tcNLV.BorderStyle = BorderStyle.Groove
                                    tcNLV.BorderWidth = 2
                                    tcNLV.HorizontalAlign = HorizontalAlign.Right
                                    trNLV.Cells.Add(tcNLV)
                                    z += 1
                                End While

                                tcNLV = New TableCell
                                lblTextNLV = New Label

                                lblTextNLV.Text = FormatNumber(lTotal, 0)
                                tcNLV.Controls.Add(lblTextNLV)
                                tcNLV.Wrap = False
                                tcNLV.Font.Bold = True
                                tcNLV.BorderStyle = BorderStyle.Groove
                                tcNLV.BackColor = Drawing.Color.LightGray
                                tcNLV.BorderWidth = 2
                                tcNLV.HorizontalAlign = HorizontalAlign.Right
                                trNLV.Cells.Add(tcNLV)

                                tblNLV.Rows.Add(trNLV)
                                lEVTotal += lTotal
                                lTotal = 0

                                rdr.Close()
                                'cmd.Connection.Close()
                                cmd.Dispose()
                            Else
                                rdr.Close()
                                'cmd.Connection.Close()
                                cmd.Dispose()
                            End If
                        Next x
                    Else
                        rdr.Close()
                        'cmd.Connection.Close()
                        cmd.Dispose()
                    End If

                Else
                    rNLV1.Visible = False
                    rNLV2.Visible = False
                End If

                'Daily Turnout - Week 1
                Dim tbl1 As Table = New Table()
                Dim tr1 As TableRow = New TableRow()
                Dim tc1 As TableCell = New TableCell()
                Dim lblText1 As Label = New Label

                PlaceHolderW1.Controls.Add(tbl1)
                lEVTotal = 0
                lTotal = 0

                'Create table header row
                If iSessions < 14 Then
                    sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                        "order by 1"
                ElseIf iSessions = 14 Then
                    sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                        "where rownum <= " & (iSessions - 7) & " order by 1"
                Else
                    sSQL = "select dtSession from (select dtSession, rownum rNum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1)) " & _
                        "where rNum > " & (iSessions - 14) & " and rNum <= " & (iSessions - 7) & " order by 1"
                End If

                cmd = New OracleCommand(sSQL)
                cmd.Connection = cn
                'cn.Open()
                rdr = cmd.ExecuteReader

                If rdr.HasRows Then
                    tbl1.CellPadding = 3
                    tbl1.CellSpacing = 0

                    tc1 = New TableCell
                    lblText1 = New Label

                    lblText1.Text = "Centro de Votación"
                    tc1.Controls.Add(lblText1)
                    tc1.Wrap = False
                    tc1.Font.Bold = True
                    tc1.BackColor = Drawing.Color.LightBlue
                    tc1.BorderStyle = BorderStyle.Groove
                    tc1.BorderWidth = 2
                    tc1.Width = 240
                    tc1.HorizontalAlign = HorizontalAlign.Left
                    tr1.Cells.Add(tc1)

                    While rdr.Read
                        tc1 = New TableCell
                        lblText1 = New Label

                        lblText1.Text = rdr.GetValue(0).ToString
                        tc1.Controls.Add(lblText1)
                        tc1.Wrap = False
                        tc1.Font.Bold = True
                        tc1.BackColor = Drawing.Color.LightBlue
                        tc1.BorderStyle = BorderStyle.Groove
                        tc1.BorderWidth = 2
                        tc1.HorizontalAlign = HorizontalAlign.Center
                        tr1.Cells.Add(tc1)
                    End While

                    tc1 = New TableCell
                    lblText1 = New Label

                    lblText1.Text = "Totales"
                    tc1.Controls.Add(lblText1)
                    tc1.Wrap = False
                    tc1.Font.Bold = True
                    tc1.BackColor = Drawing.Color.LightGray
                    tc1.BorderStyle = BorderStyle.Groove
                    tc1.BorderWidth = 2
                    tc1.HorizontalAlign = HorizontalAlign.Center
                    tr1.Cells.Add(tc1)
                    tbl1.Rows.Add(tr1)

                    rdr.Close()
                    'cmd.Connection.Close()
                    cmd.Dispose()

                    For x = 1 To iSites
                        sSQL = "select distinct ev_site, muni_code from cl_ev_turnout where election_code='" & sElectionCode & _
                            "' and list_order='" & CStr(x) & "'"

                        cmd = New OracleCommand(sSQL)
                        cmd.Connection = cn
                        'cn.Open()
                        rdr = cmd.ExecuteReader

                        If rdr.HasRows Then
                            tr1 = New TableRow()
                            tc1 = New TableCell()
                            lblText1 = New Label

                            rdr.Read()
                            If rdr.GetValue(1).ToString <> "CC" And UCase(Left(rdr.GetValue(0).ToString, 11)) = "MOBILE TEAM" Then
                                lblText1.Text = rdr.GetValue(0).ToString & " (" & rdr.GetValue(1).ToString() & ")"
                            Else
                                lblText1.Text = rdr.GetValue(0).ToString
                            End If

                            tc1.Controls.Add(lblText1)
                            tc1.Wrap = False
                            tc1.BorderStyle = BorderStyle.Groove
                            tc1.BorderWidth = 2
                            tc1.HorizontalAlign = HorizontalAlign.Left
                            tr1.Cells.Add(tc1)

                            rdr.Close()
                            'cmd.Connection.Close()
                            cmd.Dispose()

                            If iSessions < 14 Then
                                sSQL = "select dtSession, lTurnout, rownum from (select dtSession, lTurnout from " & _
                                    "(select to_char(ev_session, 'mm/dd') dtSession, to_char(sum(site_turnout),'FM999,999') lTurnout from cl_ev_turnout " & _
                                    "where election_code='" & sElectionCode & "' and list_order='" & CStr(x) & _
                                    "' group by ev_session order by 1)) order by 1"
                            ElseIf iSessions = 14 Then
                                sSQL = "select dtSession, lTurnout, rownum from (select dtSession, lTurnout from " & _
                                    "(select to_char(ev_session, 'mm/dd') dtSession, to_char(sum(site_turnout),'FM999,999') lTurnout from cl_ev_turnout " & _
                                    "where election_code='" & sElectionCode & "' and list_order='" & CStr(x) & _
                                    "' group by ev_session order by 1)) where rownum <= " & (iSessions - 7) & " order by 1"
                            Else
                                sSQL = "select dtSession, lTurnout from (select dtSession, lTurnout, rownum rNum from " & _
                                    "(select to_char(ev_session, 'mm/dd') dtSession, to_char(sum(site_turnout),'FM999,999') lTurnout from cl_ev_turnout " & _
                                    "where election_code='" & sElectionCode & "' and list_order='" & CStr(x) & _
                                    "' group by ev_session order by 1) order by 1) where rNum > " & (iSessions - 14) & " and rNum <= " & (iSessions - 7) & " order by 1"
                            End If

                            cmd = New OracleCommand(sSQL)
                            cmd.Connection = cn
                            'cn.Open()
                            rdr = cmd.ExecuteReader

                            If iSessions < 14 Then
                                z = 0
                            Else
                                z = iSessions - 14
                            End If

                            While rdr.Read
                                tc1 = New TableCell
                                lblText1 = New Label

                                If Not IsDBNull(rdr.GetValue(1)) Then
                                    lblText1.Text = rdr.GetValue(1).ToString

                                    If IsNumeric(rdr.GetValue(1)) Then
                                        lSessionTurnout(x - 1, z) += CLng(rdr.GetValue(1))
                                        lTotal += CLng(rdr.GetValue(1))
                                    End If
                                Else
                                    lblText1.Text = ""
                                End If

                                tc1.Controls.Add(lblText1)
                                tc1.Wrap = False
                                'If lblText1.Text = "" Then
                                '    tc1.BackColor = Drawing.Color.LightGray
                                'End If
                                tc1.BorderStyle = BorderStyle.Groove
                                tc1.BorderWidth = 2
                                tc1.HorizontalAlign = HorizontalAlign.Right
                                tr1.Cells.Add(tc1)
                                z += 1
                            End While

                            tc1 = New TableCell
                            lblText1 = New Label

                            lblText1.Text = FormatNumber(lTotal, 0)
                            tc1.Controls.Add(lblText1)
                            tc1.Wrap = False
                            tc1.Font.Bold = True
                            tc1.BorderStyle = BorderStyle.Groove
                            tc1.BackColor = Drawing.Color.LightGray
                            tc1.BorderWidth = 2
                            tc1.HorizontalAlign = HorizontalAlign.Right
                            tr1.Cells.Add(tc1)

                            tbl1.Rows.Add(tr1)
                            lEVTotal += lTotal
                            lTotal = 0

                            rdr.Close()
                            'cmd.Connection.Close()
                            cmd.Dispose()
                        Else
                            rdr.Close()
                            'cmd.Connection.Close()
                            cmd.Dispose()
                        End If
                    Next x

                    'Footer row
                    tr1 = New TableRow()
                    tc1 = New TableCell
                    lblText1 = New Label

                    lblText1.Text = "Totales Diarios"
                    tc1.Controls.Add(lblText1)
                    tc1.Wrap = False
                    tc1.Font.Bold = True
                    tc1.BackColor = Drawing.Color.LightGray
                    tc1.BorderStyle = BorderStyle.Groove
                    tc1.BorderWidth = 2
                    tc1.HorizontalAlign = HorizontalAlign.Left
                    tr1.Cells.Add(tc1)

                    If iSessions < 14 Then
                        sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                            "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                            "order by 1"
                    ElseIf iSessions = 14 Then
                        sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                            "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                            "where rownum <= " & (iSessions - 7) & " order by 1"
                    Else
                        sSQL = "select dtSession from (select dtSession, rownum rNum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                            "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1)) " & _
                            "where rNum > " & (iSessions - 14) & " and rNum <= " & (iSessions - 7) & " order by 1"
                    End If

                    Dim iStart As Integer = 0
                    Dim iEnd As Integer = 0

                    If iSessions < 14 Then
                        iStart = 0
                        iEnd = iSessions - 1
                    ElseIf iSessions = 14 Then
                        iStart = 0
                        iEnd = iSessions - 8
                    Else
                        iStart = iSessions - 14
                        iEnd = iSessions - 8
                    End If

                    For x = iStart To iEnd
                        lTotal = 0

                        For y = 0 To iSites - 1
                            lTotal = lTotal + lSessionTurnout(y, x)
                        Next

                        tc1 = New TableCell
                        lblText1 = New Label

                        lblText1.Text = FormatNumber(lTotal, 0)
                        tc1.Controls.Add(lblText1)
                        tc1.Wrap = False
                        tc1.Font.Bold = True
                        tc1.BackColor = Drawing.Color.LightGray
                        tc1.BorderStyle = BorderStyle.Groove
                        tc1.BorderWidth = 2
                        tc1.HorizontalAlign = HorizontalAlign.Right
                        tr1.Cells.Add(tc1)
                    Next

                    tc1 = New TableCell
                    lblText1 = New Label

                    lblText1.Text = FormatNumber(lEVTotal, 0)
                    tc1.Controls.Add(lblText1)
                    tc1.Wrap = False
                    tc1.Font.Bold = True
                    tc1.BackColor = Drawing.Color.LightGray
                    tc1.BorderStyle = BorderStyle.Groove
                    tc1.BorderWidth = 2
                    tc1.HorizontalAlign = HorizontalAlign.Right
                    tr1.Cells.Add(tc1)

                    tbl1.Rows.Add(tr1)
                Else
                    rdr.Close()
                    'cmd.Connection.Close()
                    cmd.Dispose()
                End If

                If iSessions >= 14 Then
                    'Daily Turnout - Week 2
                    Dim tbl2 As Table = New Table()
                    Dim tr2 As TableRow = New TableRow()
                    Dim tc2 As TableCell = New TableCell()
                    Dim lblText2 As Label = New Label

                    PlaceHolderW2.Controls.Add(tbl2)
                    lEVTotal = 0
                    lTotal = 0

                    'Create table header row
                    sSQL = "select dtSession from (select dtSession, rownum rNum from (select dtSession from " & _
                        "(select distinct to_char(ev_session, 'mm/dd') dtSession from cl_ev_turnout " & _
                        "where election_code='" & sElectionCode & "' order by 1) order by 1)) " & _
                        "where rNum > " & (iSessions - 7) & " order by 1"

                    cmd = New OracleCommand(sSQL)
                    cmd.Connection = cn
                    'cn.Open()
                    rdr = cmd.ExecuteReader

                    If rdr.HasRows Then
                        tbl2.CellPadding = 3
                        tbl2.CellSpacing = 0

                        tc2 = New TableCell
                        lblText2 = New Label

                        lblText2.Text = "Centro de Votación"
                        tc2.Controls.Add(lblText2)
                        tc2.Wrap = False
                        tc2.Font.Bold = True
                        tc2.BackColor = Drawing.Color.LightBlue
                        tc2.BorderStyle = BorderStyle.Groove
                        tc2.BorderWidth = 2
                        tc2.Width = 240
                        tc2.HorizontalAlign = HorizontalAlign.Left
                        tr2.Cells.Add(tc2)

                        While rdr.Read
                            tc2 = New TableCell
                            lblText2 = New Label

                            lblText2.Text = rdr.GetValue(0).ToString
                            tc2.Controls.Add(lblText2)
                            tc2.Wrap = False
                            tc2.Font.Bold = True
                            tc2.BackColor = Drawing.Color.LightBlue
                            tc2.BorderStyle = BorderStyle.Groove
                            tc2.BorderWidth = 2
                            tc2.HorizontalAlign = HorizontalAlign.Center
                            tr2.Cells.Add(tc2)
                        End While

                        tc2 = New TableCell
                        lblText2 = New Label

                        lblText2.Text = "Totales"
                        tc2.Controls.Add(lblText2)
                        tc2.Wrap = False
                        tc2.Font.Bold = True
                        tc2.BackColor = Drawing.Color.LightGray
                        tc2.BorderStyle = BorderStyle.Groove
                        tc2.BorderWidth = 2
                        tc2.HorizontalAlign = HorizontalAlign.Center
                        tr2.Cells.Add(tc2)
                        tbl2.Rows.Add(tr2)

                        rdr.Close()
                        'cmd.Connection.Close()
                        cmd.Dispose()

                        For x = 1 To iSites
                            sSQL = "select distinct ev_site, muni_code from cl_ev_turnout where election_code='" & sElectionCode & _
                                "' and list_order='" & CStr(x) & "'"

                            cmd = New OracleCommand(sSQL)
                            cmd.Connection = cn
                            'cn.Open()
                            rdr = cmd.ExecuteReader

                            If rdr.HasRows Then
                                tr2 = New TableRow()
                                tc2 = New TableCell()
                                lblText2 = New Label

                                rdr.Read()

                                If rdr.GetValue(1).ToString <> "CC" And UCase(Left(rdr.GetValue(0).ToString, 11)) = "MOBILE TEAM" Then
                                    lblText2.Text = rdr.GetValue(0).ToString & " (" & rdr.GetValue(1).ToString() & ")"
                                Else
                                    lblText2.Text = rdr.GetValue(0).ToString
                                End If

                                tc2.Controls.Add(lblText2)
                                tc2.Wrap = False
                                tc2.BorderStyle = BorderStyle.Groove
                                tc2.BorderWidth = 2
                                tc2.HorizontalAlign = HorizontalAlign.Left
                                tr2.Cells.Add(tc2)

                                rdr.Close()
                                'cmd.Connection.Close()
                                cmd.Dispose()

                                sSQL = "select dtSession, lTurnout from (select dtSession, lTurnout, rownum rNum from " & _
                                    "(select to_char(ev_session, 'mm/dd') dtSession, to_char(sum(site_turnout),'FM999,999') lTurnout from cl_ev_turnout " & _
                                    "where election_code='" & sElectionCode & "' and list_order='" & CStr(x) & _
                                    "' group by ev_session order by 1) order by 1) where rNum > " & (iSessions - 7) & " order by 1"

                                cmd = New OracleCommand(sSQL)
                                cmd.Connection = cn
                                'cn.Open()
                                rdr = cmd.ExecuteReader

                                z = iSessions - 7

                                While rdr.Read
                                    tc2 = New TableCell
                                    lblText2 = New Label

                                    If Not IsDBNull(rdr.GetValue(1)) Then
                                        lblText2.Text = rdr.GetValue(1).ToString

                                        If IsNumeric(rdr.GetValue(1)) Then
                                            lSessionTurnout(x - 1, z) += CLng(rdr.GetValue(1))
                                            lTotal += CLng(rdr.GetValue(1))
                                        End If
                                    Else
                                        lblText2.Text = ""
                                    End If

                                    tc2.Controls.Add(lblText2)
                                    tc2.Wrap = False
                                    'If lblText2.Text = "" Then
                                    '    tc2.BackColor = Drawing.Color.LightGray
                                    'End If
                                    tc2.BorderStyle = BorderStyle.Groove
                                    tc2.BorderWidth = 2
                                    tc2.HorizontalAlign = HorizontalAlign.Right
                                    tr2.Cells.Add(tc2)
                                    z += 1
                                End While

                                tc2 = New TableCell
                                lblText2 = New Label

                                lblText2.Text = FormatNumber(lTotal, 0)
                                tc2.Controls.Add(lblText2)
                                tc2.Wrap = False
                                tc2.Font.Bold = True
                                tc2.BorderStyle = BorderStyle.Groove
                                tc2.BackColor = Drawing.Color.LightGray
                                tc2.BorderWidth = 2
                                tc2.HorizontalAlign = HorizontalAlign.Right
                                tr2.Cells.Add(tc2)

                                tbl2.Rows.Add(tr2)
                                lEVTotal += lTotal
                                lTotal = 0

                                rdr.Close()
                                'cmd.Connection.Close()
                                cmd.Dispose()
                            Else
                                rdr.Close()
                                'cmd.Connection.Close()
                                cmd.Dispose()
                            End If
                        Next x

                        'Footer row
                        tr2 = New TableRow()
                        tc2 = New TableCell
                        lblText2 = New Label

                        lblText2.Text = "Totales Diarios"
                        tc2.Controls.Add(lblText2)
                        tc2.Wrap = False
                        tc2.Font.Bold = True
                        tc2.BackColor = Drawing.Color.LightGray
                        tc2.BorderStyle = BorderStyle.Groove
                        tc2.BorderWidth = 2
                        tc2.HorizontalAlign = HorizontalAlign.Left
                        tr2.Cells.Add(tc2)

                        For x = (iSessions - 7) To iSessions - 1
                            lTotal = 0

                            For y = 0 To iSites - 1
                                lTotal = lTotal + lSessionTurnout(y, x)
                            Next

                            tc2 = New TableCell
                            lblText2 = New Label

                            lblText2.Text = FormatNumber(lTotal, 0)
                            tc2.Controls.Add(lblText2)
                            tc2.Wrap = False
                            tc2.Font.Bold = True
                            tc2.BackColor = Drawing.Color.LightGray
                            tc2.BorderStyle = BorderStyle.Groove
                            tc2.BorderWidth = 2
                            tc2.HorizontalAlign = HorizontalAlign.Right
                            tr2.Cells.Add(tc2)
                        Next

                        tc2 = New TableCell
                        lblText2 = New Label

                        lblText2.Text = FormatNumber(lEVTotal, 0)
                        tc2.Controls.Add(lblText2)
                        tc2.Wrap = False
                        tc2.Font.Bold = True
                        tc2.BackColor = Drawing.Color.LightGray
                        tc2.BorderStyle = BorderStyle.Groove
                        tc2.BorderWidth = 2
                        tc2.HorizontalAlign = HorizontalAlign.Right
                        tr2.Cells.Add(tc2)

                        tbl2.Rows.Add(tr2)
                    Else
                        rdr.Close()
                        'cmd.Connection.Close()
                        cmd.Dispose()
                    End If
                Else
                    rWeek2.Visible = False
                End If
            Else
                rEVTotals.Visible = False
                rWeek1.Visible = False
                rWeek2.Visible = False
                rNLV1.Visible = False
                rNLV2.Visible = False

                'No early voting session are in the database
                rEVTotals.Visible = False
                rEVTurnoutMsg.Visible = True
                lblEVTurnout.Text = "No hubo votación temprana para ésta elección o los datos de la participación electoral no están disponibles en línea."
            End If

        Finally
            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If
        End Try
    End Sub

    Private Sub GetSOVGridResults()
        Dim cn As New OracleConnection(ConfigurationManager.AppSettings("ELECP-WEB"))
        Dim sSQL As String
        Dim rdr As OracleDataReader

        Try
            Dim tbl As Table = New Table()
            Dim tr As TableRow = New TableRow()
            Dim tc As TableCell = New TableCell()
            Dim lblText As Label = New Label
            Dim hlFilePath As HyperLink = New HyperLink

            'Get SOV contests and file links
            sSQL = "SELECT DISTINCT CONTEST_FULL_NAME, CONTEST_ORDER, " & _
                "'sov/' || ELECTION_CODE || '/' || SOV_FILE_NAME || '.pdf' AS SOV_PDF, " & _
                "'sov/' || ELECTION_CODE || '/' || replace(SOV_FILE_NAME,' ','_') || '.txt' AS SOV_FILE " & _
                "FROM CLARK.CL_ELECTION_RESULTS WHERE (ELECTION_CODE = '" & sElectionCode & "' AND " & _
                "ELECTION_SUBCODE = '00') AND (TO_NUMBER(CONTEST_ORDER) > 0 AND " & _
                "UPPER(CONTEST_FULL_NAME) NOT LIKE 'REGISTRATION%') ORDER BY TO_NUMBER(CONTEST_ORDER)"

            Dim cmd As New OracleCommand(sSQL)
            cmd = New OracleCommand(sSQL)
            cmd.Connection = cn
            cn.Open()
            rdr = cmd.ExecuteReader

            If rdr.HasRows Then
                PlaceHolder3.Controls.Add(tbl)

                tbl.CellPadding = 1
                tbl.CellSpacing = 0

                tc = New TableCell
                lblText = New Label

                lblText.Text = "Contienda"
                tc.Controls.Add(lblText)
                tc.Wrap = False
                tc.Font.Bold = True
                tc.BackColor = Drawing.Color.LightSkyBlue
                tc.BorderStyle = BorderStyle.Groove
                tc.BorderWidth = 2
                tc.HorizontalAlign = HorizontalAlign.Left
                tr.Cells.Add(tc)

                tc = New TableCell
                lblText = New Label

                lblText.Text = "Informe"
                tc.Controls.Add(lblText)
                tc.Wrap = False
                tc.Font.Bold = True
                tc.BackColor = Drawing.Color.LightSkyBlue
                tc.BorderStyle = BorderStyle.Groove
                tc.BorderWidth = 2
                tc.HorizontalAlign = HorizontalAlign.Center
                tr.Cells.Add(tc)

                tc = New TableCell
                lblText = New Label

                lblText.Text = "Archivo"
                tc.Controls.Add(lblText)
                tc.Wrap = False
                tc.Font.Bold = True
                tc.BackColor = Drawing.Color.LightSkyBlue
                tc.BorderStyle = BorderStyle.Groove
                tc.BorderWidth = 2
                tc.HorizontalAlign = HorizontalAlign.Center
                tr.Cells.Add(tc)

                tbl.Rows.Add(tr)

                While rdr.Read
                    tr = New TableRow()

                    'Contest
                    tc = New TableCell
                    lblText = New Label
                    lblText.Text = rdr.GetValue(0).ToString
                    tc.Controls.Add(lblText)
                    tc.Wrap = False
                    tc.BorderStyle = BorderStyle.Groove
                    tc.BorderWidth = 2
                    tc.HorizontalAlign = HorizontalAlign.Left
                    tr.Cells.Add(tc)

                    'PDF File
                    tc = New TableCell

                    If bUrlIsValid(rdr.GetValue(2).ToString) Then
                        hlFilePath = New HyperLink
                        hlFilePath.Text = "PDF"
                        hlFilePath.NavigateUrl = "http://redrock.clarkcountynv.gov/electionresults/" & rdr.GetValue(2).ToString
                        tc.Controls.Add(hlFilePath)
                    Else
                        lblText = New Label
                        lblText.Text = "N/A"
                        tc.Controls.Add(lblText)
                    End If

                    tc.Wrap = False
                    tc.BorderStyle = BorderStyle.Groove
                    tc.BorderWidth = 2
                    tc.HorizontalAlign = HorizontalAlign.Center
                    tr.Cells.Add(tc)

                    'Data File
                    tc = New TableCell

                    If bUrlIsValid(rdr.GetValue(3).ToString) Then
                        hlFilePath = New HyperLink
                        hlFilePath.Text = "Data"
                        hlFilePath.NavigateUrl = "http://redrock.clarkcountynv.gov/electionresults/" & rdr.GetValue(3).ToString
                        tc.Controls.Add(hlFilePath)
                    Else
                        lblText = New Label
                        lblText.Text = "N/A"
                        tc.Controls.Add(lblText)
                    End If

                    tc.Wrap = False
                    tc.BorderStyle = BorderStyle.Groove
                    tc.BorderWidth = 2
                    tc.HorizontalAlign = HorizontalAlign.Center
                    tr.Cells.Add(tc)
                    tbl.Rows.Add(tr)
                End While
            End If

            rdr.Close()
            cmd.Connection.Close()
            cmd.Dispose()

        Finally
            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If
        End Try
    End Sub

    Private Sub GetBallotQuestionGridResults()
        Dim cn As New OracleConnection(ConfigurationManager.AppSettings("ELECP-WEB"))
        Dim sSQL As String
        Dim rdr As OracleDataReader

        Try
            Dim tbl As Table = New Table()
            Dim tr As TableRow = New TableRow()
            Dim tc As TableCell = New TableCell()
            Dim lblText As Label = New Label
            Dim hlFilePath As HyperLink = New HyperLink

            'Get Ballot Question file links
            sSQL = "SELECT DISTINCT CONTEST_FULL_NAME, CONTEST_ORDER, " & _
                "'BallotQuestions/' || ELECTION_CODE || '/PDF_SP/' || replace(SOV_FILE_NAME,' ','_') || '_SP.pdf' AS BQ_PDF, " & _
                "'BallotQuestions/' || ELECTION_CODE || '/WAV_SP/' || replace(SOV_FILE_NAME,' ','_') || '_SP.wav' AS BQ_WAV " & _
                "FROM CLARK.CL_ELECTION_RESULTS WHERE (ELECTION_CODE = '" & sElectionCode & "' AND " & _
                "ELECTION_SUBCODE = '00') AND (TO_NUMBER(CONTEST_ORDER) > 0) AND CONTEST_TYPE = '4' ORDER BY TO_NUMBER(CONTEST_ORDER)"

            Dim cmd As New OracleCommand(sSQL)
            cmd = New OracleCommand(sSQL)
            cmd.Connection = cn
            cn.Open()
            rdr = cmd.ExecuteReader

            If rdr.HasRows Then
                PlaceHolder4.Controls.Add(tbl)

                lblBQMsg.Text = "AVISO: Para descargar un PDF o WAV, presione el botón derecho del ratón sobre el enlace y escoja Save Target As... (dependiendo de su navegador)."

                tbl.CellPadding = 1
                tbl.CellSpacing = 0

                tc = New TableCell
                lblText = New Label

                lblText.Text = "Pregunta en la Boleta"
                tc.Controls.Add(lblText)
                tc.Wrap = False
                tc.Font.Bold = True
                tc.BackColor = Drawing.Color.LightSkyBlue
                tc.BorderStyle = BorderStyle.Groove
                tc.BorderWidth = 2
                tc.HorizontalAlign = HorizontalAlign.Left
                tr.Cells.Add(tc)

                tc = New TableCell
                lblText = New Label

                lblText.Text = "Texto en la Boleta"
                tc.Controls.Add(lblText)
                tc.Wrap = False
                tc.Font.Bold = True
                tc.BackColor = Drawing.Color.LightSkyBlue
                tc.BorderStyle = BorderStyle.Groove
                tc.BorderWidth = 2
                tc.HorizontalAlign = HorizontalAlign.Center
                tr.Cells.Add(tc)

                tc = New TableCell
                lblText = New Label

                lblText.Text = "Archivo de Audio"
                tc.Controls.Add(lblText)
                tc.Wrap = False
                tc.Font.Bold = True
                tc.BackColor = Drawing.Color.LightSkyBlue
                tc.BorderStyle = BorderStyle.Groove
                tc.BorderWidth = 2
                tc.HorizontalAlign = HorizontalAlign.Center
                tr.Cells.Add(tc)

                tbl.Rows.Add(tr)

                While rdr.Read
                    tr = New TableRow()

                    'Ballot Question
                    tc = New TableCell
                    lblText = New Label
                    lblText.Text = rdr.GetValue(0).ToString
                    tc.Controls.Add(lblText)
                    tc.Wrap = False
                    tc.BorderStyle = BorderStyle.Groove
                    tc.BorderWidth = 2
                    tc.HorizontalAlign = HorizontalAlign.Left
                    tr.Cells.Add(tc)

                    'PDF File
                    tc = New TableCell

                    If bUrlIsValid(rdr.GetValue(2).ToString) Then
                        hlFilePath = New HyperLink
                        hlFilePath.Text = "PDF"
                        hlFilePath.NavigateUrl = "http://redrock.clarkcountynv.gov/electionresults/" & rdr.GetValue(2).ToString
                        tc.Controls.Add(hlFilePath)
                    Else
                        lblText = New Label
                        lblText.Text = "N/A"
                        tc.Controls.Add(lblText)
                    End If

                    tc.Wrap = False
                    tc.BorderStyle = BorderStyle.Groove
                    tc.BorderWidth = 2
                    tc.HorizontalAlign = HorizontalAlign.Center
                    tr.Cells.Add(tc)

                    'Wave File
                    tc = New TableCell

                    If bUrlIsValid(rdr.GetValue(3).ToString) Then
                        hlFilePath = New HyperLink
                        hlFilePath.Text = "WAV"
                        hlFilePath.NavigateUrl = "http://redrock.clarkcountynv.gov/electionresults/" & rdr.GetValue(3).ToString
                        tc.Controls.Add(hlFilePath)
                    Else
                        lblText = New Label
                        lblText.Text = "N/A"
                        tc.Controls.Add(lblText)
                    End If

                    tc.Wrap = False
                    tc.BorderStyle = BorderStyle.Groove
                    tc.BorderWidth = 2
                    tc.HorizontalAlign = HorizontalAlign.Center
                    tr.Cells.Add(tc)
                    tbl.Rows.Add(tr)

                End While

            Else
                lblBQMsg.Text = "AVISO: No hay preguntas en la boleta electoral de la elección seleccionada."
            End If

            rdr.Close()
            cmd.Connection.Close()
            cmd.Dispose()

        Finally
            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If
        End Try
    End Sub


    Private Function bUrlIsValid(ByVal sUrl) As Boolean
        Dim HttpWReq As HttpWebRequest
        Dim HttpWResp As HttpWebResponse
        Try
            HttpWReq = CType(WebRequest.Create("http://redrock.clarkcountynv.gov/electionresults/" & sUrl), HttpWebRequest)
            HttpWResp = CType(HttpWReq.GetResponse(), HttpWebResponse)
            If InStr(HttpWResp.ResponseUri.PathAndQuery, "error", CompareMethod.Text) > 0 Or InStr(HttpWResp.ResponseUri.PathAndQuery, "404", CompareMethod.Text) > 0 Then
                bUrlIsValid = False
            Else
                bUrlIsValid = True
            End If
            HttpWResp.Close()
        Catch ex As Exception
            bUrlIsValid = False
        Finally
            HttpWReq = Nothing
            HttpWResp = Nothing
        End Try
    End Function

    Private Sub btnGenerateVH_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerateVH.Click
        If sElectionCode <> "" Then
            Dim cn As New OracleConnection(ConfigurationManager.AppSettings("ELECP-WEB"))

            cn.Open()

            Dim ds As New DataSet()
            Dim ad As New OracleDataAdapter("select '""'||idnumber||'"",""'||votername||'"",""'||voting_method||'"",""'||precinct||'"",""'||ballot_party||'"",""'||to_char(date_voted,'mm/dd/yyyy')||'"",""'||election_code||'""' vh_rec " & _
                "from clark.cl_vote_history where election_code='" & sElectionCode & "'", cn)

            ad.Fill(ds)

            Dim str As New StringBuilder()

            str.Append("""" & "idnumber" & """" & "," & """" & "votername" & """" & "," & """" & "voting_method" & """" & "," & """" & "precinct" & """" & "," & """" & "ballot_party" & """" & "," & """" & "date_voted" & """" & "," & """" & "election_code" & """")
            str.AppendLine()

            Dim i As Integer
            For i = 0 To ds.Tables(0).Rows.Count - 1

                Dim j As Integer
                For j = 0 To ds.Tables(0).Columns.Count - 1
                    str.Append(ds.Tables(0).Rows(i)(j).ToString())
                Next j

                str.AppendLine()
            Next i

            Response.Clear()
            Response.AddHeader("content-disposition", "attachment;filename=VoterHistory_" & sElectionCode & ".txt")
            Response.Charset = ""
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.ContentType = "text/plain"

            Dim stringWrite As New System.IO.StringWriter()
            Dim htmlWrite = New HtmlTextWriter(stringWrite)

            Response.Write(str.ToString())
            Response.End()

            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If
        End If
    End Sub

    Private Sub GridView5_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView5.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If IsNumeric(e.Row.Cells(1).Text) Then
                lTotal = lTotal + CType(e.Row.Cells(1).Text, Long)
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total"
            e.Row.Cells(1).Text = lTotal.ToString("#,###")
            e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Right
            e.Row.Font.Bold = True
            lTotal = 0
        End If
    End Sub

    Private Sub ddlElection_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlElection.SelectedIndexChanged
        Dim ipos As Integer = InStr(ddlElection.SelectedItem.Text, "(")
        Dim dtDate As Date

        If ipos > 0 Then
            dtDate = Left(Right(ddlElection.SelectedItem.Text, Len(ddlElection.SelectedItem.Text) - ipos), Len(Right(ddlElection.SelectedItem.Text, Len(ddlElection.SelectedItem.Text) - ipos)) - 1)

            If CType(dtDate.Year, Integer) <= 1972 And Right(sElectionCode, 1) = "P" Then
                lblResultsMsg.Text = "<strong>AVISO: Sólo los cargos estatales están disponibles para esta elección. Es posible que información electoral no esté disponible con respecto a la participación electoral, distritos electorales y/o contiendas.</strong><br><br><hr>"
            ElseIf CType(dtDate.Year, Integer) <= 1972 And Right(sElectionCode, 1) <> "P" Then
                lblResultsMsg.Text = "<strong>AVISO: Sólo los cargos estatales están disponibles para esta elección. Es posible que información electoral no esté disponible con respecto a la participación electoral, distritos electorales y/o contiendas.</strong><br><br><hr>"
            Else
                lblResultsMsg.Text = "<hr>"
            End If
        End If

        If ddlCategory.SelectedValue <> "" Then
            Select Case ddlCategory.SelectedValue
                Case "1"
                    MultiView.ActiveViewIndex = 1
                    GridView1.DataBind()
                    GridView3.DataBind()
                Case "2"
                    MultiView.ActiveViewIndex = 2
                    GetEVTurnoutGridResults()
                Case "3"
                    MultiView.ActiveViewIndex = 3
                    GetSOVGridResults()
                Case "4"
                    MultiView.ActiveViewIndex = 4
                Case "5"
                    MultiView.ActiveViewIndex = 5
                    GetBallotQuestionGridResults()
                Case Else
                    MultiView.ActiveViewIndex = 0
            End Select
        End If
    End Sub

    Private Sub GridView3_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            iContestRow = e.Row.RowIndex
        End If
    End Sub

    Private Sub ddlCategory_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategory.SelectedIndexChanged
        Select Case ddlCategory.SelectedValue
            Case "1"
                MultiView.ActiveViewIndex = 1
                GridView1.DataBind()
                GridView3.DataBind()
            Case "2"
                MultiView.ActiveViewIndex = 2
                GetEVTurnoutGridResults()
            Case "3"
                MultiView.ActiveViewIndex = 3
                GetSOVGridResults()
            Case "4"
                MultiView.ActiveViewIndex = 4
            Case "5"
                MultiView.ActiveViewIndex = 5
                GetBallotQuestionGridResults()
            Case Else
                MultiView.ActiveViewIndex = 0
        End Select
    End Sub
End Class