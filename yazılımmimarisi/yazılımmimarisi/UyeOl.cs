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
    public partial class UyeOl : Form
    {
        SqlConnection baglanti = new SqlConnection("Data Source=DESKTOP-1E3PP0A;Initial Catalog=YazılımM;Integrated Security=True");
        SqlCommand komut;
        public UyeOl()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sorgu = "insert into tblMusteri(KullaniciAd,MusteriAd,MusteriSoyad,Email,Parola) values (@kullaniciad,@ad,@soyad,@email,@parola)";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@kullaniciad", textBox1.Text);
            komut.Parameters.AddWithValue("@ad", textBox2.Text);
            komut.Parameters.AddWithValue("@soyad", textBox4.Text);
            komut.Parameters.AddWithValue("@email", textBox5.Text);
            komut.Parameters.AddWithValue("@parola", textBox3.Text);
            baglanti.Open();
            komut.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Kayıt Eklenmiştir.");
        }
    }
}
