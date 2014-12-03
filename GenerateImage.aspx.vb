Imports System.Web
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Text
Imports System.IO

Partial Public Class GenerateImage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Get requested code/width of graph
        Const ParamCodeId As String = "size"
        Dim requestedSize As String
        requestedSize = Request.QueryString(ParamCodeId)

        ' Get requested color
        Const ParamColor As String = "color"
        Dim requestedColor As String
        requestedColor = Request.QueryString(ParamColor)

        ' Get requested height
        Const ParamHeight As String = "height"
        Dim requestedHeight As String
        requestedHeight = Request.QueryString(ParamHeight)

        ' Check for security 
        If (requestedSize Is Nothing) Or (requestedSize = String.Empty) Or requestedSize = "" Then
            Throw New Exception("200101")
            'Throw New ArgumentNullException(ParamCodeId, "200101")
            Exit Sub
        End If
        If requestedSize.Length() > 100 Then
            'Throw New ArgumentOutOfRangeException(ParamCodeId, "200100")

            Throw New Exception("200100")
            Exit Sub
        End If

        Dim width As Integer
        Dim height As Integer
        Dim bmp As Bitmap
        Dim gfx As Graphics

        If requestedSize.Trim <> "null" And requestedHeight.Trim <> "null" Then
            width = requestedSize.Trim

            If width = 0 Then
                width = 1
            End If

            height = requestedHeight.Trim

            ' Create bitmap
            bmp = New Bitmap(width, height)

            ' Create surface
            gfx = Graphics.FromImage(bmp)

            Select Case requestedColor
                Case "TV" : gfx.Clear(Color.Red)
                Case Else : gfx.Clear(Color.Green)
            End Select
        Else
            ' Create bitmap
            bmp = New Bitmap(1, 10)

            ' Create surface
            gfx = Graphics.FromImage(bmp)

            Select Case requestedColor
                Case "TV" : gfx.Clear(Color.Blue)
                Case Else : gfx.Clear(Color.White)
            End Select
        End If

        ' Set render mode
        gfx.SmoothingMode = Drawing2D.SmoothingMode.None

        ' Create a stream that will contain the bmp
        Dim ms As MemoryStream = New MemoryStream
        bmp.Save(ms, ImageFormat.Gif)

        ' Send image to output stream
        Response.Clear()
        Response.Expires = 0
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.ContentType = "image/gif"
        ms.WriteTo(Response.OutputStream)

        ' Close and Free resources
        ms.Close()
        bmp.Dispose()
    End Sub

End Class