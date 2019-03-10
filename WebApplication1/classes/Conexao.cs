using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication1.classes
{
    public class Conexao
    {
        private SqlConnection con = new SqlConnection();
        private SqlDataAdapter dap = new SqlDataAdapter();
        private SqlDataReader dataReaderMy;
        private SqlCommand com;
        private DataTable dat = new DataTable();

        public void ConexaoMySql()
        {
            conectar();
        }

        public bool conectar()
        {
            if ((con.State == ConnectionState.Broken) || (con.State == ConnectionState.Closed))
            {
                try
                {
                    this.con.ConnectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename="+HttpContext.Current.Server.MapPath("")+@"\App_Data\Banco.mdf;Integrated Security=True";
                    this.con.Open();
                    return true;
                }
                catch(Exception ex)
                {
                    Console.Write(ex);
                    return false;                    
                }
            }
            else
                return true;

        }


        public void fechar()
        {
            try
            {
                if ((con.State == ConnectionState.Open) || (con.State == ConnectionState.Executing) || (con.State == ConnectionState.Fetching))
                {
                    con.Close();
                    con.Dispose();
                    con = null;
                }
                else
                {

                }
            }
            catch(Exception ex)
            {
                Console.Write(ex);
            }
        }

        public SqlDataReader myDataReader(string sql)
        {
            try
            {
                this.conectar();
                this.com = new SqlCommand(sql, con);
                this.dataReaderMy = com.ExecuteReader();
                return this.dataReaderMy;
            }
            catch(Exception exe)
            {
                Console.Write(exe);
                return this.dataReaderMy;
            }
        }

        public void myComandoSemRetorno(string sql)
        {
            try
            {
                this.conectar();
                this.com = new SqlCommand(sql, con);
                this.com.ExecuteNonQuery();
            }
            catch
            {

            }
        }

        public int myComandoRetornoValor(string sql)
        {
            try
            {
                this.conectar();
                this.com = new SqlCommand(sql, con);
                this.com.ExecuteNonQuery();

                if (com!=null)
                {
                    return 1;
                    
                }
                else
                {
                    return 0;
                }           
            }
            catch
            {
                return 0;
            }
        }


        public bool myComandoRetornoLogico(string sql)
        {
            try
            {
                this.conectar();
                this.com = new SqlCommand(sql, con);
                this.com.ExecuteNonQuery();
                return true;
            }
            catch(Exception e)
            {
                Console.Write(e);
                return false;
            }
        }

        public DataTable myDataTable(string sql)
        {
            try
            {
                this.conectar();
                this.com = new SqlCommand(sql, con);
                this.com.CommandType = CommandType.Text;
                this.com.CommandText = sql;
                dap.SelectCommand = this.com;
                dap.Fill(dat);
                dap.Dispose();
                return dat;
            }
            catch
            {
                return dat;
            }
        }
    }
}