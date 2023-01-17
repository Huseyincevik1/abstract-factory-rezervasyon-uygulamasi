using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace yazılımmimarisi
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        SqlConnection baglanti = new SqlConnection("Data Source=DESKTOP-1E3PP0A;Initial Catalog=YazılımM;Integrated Security=True");
        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                baglanti.Open();
                string sql = "select * from tblMusteri where KullaniciAd=@kadi AND Parola = @sifre";
                SqlParameter prm1 = new SqlParameter("kadi", textBox1.Text);
                SqlParameter prm2 = new SqlParameter("sifre", textBox2.Text);
                SqlCommand komut = new SqlCommand(sql, baglanti);
                komut.Parameters.Add(prm1);
                komut.Parameters.Add(prm2);
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(komut);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    Rezervasyon rezervasyon = new Rezervasyon();
                    rezervasyon.Show();
                    this.Hide();
                }
            }
            catch (Exception)


            {
                MessageBox.Show("Hatalı Giriş");

            }
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            UyeOl uyeol = new UyeOl();
            uyeol.Show();
            this.Hide();
        }
    }
}
