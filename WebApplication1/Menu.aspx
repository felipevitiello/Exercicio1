<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="WebApplication1.Menu" %>

<html>

    <head runat="server">
        
        <link href="Css/bootstrap.min.css" rel="stylesheet"> 
        <link href="Css/responsive.css" rel="stylesheet">
        <link href="Css/style.css" rel="stylesheet">
        
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" ></script>    
	    <script type="text/javascript" src="https://getbootstrap.com/docs/4.2/dist/js/bootstrap.bundle.js"></script>
        <script type="text/javascript" src="scripts/jquery.maskedinput.min.js"></script>  

        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>EX1 - CRUD</title>

        <style>            
             .mydatagrid
             {
                width: 100%;
                border: solid 2px black;
                min-width: 80%;
             }
             .header
             {
                background-color: #000;
                font-family: Arial;
                color: White;
                height: 25px;
                text-align: center;
                font-size: 16px;
             }
             .rows
             {
                background-color: #fff;
                font-family: Arial;
                font-size: 14px;
                color: #000;
                min-height: 25px;
                text-align: left;
             }
             .rows:hover
             {
                background-color: #5badff;
                color: #fff;
             }
             .mydatagrid a /* FOR THE PAGING ICONS  */
             {
                background-color: Transparent;
                padding: 5px 5px 5px 5px;
                color: #fff;
                text-decoration: none;
                font-weight: bold;
             }
             .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/
             {
                background-color: #000;
                color: #fff;
             }
             .mydatagrid span /* FOR THE PAGING ICONS CURRENT PAGE INDICATOR */
             {
                background-color: #fff;
                color: #000;
                padding: 5px 5px 5px 5px;
             }
             .pager
             {
                background-color: #5badff;
                font-family: Arial;
                color: White;
                height: 30px;
                text-align: left;
             }
             .mydatagrid td
             {
                padding: 5px;
             }
             .mydatagrid th
             {
                padding: 5px;
             }
            </style>
        <script>
            jQuery(function ($) {
                $("#txtcnpj").mask("99.999.999/9999-99");
                $("#txtcpf").mask("999.999.999-99");
                $("#txttel").mask("(99) 9999-9999?9");
            });
         </script>

    </head>

<body class="homepage">

    <form id="form1" runat="server">

        <section id="feature" style="padding-top: 50px;padding-bottom: 20px;">
            <div class="container">
                <div class="col-md-12 col-xs-12">
                    <div class="center">
                    <h2>CRUD</h2>
                    </div>
                </div>
             </div>
        </section>

        <section id="recent-works">
            <div class="container">
                <br />
                <br />
                <asp:Panel ID="Panel1" runat="server">
                    <div class="center">                        
                        <asp:Button ID="btnnovo" CssClass="btn btn-info" runat="server" Text="Novo Cadastro" OnClick="btnnovo_Click" />
                        <br />
                        <br />
                        <asp:GridView ID="grd" runat="server" CssClass="mydatagrid" AllowPaging="true" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AutoGenerateColumns="False" EmptyDataText="Sem Dados" OnRowCommand="grd_RowCommand" OnPageIndexChanging="grd_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="id" Visible="false" /> 
                                 <asp:BoundField DataField="nome" HeaderText="Documento" InsertVisible="False" ReadOnly="True">
                                        <ItemStyle Width="25%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="doc" HeaderText="Documento" InsertVisible="False" ReadOnly="True">
                                        <ItemStyle Width="25%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="endereco" HeaderText="Endereços" InsertVisible="False" ReadOnly="True">
                                        <ItemStyle Width="25%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="numero" HeaderText="Telefone" InsertVisible="False" ReadOnly="True">
                                        <ItemStyle Width="20%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Ver">
                                      <ItemStyle Width="5%" HorizontalAlign="Center" />
                                      <ItemTemplate>
                                              <asp:ImageButton ID="Img1" CssClass="btn" ImageUrl="~/icons/ok-appproval-acceptance.png"
                                                  CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id")%>' 
                                                  CommandName="Editar" runat="server" />                                     
                                      </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Deletar">
                                      <ItemStyle Width="5%" HorizontalAlign="Center" />
                                      <ItemTemplate>
                                              <asp:ImageButton ID="Img2" CssClass="btn"  ImageUrl="~/icons/rubbish-bin.png"
                                                  CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id")%>' 
                                                  CommandName="Deletar" runat="server" /> 
                                      </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
                <asp:Panel ID="Panel2" runat="server">
                        <div class="form-group">
                            <div class="col-md-6 col-s-6" style="left: 150px;">
                                <asp:Label ID="Label1" runat="server" Text="Nome" />
                                <asp:TextBox ID="txtnome" CssClass="offset-md-5 form-control" runat="server" placeholder="Digite um Nome" style="width: 326px;"/>
                            </div>
                            <div class="col-md-6 col-s-6">
                                <div class="input-group">                                     
                                    <asp:RadioButton ID="RadioButton1" AutoPostBack="true" GroupName="documento" Text="CPF" runat="server" />                                    
                                    <asp:TextBox ID="txtcpf" class="form-control" runat="server" maxlength="14" placeholder="CPF" />
                                    &nbsp
                                    <asp:RadioButton ID="RadioButton2" AutoPostBack="true" GroupName="documento" Text="CNPJ" runat="server" />
                                    <asp:TextBox ID="txtcnpj" class="form-control" runat="server"  maxlenght="18" placeholder="CNPJ"/>                                   
                                </div>
                            </div>
                            <div class="col-md-6 col-s-6" style="left: 150px;">
                                <br />
                                <br />
                                <asp:Label ID="Label4" runat="server" Text="Endereço" />
                                <asp:TextBox ID="txtendereco" CssClass="offset-md-5 form-control" runat="server"/>
                                <br />
                                <asp:Label ID="Label5" runat="server" Text="Tipo"/>
                                &nbsp
                                <asp:DropDownList ID="dropende" CssClass="form-control" runat="server">
                                     <asp:ListItem>Cobrança</asp:ListItem>
                                     <asp:ListItem>Comercial</asp:ListItem>
                                     <asp:ListItem>Correspondência</asp:ListItem>
                                     <asp:ListItem>Entrega</asp:ListItem>
                                     <asp:ListItem>Residencial</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6 col-s-6">
                                <br />
                                <br />
                                <asp:Label ID="Label2" runat="server" Text="Telefone" />
                                <asp:TextBox ID="txttel" CssClass="offset-md-5 form-control" runat="server"/>
                                <br />
                                <asp:Label ID="Label3" runat="server" Text="Tipo"/>
                                &nbsp
                                <asp:DropDownList ID="droptel" CssClass="form-control" runat="server">
                                    <asp:ListItem>Residencial</asp:ListItem>
                                    <asp:ListItem>Comercial</asp:ListItem>
                                    <asp:ListItem>Celular</asp:ListItem>
                                </asp:DropDownList>
                            </div>       
                            <div class="col-sm-4"></div>
                            <div class="col-sm-4">
                                <br />
                                <br />
                                <br />
                                <asp:Button ID="btnadd" CssClass="btn btn-success" runat="server" Text="Salvar" OnClick="btnadd_Click" />
                                &nbsp
                                <asp:Button ID="btnback" CssClass="btn btn-danger" runat="server" Text="Voltar" OnClick="btnback_Click" />
                            </div> 
                            <div class="col-sm-4"></div>
                        </div>               
                </asp:Panel>
            </div>
        </section>

    </form>
</body>
</html>
