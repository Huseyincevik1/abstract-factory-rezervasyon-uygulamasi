using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace yazılımmimarisi
{
    public class Otobus : Iulasim
    {
        public string UlasimTuru { get; set; }
        public string GidisYeri { get; set; }
        public string DonusYeri { get; set; }
        public DateTime GidisTarihi { get; set; }
        public DateTime DonusTarihi { get; set; }


        SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=YazılımM;Integrated Security=True");
        SqlCommand komut;
        public string ulasimolustur()
        {
            string sorgu = "insert into tblRezervasyon(UlasimTuru,GidisYeri,DonusYeri,GidisTarih,DonusTarih) values (@ulasimt,@gidisy,@donusy,@gidist,@donust)";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@ulasimt",UlasimTuru);
            komut.Parameters.AddWithValue("@gidisy",GidisYeri);
            komut.Parameters.AddWithValue("@donusy",DonusYeri);
            komut.Parameters.AddWithValue("@gidist",GidisTarihi);
            komut.Parameters.AddWithValue("@donust",DonusTarihi);

            baglanti.Open();
            komut.ExecuteNonQuery();
            baglanti.Close();

            return "Rezervasyon Yapılmıştır.";
        }
    }
}
