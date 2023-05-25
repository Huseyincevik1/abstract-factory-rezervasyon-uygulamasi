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
    public partial class Raporlama : Form
    {
       // SqlConnection baglanti;
       // SqlDataAdapter da;
        
        public Raporlama()
        {
            InitializeComponent();
        }
        void rezervasyongetir()
        {
            baglanti = new SqlConnection("Data Source=.;Initial Catalog=YazılımM;Integrated Security=True");
            baglanti.Open();
            da = new SqlDataAdapter("select * from tblRezervasyon", baglanti);
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            dataGridView1.DataSource = tablo;
            baglanti.Close();

        }

        private void Raporlama_Load(object sender, EventArgs e)
        {
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            
            for (int i=0; i<dataGridView1.SelectedRows.Count;i++)
            {
                baglanti.Open();
                SqlCommand komut = new SqlCommand("delete from tblRezervasyon where RezervasyonID='" + dataGridView1.SelectedRows[i].Cells["RezervasyonID"].Value.ToString() + "'", baglanti);
                komut.ExecuteNonQuery();
                baglanti.Close();
            }
            MessageBox.Show("Kayıt Silindi.");
            
         
        }

        private void Button3_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
