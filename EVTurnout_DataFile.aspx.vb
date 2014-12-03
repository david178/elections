Imports Oracle.DataAccess.Client
Imports System.Net
Imports System.Web
Imports System.IO

Partial Public Class EVTurnout_DataFile
    Inherits System.Web.UI.Page

    Private Sub btnGenerateFile_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerateFile.Click
        If ddlSession.SelectedValue <> "" Then
            If ddlSession.SelectedValue.ToString = "- ALL -" And ddlSession.Items.Count = 1 Then
                btnGenerateFile.Text = "* * * NO DATA POSTED * * *"
            Else
                Dim cn As New OracleConnection(ConfigurationManager.AppSettings("ELECP-WEB"))

                cn.Open()

                Dim sFilename As String = ""

                Dim rdr As OracleDataReader
                Dim sSQL As String = ""

                If ddlSession.SelectedValue.ToString = "- ALL -" Then
                    sFilename = "EVTurnout_Cumulative.txt"
                    sSQL = "select idnumber, name, precinct, ballot_party, congress, senate, assembly, commission, education, regent, school, city, ward, township, status, substr(ev_vote_site,1,5) ev_vote_site, ev_vote_date, election_name " & _
                        "from clark.cl_web_ev_turnout where ev_vote_date < to_char(trunc(sysdate),'MM/DD/YYYY') order by ev_vote_date, name"
                Else
                    sFilename = "EVTurnout_" & ddlSession.SelectedValue.ToString & ".txt"
                    sSQL = "select idnumber, name, precinct, ballot_party, congress, senate, assembly, commission, education, regent, school, city, ward, township, status, substr(ev_vote_site,1,5) ev_vote_site, ev_vote_date, election_name " & _
                        "from clark.cl_web_ev_turnout where ev_vote_date='" & ddlSession.SelectedValue.ToString & "' order by ev_vote_date, name"
                End If

                Dim cmd As New OracleCommand(sSQL)
                cmd.Connection = cn
                rdr = cmd.ExecuteReader
                cmd.Dispose()

                Dim str As New StringBuilder()
                Dim i As Integer = 0

                If rdr.HasRows Then
                    str.Append("""" & "idnumber" & """" & "," & """" & "votername" & """" & "," & """" & "precinct" & """" & "," & """" & "ballot_party" & """" & "," & """" & "congress" & """" & "," & """" & "senate" & """" & "," & """" & "assembly" & """" & "," & """" & "commission" & """" & "," & """" & "education" & """" & "," & """" & "regent" & """" & "," & """" & "school" & """" & "," & """" & "city" & """" & "," & """" & "ward" & """" & "," & """" & "township" & """" & "," & """" & "reg_status" & """" & "," & """" & "ev_vote_site" & """" & "," & """" & "ev_vote_date" & """" & "," & """" & "election_name" & """")
                    str.AppendLine()

                    While rdr.Read
                        str.Append("""" & rdr("idnumber") & """" & "," & """" & rdr("name") & """" & "," & """" & rdr("precinct") & """" & "," & """" & rdr("ballot_party") & """" & "," & """" & rdr("congress") & """" & "," & """" & rdr("senate") & """" & "," & """" & rdr("assembly") & """" & "," & """" & rdr("commission") & """" & "," & """" & rdr("education") & """" & "," & """" & rdr("regent") & """" & "," & """" & rdr("school") & """" & "," & """" & rdr("city") & """" & "," & """" & rdr("ward") & """" & "," & """" & rdr("township") & """" & "," & """" & rdr("status") & """" & "," & """" & rdr("ev_vote_site") & """" & "," & """" & rdr("ev_vote_date") & """" & "," & """" & rdr("election_name") & """")
                        str.AppendLine()

                    End While
                Else
                    str.Append("No data currently posted")
                    str.AppendLine()
                End If

                rdr.Close()

                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" & sFilename)
                Response.Charset = ""
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                Response.ContentType = "text/plain"

                Dim stringWrite As New System.IO.StringWriter()
                Dim htmlWrite = New HtmlTextWriter(stringWrite)

                Try
                    Response.Write(str.ToString())
                    Response.End()
                Catch ex As Exception
                    Dim msg As String
                    msg = ex.Message
                End Try

                If cn.State = ConnectionState.Open Then
                    cn.Close()
                End If
            End If
        End If
    End Sub

    Private Sub ddlSession_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSession.SelectedIndexChanged
        If ddlSession.SelectedValue.ToString = "- ALL -" And ddlSession.Items.Count > 1 Then
            btnGenerateFile.Text = "Generate File: EVTurnout_Cumulative.txt"
        Else
            btnGenerateFile.Text = "Generate File: EVTurnout_" & ddlSession.SelectedValue.ToString & ".txt"
        End If
    End Sub
End Class