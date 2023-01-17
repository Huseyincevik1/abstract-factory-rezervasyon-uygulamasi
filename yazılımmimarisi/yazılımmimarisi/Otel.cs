using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace yazılımmimarisi
{
    public class Otel : Ikonaklama
    {
        public string KonaklamaTuru { get; set; }
        public string Lokasyon { get; set; }
        public DateTime KonaklamaBaslangic { get; set; }
        public DateTime KonaklamaBitis { get; set; }



        SqlConnection baglanti = new SqlConnection("Data Source=DESKTOP-1E3PP0A;Initial Catalog=YazılımM;Integrated Security=True");
        SqlCommand komut;
        public string konaklamaolustur()
        {
            string sorgu = "insert into tblRezervasyon(KonaklamaTuru,Lokasyon,KBaslangic,KBitis) values (@konakt,@lok,@KBas,@KBit)";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@konakt",KonaklamaTuru);
            komut.Parameters.AddWithValue("@lok", Lokasyon);
            komut.Parameters.AddWithValue("@KBas",KonaklamaBaslangic);
            komut.Parameters.AddWithValue("@KBit",KonaklamaBitis);

            baglanti.Open();
            komut.ExecuteNonQuery();
            baglanti.Close();

            return "Rezervasyon Yapılmıştır.";
        }
    }
}
