Partial Public Class graph
    Inherits System.Web.UI.UserControl
    Private _code As String
    Private _color As String
    Private _height As String

    Public Property Code() As String
        Get
            Return _code
        End Get
        Set(ByVal Value As String)
            _code = Value
        End Set
    End Property

    Public Property Color() As String
        Get
            Return _color
        End Get
        Set(ByVal Value As String)
            _color = Value
        End Set
    End Property

    Public Property Height() As String
        Get
            Return _height
        End Get
        Set(ByVal Value As String)
            _height = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        imgGraph.ImageUrl = "~/GenerateImage.aspx?size=" & _code & "&color=" & _color & "&height=" & _height
    End Sub
End Class