Imports Oracle.DataAccess.Client
Imports System.Net
Imports System.Web
Imports System.IO

Partial Public Class SOV_sp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.MaintainScrollPositionOnPostBack = True

        Call GetSOVGridResults()
    End Sub

    Private Sub GetSOVGridResults()
        Dim cn As OracleConnection
        Dim sConn As String = "Data Source=elecp;User ID=elweb;Password=elweb"
        cn = New OracleConnection(sConn)

        Dim sSQL As String
        Dim rdr As OracleDataReader
        Dim cmd As OracleCommand = Nothing
        Dim sElectionCode As String = "10G"

        Try
            cn.Open()

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
                "ELECTION_SUBCODE = '00') AND (TO_NUMBER(CONTEST_ORDER) > 0) ORDER BY TO_NUMBER(CONTEST_ORDER)"

            cmd = New OracleCommand(sSQL, cn)
            rdr = cmd.ExecuteReader
            cmd.Dispose()

            If rdr.HasRows Then
                PlaceHolder1.Controls.Add(tbl)

                tbl.CellPadding = 1
                tbl.CellSpacing = 0

                tc = New TableCell
                lblText = New Label

                lblText.Text = "Contest"
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

                lblText.Text = "Report"
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

                lblText.Text = "File"
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
                        hlFilePath.NavigateUrl = "http://redrock.co.clark.nv.us/electionresults/" & rdr.GetValue(2).ToString
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
                        hlFilePath.NavigateUrl = "http://redrock.co.clark.nv.us/electionresults/" & rdr.GetValue(3).ToString
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

                rdr.Close()
            End If

        Catch ex As Exception

        Finally
            rdr = Nothing
            cn.Dispose()
        End Try
    End Sub

    Private Function bUrlIsValid(ByVal sUrl) As Boolean
        Dim HttpWReq As HttpWebRequest
        Dim HttpWResp As HttpWebResponse
        Try
            HttpWReq = CType(WebRequest.Create("http://redrock.co.clark.nv.us/electionresults/" & sUrl), HttpWebRequest)
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