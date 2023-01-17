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
using System.IO;

namespace yazılımmimarisi
{
    public partial class Rapor : Form
    {
        public Rapor()
        {
            InitializeComponent();
        }
        SqlDataAdapter da;
        public string kullaniciAd;
        int secilenIndex;
        Raporlama raporum;
        int a = 15;
        SqlConnection baglanti = new SqlConnection("Data Source=DESKTOP-ADURGHC;Initial Catalog=YazlmM;Integrated Security=True");

        private void Rapor_Load(object sender, EventArgs e)
        {
            rezervasyongetir();
        }

        void rezervasyongetir()
        {
            
            baglanti.Open();
            SqlCommand komut = new SqlCommand("select * from tblRezervasyon WHERE Kullaniciad = @p1", baglanti);
            komut.Parameters.AddWithValue("@p1", kullaniciAd);
            da = new SqlDataAdapter(komut);
            
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            grdData.DataSource = tablo;
            baglanti.Close();

        }

        private void BtnHtml_Click(object sender, EventArgs e)
        {
            StreamWriter page = new StreamWriter(@"C:\Users\yusuf\Desktop\index.html");
            page.WriteLine("<!DOCTYPE html> <html> ");

            page.WriteLine("<style> td, th {border: 1px solid #dddddd;text-align: left;padding: 8px;</style>");
            page.WriteLine("<body>");
            page.WriteLine("<h2>Genel Bilgiler</h2>");
            page.WriteLine("<table>");
            page.WriteLine("<tr>");
            page.WriteLine("<th>Rezervasyon ID</th>");
            page.WriteLine("<th>Lokasyon</th>");
            page.WriteLine("<th>Konaklama Türü</th>");
            page.WriteLine("<th>Ulaşım Turu</th>");
            page.WriteLine("<th>Müşteri Ad</th>");
            page.WriteLine("<th>Müşteri Soyad</th>");
            page.WriteLine("<th>Müşteri Kullanıcı Ad</th>");

            page.WriteLine("</tr>");

            page.WriteLine("<tr>");
            page.WriteLine("<td>"+raporum.rezervasyonID+"</td>");
            page.WriteLine("<td>"+raporum.lokasyon+"</td>");
            page.WriteLine("<td>" + raporum.konaklamaTuru + "</td>");
            page.WriteLine("<td>" + raporum.ulasimTuru + "</td>");
            page.WriteLine("<td>" + raporum.musteriAd + "</td>");
            page.WriteLine("<td>" + raporum.musteriSoyad + "</td>");
            page.WriteLine("<td>" + raporum.musteriKullaniciAd + "</td>");
            page.WriteLine("</tr>");


            page.WriteLine("</table>");
            //2. tablo
            page.WriteLine("<h2>Detay Bilgiler</h2>");
            page.WriteLine("<table>");
            page.WriteLine("<tr>");
            page.WriteLine("<th>Konaklama Başlangıç Tarihi</th>");
            page.WriteLine("<th>Konaklama Bitiş Tarihi</th>");
            page.WriteLine("<th>Gidiş Yeri</th>");
            page.WriteLine("<th>Dönüş Yeri</th>");
            page.WriteLine("<th>Gidiş Tarihi</th>");
            page.WriteLine("<th>Müşteri Soyad</th>");
            page.WriteLine("<th>Dönüş Tarihi</th>");

            page.WriteLine("</tr>");

            page.WriteLine("<tr>");
            page.WriteLine("<td>Genel Bilgiler</td>");
            page.WriteLine("<td>Detay Bilgiler</td>");
            page.WriteLine("<td>Fiyat Bilgileri</td>");
            page.WriteLine("</tr>");


            page.WriteLine("</table>");


            page.WriteLine("<h2>Fiyat Bilgileri</h2>");
            page.WriteLine("<table>");
            page.WriteLine("<tr> <th> Fiyat <th> </tr>");
            page.WriteLine("</table>");


            page.WriteLine("</body>  </html>");
            page.Close();
            MessageBox.Show("HTML Çıktısı oluşturuldu");
        }


        private void grdData_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int secilen = grdData.SelectedCells[0].RowIndex;
            secilenIndex = Convert.ToInt32(grdData.Rows[secilen].Cells[0].Value.ToString());
            MessageBox.Show("secilen degerr: " + secilenIndex);
            raporum = new Raporlama();
            RaporCek(raporum);
        }

        private void RaporCek(Raporlama rapor)
        {
            baglanti.Open();
            SqlCommand komutRezervasyon = new SqlCommand("SELECT * FROM tblRezervasyon WHERE RezervasyonID = @p1", baglanti);
            komutRezervasyon.Parameters.AddWithValue("@p1",secilenIndex);
            SqlDataReader rdr = komutRezervasyon.ExecuteReader();
            while (rdr.Read())
            {
                rapor.rezervasyonID = Convert.ToInt32(rdr.GetValue(0).ToString());
                rapor.konaklamaTuru = rdr.GetValue(1).ToString();
                rapor.ulasimTuru = rdr.GetValue(2).ToString();
                rapor.lokasyon = rdr.GetValue(3).ToString();
                rapor.KonaklamaBaslangic = Convert.ToDateTime(rdr.GetValue(4).ToString());
                rapor.konaklamaBitis = Convert.ToDateTime(rdr.GetValue(5).ToString());
                rapor.gidisyeri = rdr.GetValue(6).ToString();
                rapor.donusYeri = rdr.GetValue(7).ToString();
                rapor.gidisTarihi = Convert.ToDateTime(rdr.GetValue(8).ToString());
                rapor.donusTarihi = Convert.ToDateTime(rdr.GetValue(9).ToString());
                rapor.MusteriID = Convert.ToInt32(rdr.GetValue(10).ToString());
                rapor.fiyat = Convert.ToInt32((rdr.GetValue(11).ToString()));
                rapor.kullanıcıAd = rdr.GetValue(12).ToString();
            }
            baglanti.Close();

            baglanti.Open();
            SqlCommand komutMusteri = new SqlCommand("SELECT * FROM tblMusteri WHERE MusteriID = @p1", baglanti);
            komutMusteri.Parameters.AddWithValue("@p1", rapor.MusteriID);
            SqlDataReader rdr1 = komutMusteri.ExecuteReader();
            while (rdr1.Read())
            {
                rapor.musteriAd = rdr1.GetValue(2).ToString();
                rapor.musteriSoyad = rdr1.GetValue(3).ToString();
                rapor.musteriKullaniciAd = rdr1.GetValue(4).ToString();
            }


            baglanti.Close();
        }
    }
}
