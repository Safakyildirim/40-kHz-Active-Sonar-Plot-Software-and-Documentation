namespace triangle_mesh_1
{
    partial class Form1
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
            this.components = new System.ComponentModel.Container();
            this.glMonitor = new Tao.Platform.Windows.SimpleOpenGlControl();
            this.rotXBt = new System.Windows.Forms.Button();
            this.rotZBt = new System.Windows.Forms.Button();
            this.rotXeksiBt = new System.Windows.Forms.Button();
            this.rotZeksiBt = new System.Windows.Forms.Button();
            this.zoomoutBt = new System.Windows.Forms.Button();
            this.zoominBt = new System.Windows.Forms.Button();
            this.rotYBt = new System.Windows.Forms.Button();
            this.rotYeksiBt = new System.Windows.Forms.Button();
            this.panLeftBt = new System.Windows.Forms.Button();
            this.PanRightBt = new System.Windows.Forms.Button();
            this.PanUpBt = new System.Windows.Forms.Button();
            this.PanDownBt = new System.Windows.Forms.Button();
            this.selectFileBt = new System.Windows.Forms.Button();
            this.selectFileTxb = new System.Windows.Forms.TextBox();
            this.monitorRefreshTimer = new System.Windows.Forms.Timer(this.components);
            this.exitBt = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // glMonitor
            // 
            this.glMonitor.AccumBits = ((byte)(0));
            this.glMonitor.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.glMonitor.AutoCheckErrors = false;
            this.glMonitor.AutoFinish = false;
            this.glMonitor.AutoMakeCurrent = true;
            this.glMonitor.AutoSwapBuffers = true;
            this.glMonitor.BackColor = System.Drawing.Color.Black;
            this.glMonitor.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.glMonitor.ColorBits = ((byte)(32));
            this.glMonitor.DepthBits = ((byte)(16));
            this.glMonitor.Location = new System.Drawing.Point(14, 11);
            this.glMonitor.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.glMonitor.Name = "glMonitor";
            this.glMonitor.Size = new System.Drawing.Size(460, 370);
            this.glMonitor.StencilBits = ((byte)(0));
            this.glMonitor.TabIndex = 0;
            this.glMonitor.KeyDown += new System.Windows.Forms.KeyEventHandler(this.glMonitor_KeyDown);
            this.glMonitor.KeyUp += new System.Windows.Forms.KeyEventHandler(this.glMonitor_KeyUp);
            // 
            // rotXBt
            // 
            this.rotXBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.rotXBt.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.rotXBt.Location = new System.Drawing.Point(547, 239);
            this.rotXBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.rotXBt.Name = "rotXBt";
            this.rotXBt.Size = new System.Drawing.Size(60, 35);
            this.rotXBt.TabIndex = 1;
            this.rotXBt.Text = "RotX+";
            this.rotXBt.UseVisualStyleBackColor = false;
            this.rotXBt.Click += new System.EventHandler(this.rotXBt_Click);
            // 
            // rotZBt
            // 
            this.rotZBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.rotZBt.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.rotZBt.Location = new System.Drawing.Point(480, 307);
            this.rotZBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.rotZBt.Name = "rotZBt";
            this.rotZBt.Size = new System.Drawing.Size(60, 35);
            this.rotZBt.TabIndex = 2;
            this.rotZBt.Text = "RotZ+";
            this.rotZBt.UseVisualStyleBackColor = false;
            this.rotZBt.Click += new System.EventHandler(this.rotZBt_Click);
            // 
            // rotXeksiBt
            // 
            this.rotXeksiBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.rotXeksiBt.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.rotXeksiBt.Location = new System.Drawing.Point(547, 280);
            this.rotXeksiBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.rotXeksiBt.Name = "rotXeksiBt";
            this.rotXeksiBt.Size = new System.Drawing.Size(60, 35);
            this.rotXeksiBt.TabIndex = 3;
            this.rotXeksiBt.Text = "RotX-";
            this.rotXeksiBt.UseVisualStyleBackColor = false;
            this.rotXeksiBt.Click += new System.EventHandler(this.rotXeksiBt_Click);
            // 
            // rotZeksiBt
            // 
            this.rotZeksiBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.rotZeksiBt.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.rotZeksiBt.Location = new System.Drawing.Point(613, 307);
            this.rotZeksiBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.rotZeksiBt.Name = "rotZeksiBt";
            this.rotZeksiBt.Size = new System.Drawing.Size(60, 35);
            this.rotZeksiBt.TabIndex = 4;
            this.rotZeksiBt.Text = "RotZ-";
            this.rotZeksiBt.UseVisualStyleBackColor = false;
            this.rotZeksiBt.Click += new System.EventHandler(this.rotZeksiBt_Click);
            // 
            // zoomoutBt
            // 
            this.zoomoutBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.zoomoutBt.BackColor = System.Drawing.Color.Tomato;
            this.zoomoutBt.Location = new System.Drawing.Point(613, 224);
            this.zoomoutBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.zoomoutBt.Name = "zoomoutBt";
            this.zoomoutBt.Size = new System.Drawing.Size(60, 35);
            this.zoomoutBt.TabIndex = 5;
            this.zoomoutBt.Text = "Zoom  (-)";
            this.zoomoutBt.UseVisualStyleBackColor = false;
            this.zoomoutBt.Click += new System.EventHandler(this.zoomoutBt_Click);
            // 
            // zoominBt
            // 
            this.zoominBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.zoominBt.BackColor = System.Drawing.Color.Tomato;
            this.zoominBt.Location = new System.Drawing.Point(480, 224);
            this.zoominBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.zoominBt.Name = "zoominBt";
            this.zoominBt.Size = new System.Drawing.Size(60, 37);
            this.zoominBt.TabIndex = 6;
            this.zoominBt.Text = "Zoom  (+)";
            this.zoominBt.UseVisualStyleBackColor = false;
            this.zoominBt.Click += new System.EventHandler(this.zoominBt_Click);
            // 
            // rotYBt
            // 
            this.rotYBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.rotYBt.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.rotYBt.Location = new System.Drawing.Point(480, 266);
            this.rotYBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.rotYBt.Name = "rotYBt";
            this.rotYBt.Size = new System.Drawing.Size(60, 35);
            this.rotYBt.TabIndex = 7;
            this.rotYBt.Text = "RotY+";
            this.rotYBt.UseVisualStyleBackColor = false;
            this.rotYBt.Click += new System.EventHandler(this.rotYBt_Click);
            // 
            // rotYeksiBt
            // 
            this.rotYeksiBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.rotYeksiBt.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.rotYeksiBt.Location = new System.Drawing.Point(613, 266);
            this.rotYeksiBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.rotYeksiBt.Name = "rotYeksiBt";
            this.rotYeksiBt.Size = new System.Drawing.Size(60, 35);
            this.rotYeksiBt.TabIndex = 8;
            this.rotYeksiBt.Text = "RotY-";
            this.rotYeksiBt.UseVisualStyleBackColor = false;
            this.rotYeksiBt.Click += new System.EventHandler(this.rotYeksiBt_Click);
            // 
            // panLeftBt
            // 
            this.panLeftBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.panLeftBt.BackColor = System.Drawing.SystemColors.MenuHighlight;
            this.panLeftBt.Location = new System.Drawing.Point(480, 165);
            this.panLeftBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.panLeftBt.Name = "panLeftBt";
            this.panLeftBt.Size = new System.Drawing.Size(60, 37);
            this.panLeftBt.TabIndex = 9;
            this.panLeftBt.Text = "Pan  Left";
            this.panLeftBt.UseVisualStyleBackColor = false;
            this.panLeftBt.Click += new System.EventHandler(this.panLeftBt_Click);
            // 
            // PanRightBt
            // 
            this.PanRightBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.PanRightBt.BackColor = System.Drawing.SystemColors.MenuHighlight;
            this.PanRightBt.Location = new System.Drawing.Point(613, 165);
            this.PanRightBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.PanRightBt.Name = "PanRightBt";
            this.PanRightBt.Size = new System.Drawing.Size(60, 37);
            this.PanRightBt.TabIndex = 10;
            this.PanRightBt.Text = "Pan  Right";
            this.PanRightBt.UseVisualStyleBackColor = false;
            this.PanRightBt.Click += new System.EventHandler(this.PanRightBt_Click);
            // 
            // PanUpBt
            // 
            this.PanUpBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.PanUpBt.BackColor = System.Drawing.SystemColors.MenuHighlight;
            this.PanUpBt.Location = new System.Drawing.Point(547, 146);
            this.PanUpBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.PanUpBt.Name = "PanUpBt";
            this.PanUpBt.Size = new System.Drawing.Size(60, 37);
            this.PanUpBt.TabIndex = 11;
            this.PanUpBt.Text = "Pan   Up";
            this.PanUpBt.UseVisualStyleBackColor = false;
            this.PanUpBt.Click += new System.EventHandler(this.PanUpBt_Click);
            // 
            // PanDownBt
            // 
            this.PanDownBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.PanDownBt.BackColor = System.Drawing.SystemColors.MenuHighlight;
            this.PanDownBt.Location = new System.Drawing.Point(547, 188);
            this.PanDownBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.PanDownBt.Name = "PanDownBt";
            this.PanDownBt.Size = new System.Drawing.Size(60, 37);
            this.PanDownBt.TabIndex = 12;
            this.PanDownBt.Text = "Pan  Down";
            this.PanDownBt.UseVisualStyleBackColor = false;
            this.PanDownBt.Click += new System.EventHandler(this.PanDownBt_Click);
            // 
            // selectFileBt
            // 
            this.selectFileBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.selectFileBt.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.selectFileBt.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.selectFileBt.Location = new System.Drawing.Point(14, 386);
            this.selectFileBt.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.selectFileBt.Name = "selectFileBt";
            this.selectFileBt.Size = new System.Drawing.Size(134, 25);
            this.selectFileBt.TabIndex = 13;
            this.selectFileBt.Text = "Select STL File";
            this.selectFileBt.UseVisualStyleBackColor = false;
            this.selectFileBt.Click += new System.EventHandler(this.selectFileBt_Click);
            // 
            // selectFileTxb
            // 
            this.selectFileTxb.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.selectFileTxb.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.selectFileTxb.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.selectFileTxb.Location = new System.Drawing.Point(155, 386);
            this.selectFileTxb.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.selectFileTxb.Multiline = true;
            this.selectFileTxb.Name = "selectFileTxb";
            this.selectFileTxb.Size = new System.Drawing.Size(175, 25);
            this.selectFileTxb.TabIndex = 14;
            this.selectFileTxb.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.selectFileTxb_KeyPress);
            // 
            // monitorRefreshTimer
            // 
            this.monitorRefreshTimer.Interval = 10;
            this.monitorRefreshTimer.Tick += new System.EventHandler(this.monitorRefreshTimer_Tick);
            // 
            // exitBt
            // 
            this.exitBt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.exitBt.BackColor = System.Drawing.Color.DarkGray;
            this.exitBt.Location = new System.Drawing.Point(480, 347);
            this.exitBt.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.exitBt.Name = "exitBt";
            this.exitBt.Size = new System.Drawing.Size(192, 63);
            this.exitBt.TabIndex = 15;
            this.exitBt.Text = "Exit";
            this.exitBt.UseVisualStyleBackColor = false;
            this.exitBt.Click += new System.EventHandler(this.exitBt_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(684, 416);
            this.Controls.Add(this.exitBt);
            this.Controls.Add(this.selectFileTxb);
            this.Controls.Add(this.selectFileBt);
            this.Controls.Add(this.PanDownBt);
            this.Controls.Add(this.PanUpBt);
            this.Controls.Add(this.PanRightBt);
            this.Controls.Add(this.panLeftBt);
            this.Controls.Add(this.rotYeksiBt);
            this.Controls.Add(this.rotYBt);
            this.Controls.Add(this.zoominBt);
            this.Controls.Add(this.zoomoutBt);
            this.Controls.Add(this.rotZeksiBt);
            this.Controls.Add(this.rotXeksiBt);
            this.Controls.Add(this.rotZBt);
            this.Controls.Add(this.rotXBt);
            this.Controls.Add(this.glMonitor);
            this.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.MinimumSize = new System.Drawing.Size(562, 370);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "STL Monitor";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Tao.Platform.Windows.SimpleOpenGlControl glMonitor;
        private System.Windows.Forms.Button rotXBt;
        private System.Windows.Forms.Button rotZBt;
        private System.Windows.Forms.Button rotXeksiBt;
        private System.Windows.Forms.Button rotZeksiBt;
        private System.Windows.Forms.Button zoomoutBt;
        private System.Windows.Forms.Button zoominBt;
        private System.Windows.Forms.Button rotYBt;
        private System.Windows.Forms.Button rotYeksiBt;
        private System.Windows.Forms.Button panLeftBt;
        private System.Windows.Forms.Button PanRightBt;
        private System.Windows.Forms.Button PanUpBt;
        private System.Windows.Forms.Button PanDownBt;
        private System.Windows.Forms.Button selectFileBt;
        private System.Windows.Forms.TextBox selectFileTxb;
        private System.Windows.Forms.Timer monitorRefreshTimer;
        private System.Windows.Forms.Button exitBt;
    }
}

