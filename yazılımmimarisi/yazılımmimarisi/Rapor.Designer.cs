namespace yazılımmimarisi
{
    partial class Rapor
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.grdData = new System.Windows.Forms.DataGridView();
            this.btnSil = new System.Windows.Forms.Button();
            this.BtnXml = new System.Windows.Forms.Button();
            this.BtnJson = new System.Windows.Forms.Button();
            this.BtnHtml = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.grdData)).BeginInit();
            this.SuspendLayout();
            // 
            // grdData
            // 
            this.grdData.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.grdData.Location = new System.Drawing.Point(12, 12);
            this.grdData.Name = "grdData";
            this.grdData.RowHeadersWidth = 51;
            this.grdData.RowTemplate.Height = 24;
            this.grdData.Size = new System.Drawing.Size(868, 300);
            this.grdData.TabIndex = 0;
            this.grdData.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.grdData_CellClick);
            // 
            // btnSil
            // 
            this.btnSil.Location = new System.Drawing.Point(680, 343);
            this.btnSil.Name = "btnSil";
            this.btnSil.Size = new System.Drawing.Size(201, 37);
            this.btnSil.TabIndex = 1;
            this.btnSil.Text = "İptal Et";
            this.btnSil.UseVisualStyleBackColor = true;
            // 
            // BtnXml
            // 
            this.BtnXml.Location = new System.Drawing.Point(13, 343);
            this.BtnXml.Name = "BtnXml";
            this.BtnXml.Size = new System.Drawing.Size(201, 37);
            this.BtnXml.TabIndex = 2;
            this.BtnXml.Text = "Xml Rapor";
            this.BtnXml.UseVisualStyleBackColor = true;
            // 
            // BtnJson
            // 
            this.BtnJson.Location = new System.Drawing.Point(231, 343);
            this.BtnJson.Name = "BtnJson";
            this.BtnJson.Size = new System.Drawing.Size(201, 37);
            this.BtnJson.TabIndex = 3;
            this.BtnJson.Text = "Json Rapor";
            this.BtnJson.UseVisualStyleBackColor = true;
            // 
            // BtnHtml
            // 
            this.BtnHtml.Location = new System.Drawing.Point(452, 343);
            this.BtnHtml.Name = "BtnHtml";
            this.BtnHtml.Size = new System.Drawing.Size(201, 37);
            this.BtnHtml.TabIndex = 4;
            this.BtnHtml.Text = "HTML Rapor";
            this.BtnHtml.UseVisualStyleBackColor = true;
            this.BtnHtml.Click += new System.EventHandler(this.BtnHtml_Click);
            // 
            // Rapor
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(893, 412);
            this.Controls.Add(this.BtnHtml);
            this.Controls.Add(this.BtnJson);
            this.Controls.Add(this.BtnXml);
            this.Controls.Add(this.btnSil);
            this.Controls.Add(this.grdData);
            this.Name = "Rapor";
            this.Text = "Rapor";
            this.Load += new System.EventHandler(this.Rapor_Load);
            ((System.ComponentModel.ISupportInitialize)(this.grdData)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView grdData;
        private System.Windows.Forms.Button btnSil;
        private System.Windows.Forms.Button BtnXml;
        private System.Windows.Forms.Button BtnJson;
        private System.Windows.Forms.Button BtnHtml;
    }
}