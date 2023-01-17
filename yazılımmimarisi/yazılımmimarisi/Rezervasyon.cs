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
    public partial class Rezervasyon : Form
    {

      
        public Rezervasyon()
        {
            InitializeComponent();
        }

        Otel otel = new Otel();
        Ucak ucak = new Ucak();
        Otobus otobus = new Otobus();
        Cadir cadir = new Cadir();
        private void button1_Click(object sender, EventArgs e)
        {
            
            string selectedcmbox1 = comboBox1.SelectedItem.ToString();
            string selectedcmbox2 = comboBox4.SelectedItem.ToString();

            if (selectedcmbox1.ToString() == "Otel")
            {
                otel.KonaklamaTuru = comboBox1.Text;
                otel.Lokasyon = comboBox3.Text;
                otel.KonaklamaBaslangic = dateTimePicker1.Value;
                otel.KonaklamaBitis = dateTimePicker2.Value;
                
            }
            if (selectedcmbox1.ToString() == "Çadır")
            {
                cadir.KonaklamaTuru = comboBox1.Text;
                cadir.Lokasyon = comboBox3.Text;
                cadir.KonaklamaBaslangic = dateTimePicker1.Value;
                cadir.KonaklamaBitis = dateTimePicker2.Value;
            }
            if(selectedcmbox2.ToString() == "Uçak")
            {
                ucak.UlasimTuru = comboBox4.Text;
                ucak.GidisYeri = comboBox2.Text;
                ucak.GidisTarihi = dateTimePicker4.Value;
                ucak.DonusYeri = comboBox5.Text;
                ucak.DonusTarihi = dateTimePicker3.Value;

            }
            if (selectedcmbox2.ToString() == "Otobus")
            {
                otobus.UlasimTuru = comboBox4.Text;
                otobus.GidisYeri = comboBox2.Text;
                otobus.GidisTarihi = dateTimePicker4.Value;
                otobus.DonusYeri = comboBox5.Text;
                otobus.DonusTarihi = dateTimePicker3.Value;
            }
            
        }
    }
}
