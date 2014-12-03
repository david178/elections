Imports Oracle.DataAccess.Client
Imports System.Net
Imports System.Web
Imports System.IO

Partial Public Class EVTurnout
    Inherits System.Web.UI.Page
    Private lTotal As Long = 0
    Private lEVTotal As Long = 0
    Private lContestTotal As Long = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.MaintainScrollPositionOnPostBack = True

        Call GetEVTurnoutGridResults()
    End Sub

    Private Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
        lTotal = 0
    End Sub

    Private Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If IsNumeric(e.Row.Cells(1).Text) Then
                lTotal = lTotal + CType(e.Row.Cells(1).Text, Long)
            Else
                lTotal = lTotal + 0
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Accumulated Total"
            e.Row.Cells(1).Text = lTotal.ToString("#,###")
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
        Dim lTotal As Long = 0
        Dim lEVTotal As Long = 0
        Dim sElectionCode As String
        Dim sElectionType As String
        Dim iTry As Integer = 0

        Try
            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If

            'Get the default election title
            sSQL = "select upper(elecname) from cl_web_election where default_elec='Y'"

            Dim cmd As New OracleCommand(sSQL)
            cmd.Connection = cn
            cn.Open()
            lblElection.Text = cmd.ExecuteScalar & "<br>Early Voting Turnout"
            'cmd.Connection.Close()
            cmd.Dispose()

            'Get the default election
            sSQL = "select election_code from cl_web_election where default_elec='Y'"

            cmd = New OracleCommand(sSQL)
            cmd.Connection = cn
            'cn.Open()
            sElectionCode = cmd.ExecuteScalar
            'cmd.Connection.Close()
            cmd.Dispose()

            'Get the election type
            sSQL = "select type from cl_web_election where default_elec='Y'"

            cmd = New OracleCommand(sSQL)
            cmd.Connection = cn
            'cn.Open()
            sElectionType = cmd.ExecuteScalar
            'cmd.Connection.Close()
            cmd.Dispose()

            'Get the number of EV sessions
            sSQL = "select count(distinct ev_session) from cl_ev_turnout where election_code='" & sElectionCode & "'"

            cmd = New OracleCommand(sSQL)
            cmd.Connection = cn
            'cn.Open()
            iSessions = cmd.ExecuteScalar
            'cmd.Connection.Close()
            cmd.Dispose()

            If iSessions > 0 Then
                'Get the number of EV sessions -- use list_order in case a site name changes from 1st to 2nd week
                sSQL = "select count(distinct list_order) from cl_ev_turnout where election_code='" & sElectionCode & "'"

                cmd = New OracleCommand(sSQL)
                cmd.Connection = cn
                'cn.Open()
                iSites = cmd.ExecuteScalar
                'cmd.Connection.Close()
                cmd.Dispose()

                If iSites > 1 Then
                    GridView1.Visible = True
                Else
                    GridView1.Visible = False
                End If

                Dim lSessionTurnout(iSites - 1, iSessions - 1) As Long

                If iSessions > 14 And (sElectionType = "G1" Or sElectionType = "P1") Then
                    'Display Turnout Summary by City
                    tblCityTotals.Visible = True

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

                        lblTextNLV.Text = "In-Office Voting Site"
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

                                Dim z As Integer = 0

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
                    tblCityTotals.Visible = False
                    rNLV1.Visible = False
                    rNLV2.Visible = False
                End If

                'Daily Turnout - Week 1
                Dim tbl1 As Table = New Table()
                Dim tr1 As TableRow = New TableRow()
                Dim tc1 As TableCell = New TableCell()
                Dim lblText1 As Label = New Label

                PlaceHolder2.Controls.Add(tbl1)
                lEVTotal = 0
                lTotal = 0

                'Create table header row
                If iSessions < 8 Then
                    sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                        "where rownum <= " & iSessions & " order by 1"
                    lblWeek1.Text = "Daily Turnout"
                ElseIf iSessions = 14 Then
                    sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                        "where rownum <= " & (iSessions - 7) & " order by 1"
                    lblWeek1.Text = "Daily Turnout - Week 1"
                Else
                    sSQL = "select dtSession from (select dtSession, rownum rNum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1)) " & _
                        "where rNum > " & (iSessions - 14) & " and rNum <= " & (iSessions - 7) & " order by 1"
                    lblWeek1.Text = "Daily Turnout - Week 1"
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

                    lblText1.Text = "Early Voting Site"
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

                    If iSites > 1 Then
                        lblText1.Text = "Totals"
                    Else
                        lblText1.Text = "Total"
                    End If

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
                            'If rdr.GetValue(1).ToString <> "CC" And UCase(Left(rdr.GetValue(0).ToString, 11)) = "MOBILE TEAM" Then
                            '    lblText1.Text = rdr.GetValue(0).ToString & " (" & rdr.GetValue(1).ToString() & ")"
                            'Else
                            '    lblText1.Text = rdr.GetValue(0).ToString
                            'End If

                            lblText1.Text = rdr.GetValue(0).ToString

                            tc1.Controls.Add(lblText1)
                            tc1.Wrap = False
                            tc1.BorderStyle = BorderStyle.Groove
                            tc1.BorderWidth = 2
                            tc1.HorizontalAlign = HorizontalAlign.Left
                            tr1.Cells.Add(tc1)

                            rdr.Close()
                            'cmd.Connection.Close()
                            cmd.Dispose()

                            If iSessions < 8 Then
                                sSQL = "select dtSession, lTurnout, rownum from (select dtSession, lTurnout from " & _
                                    "(select to_char(ev_session, 'mm/dd') dtSession, to_char(sum(site_turnout),'FM999,999') lTurnout from cl_ev_turnout " & _
                                    "where election_code='" & sElectionCode & "' and list_order='" & CStr(x) & _
                                    "' group by ev_session order by 1)) where rownum <= " & iSessions & " order by 1"
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

                            Dim z As Integer

                            If iSessions < 8 Then
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

                    If iSites > 1 Then
                        'Footer row
                        tr1 = New TableRow()
                        tc1 = New TableCell
                        lblText1 = New Label

                        lblText1.Text = "Daily Totals"
                        tc1.Controls.Add(lblText1)
                        tc1.Wrap = False
                        tc1.Font.Bold = True
                        tc1.BackColor = Drawing.Color.LightGray
                        tc1.BorderStyle = BorderStyle.Groove
                        tc1.BorderWidth = 2
                        tc1.HorizontalAlign = HorizontalAlign.Left
                        tr1.Cells.Add(tc1)

                        'If iSessions < 8 Then
                        '    sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        '        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                        '        "where rownum <= " & iSessions & " order by 1"
                        'ElseIf iSessions = 14 Then
                        '    sSQL = "select dtSession, rownum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        '        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1) " & _
                        '        "where rownum <= " & (iSessions - 7) & " order by 1"
                        'Else
                        '    sSQL = "select dtSession from (select dtSession, rownum rNum from (select dtSession from (select distinct to_char(ev_session, 'mm/dd') " & _
                        '        "dtSession from cl_ev_turnout where election_code='" & sElectionCode & "' order by 1) order by 1)) " & _
                        '        "where rNum > " & (iSessions - 14) & " and rNum <= " & (iSessions - 7) & " order by 1"
                        'End If

                        Dim iStart As Integer = 0

                        If iSessions <= 14 Then
                            iStart = 0
                        Else
                            iStart = iSessions - 14
                        End If

                        Dim iTo As Integer

                        If iSessions < 8 Then
                            iTo = iSessions - 1
                        ElseIf iSessions >= 14 Then
                            iTo = iSessions - 8
                        End If

                        For x = iStart To iTo
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
                    End If
                Else
                    rdr.Close()
                    'cmd.Connection.Close()
                    cmd.Dispose()
                End If

                If iSessions < 8 Then
                    rWeek2.Visible = False
                Else
                    'Daily Turnout - Week 2
                    Dim tbl2 As Table = New Table()
                    Dim tr2 As TableRow = New TableRow()
                    Dim tc2 As TableCell = New TableCell()
                    Dim lblText2 As Label = New Label

                    PlaceHolder3.Controls.Add(tbl2)
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

                        lblText2.Text = "Early Voting Site"
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

                        lblText2.Text = "Totals"
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

                                'If rdr.GetValue(1).ToString <> "CC" And UCase(Left(rdr.GetValue(0).ToString, 11)) = "MOBILE TEAM" Then
                                '    lblText2.Text = rdr.GetValue(0).ToString & " (" & rdr.GetValue(1).ToString() & ")"
                                'Else
                                '    lblText2.Text = rdr.GetValue(0).ToString
                                'End If

                                lblText2.Text = rdr.GetValue(0).ToString

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

                                Dim z As Integer = iSessions - 7

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

                        lblText2.Text = "Daily Totals"
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
                End If
            Else
                rNLV1.Visible = False
                rNLV2.Visible = False
            End If

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
            bUrlIsValid = True
            HttpWResp.Close()
        Catch ex As Exception
            bUrlIsValid = False
        Finally
            HttpWReq = Nothing
            HttpWResp = Nothing
        End Try
    End Function
End Class