using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.classes;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class Menu : BaseWebUi
    {
        string v,v1,tipodoc;
        int id;

        protected void Page_Load(object sender, EventArgs e)
        {
            carrega();
        }

        protected void btnnovo_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
            Session["status"] = "novo";
        }

        protected void carrega()
        {
            Panel1.Visible = true;
            Panel2.Visible = false;

            Conexao obj = new Conexao();
            obj.ConexaoMySql();
            grd.DataSource = obj.myDataTable("select id_cliente as id,nome as nome,concat(documento,' (',tipodoc,')') as doc,concat(endereco,' (',tipoende,')') as endereco,concat(numero,' (',tiponum,')')as numero from clientes");
            grd.DataBind();
            obj.fechar();
        }

        protected void grd_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName=="Editar")
            {
                int aux = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = false;
                Panel2.Visible = true;
                Conexao obj = new Conexao();
                obj.ConexaoMySql();
                SqlDataReader read = obj.myDataReader("select * from clientes where id_cliente="+aux);
                if(read.Read())
                {
                    Session["id"] = read["id_cliente"];
                    dropende.SelectedItem.Value = read["tipoende"].ToString();
                    droptel.SelectedItem.Value = read["tiponum"].ToString();
                    txtnome.Text = read["nome"].ToString();
                    txtendereco.Text = read["endereco"].ToString();
                    txttel.Text = read["numero"].ToString();
                    tipodoc = read["tipodoc"].ToString();
                    if(tipodoc == "CPF")
                    {
                        RadioButton1.Checked = true;
                        txtcpf.Text = read["documento"].ToString();
                    }
                    if(tipodoc == "CNPJ")
                    {
                        RadioButton2.Checked = true;
                        txtcnpj.Text = read["documento"].ToString();
                    }
                }
                obj.fechar();
                Session["status"] = "editar";
            }
            if(e.CommandName=="Deletar")
            {
                int aux = Convert.ToInt32(e.CommandArgument);

                Conexao obj = new Conexao();
                obj.ConexaoMySql();
                bool ajuda = obj.myComandoRetornoLogico("delete from clientes where id_cliente=" + aux);
                obj.fechar();
                if(ajuda==true)
                {
                    Response.Write("<script>alert('Deletado com Sucesso!');</script>");
                    carrega();
                }
            }
        }

        protected void grd_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grd.PageIndex = e.NewPageIndex;
            grd.DataBind();
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
            Panel2.Visible = false;
        }
    
        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {

                if ((txtcpf.Text == "" && txtcnpj.Text == "") || txtendereco.Text == "" || txtnome.Text == "" || txttel.Text == "")
                {
                    Response.Write("<script>alert('Campos em Branco!');</script>");
                }
                else
                {
                    if (RadioButton1.Checked == false && RadioButton2.Checked == false)
                    {
                        Response.Write("<script>alert('Selecione uma Opção Para Tipo de Documento!');</script>");
                    }
                    if (RadioButton1.Checked == true)
                    {
                        v = "CPF";
                        v1 = txtcpf.Text;
                    }
                    if (RadioButton2.Checked == true)
                    {
                        v = "CNPJ";
                        v1 = txtcnpj.Text;
                    }
                    if (v != "")
                    {
                        if (Session["status"].ToString() == "novo")
                        {
                            Conexao obj = new Conexao();
                            bool ajuda = obj.myComandoRetornoLogico("insert into clientes(nome,documento,tipodoc,endereco,tipoende,numero,tiponum)" +
                                "values('" + txtnome.Text + "','" + v1 + "','" + v + "','" + txtendereco.Text + "','" + dropende.SelectedItem.Text + "','" + txttel.Text + "','" + droptel.SelectedItem.Text + "')");
                            obj.fechar();
                            if (ajuda == true)
                            {
                                if (ajuda == true)
                                {
                                    txtcnpj.Text = "";
                                    txtcpf.Text = "";
                                    txtendereco.Text = "";
                                    txtnome.Text = "";
                                    txttel.Text = "";
                                    Response.Write("<script>alert('Cadastro Efetuado com Sucesso!');</script>");
                                    carrega();
                                }
                            }
                        }
                        if (Session["status"].ToString() == "editar")
                        {
                            Conexao obj = new Conexao();
                            bool ajuda = obj.myComandoRetornoLogico("update clientes set nome='" + txtnome.Text + "',documento='" + v1+"',tipodoc='"+v+"',endereco='"+txtendereco.Text+"',tipoende='"+dropende.SelectedItem.Text+"',numero='"+txttel.Text+"',tiponum="+droptel.SelectedItem.Text+"'");
                            obj.fechar();
                            if (ajuda == true)
                            {
                                Response.Write("<script>alert('Editado Com Sucesso!');</script>");
                                carrega();
                            }
                        }
                    }
                }               
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('"+ex+"');</script>");
            }
        }    
    }
}