using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Threading;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace projekat_UART
{
    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();
            Thread thread1 = new Thread(ThreadWork.Read);
            thread1.Start(textBox1);

        }

        private void button2_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '0';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '1';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '2';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button5_Click(object sender, EventArgs e)
        {

            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '3';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '4';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '5';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button13_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '6';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button15_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '7';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button16_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '8';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button25_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = '9';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'A';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'B';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'C';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'D';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'E';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button14_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'F';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button18_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'H';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button26_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'I';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button20_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'N';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void button22_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = 'L';
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string filePath = @"/dev/ttyUSB0";
            StreamWriter MyStreamWriter = new StreamWriter(filePath);
            char MyChar = (char) 255;
            MyStreamWriter.Write(MyChar);
            MyStreamWriter.Close();
        }
    }
    public class ThreadWork
    {
        public static void Read(object argument)
        {
            System.Windows.Forms.TextBox textBox1 = (System.Windows.Forms.TextBox)argument;
            string filePath = @"/dev/ttyUSB0";
            using (FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            using (StreamReader reader = new StreamReader(fs))
            {
                // Read the file line by line in a while loop
                while (true)
                {
                    int charCode = reader.Read();
                    if (charCode != -1)
                    {
                        char character = (char)charCode;
                        textBox1.Text += character;
                    }
                }
            }
        }
    }
}
