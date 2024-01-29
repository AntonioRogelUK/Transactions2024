using SinTransaccion;
using System.Data.SqlClient;
using System.Runtime.CompilerServices;

internal class Program
{
    private static void Main(string[] args)
    {
        Venta venta = new Venta();
        venta.Fecha = DateTime.Now;

        VentaConcepto concepto1 = new VentaConcepto();
        concepto1.Cantidad = 1.00m;
        concepto1.Descripcion = "Taza";
        concepto1.PrecioUnitario = 50.00m;
        concepto1.Importe = concepto1.PrecioUnitario * concepto1.Cantidad;

        venta.Conceptos.Add(concepto1);

        venta.Conceptos.Add(new VentaConcepto()
        {
            Cantidad = 2.00m,
            Descripcion = "Chicle",
            PrecioUnitario = 1.00m,
            Importe = 2.00m * 1.00m
        });

        GuardarVenta(venta);

        Console.WriteLine(venta.Conceptos.Count);
    }

    static void GuardarVenta(Venta venta)
    {
        string connectionString = "Server=localhost;Database=TransaccionDB;Trusted_Connection=True;TrustServerCertificate=True;";
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();

            try
            {
                string queryFolio = "SELECT TOP (1) [UltimoFolio] FROM [Folios]";
                int folioActual = 0;
                using (SqlCommand cmd = new SqlCommand(queryFolio, con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Transaction = tran;

                    if (!int.TryParse(cmd.ExecuteScalar().ToString(), out folioActual))
                    {
                        throw new Exception();
                    }
                }

                venta.Folio = folioActual + 1;

                foreach (var concepto in venta.Conceptos)
                {
                    venta.Total += concepto.Importe;
                }

                /*LinQ
                    decimal total = venta.Conceptos.Sum(concepto => concepto.Importe);
                */

                string queryVenta = "INSERT INTO [VENTAS] (Folio, Fecha, Total) VALUES (@Folio, @Fecha, @Total); SELECT SCOPE_IDENTITY ()";
                using (SqlCommand cmd = new SqlCommand(queryVenta, con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Transaction = tran;

                    cmd.Parameters.AddWithValue("@Folio", venta.Folio);
                    cmd.Parameters.AddWithValue("@Fecha", venta.Fecha);
                    cmd.Parameters.AddWithValue("@Total", venta.Total);

                    if (!int.TryParse(cmd.ExecuteScalar().ToString(), out int idVenta))
                    {
                        throw new Exception();
                    }

                    venta.Id = idVenta;
                }

                foreach(var concepto in venta.Conceptos)
                {
                    string queryConcepto = "INSERT INTO [VentasConceptos] ([VentaId], [Descripcion], [PrecioUnitario], [Cantidad], [Importe]) VALUES (@VentaId, @Descripcion, @PrecioUnitario, @Cantidad, @Importe)";
                    using (SqlCommand cmd = new SqlCommand(queryConcepto, con))
                    {
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Transaction = tran;

                        cmd.Parameters.AddWithValue("@VentaId", venta.Id);
                        cmd.Parameters.AddWithValue("@Descripcion", concepto.Descripcion);
                        cmd.Parameters.AddWithValue("@PrecioUnitario", concepto.PrecioUnitario);
                        cmd.Parameters.AddWithValue("@Cantidad", concepto.Cantidad);
                        cmd.Parameters.AddWithValue("@Importe", concepto.Importe);
                        cmd.ExecuteNonQuery();
                    }
                }

                string queryUpdateFolio = "UPDATE Folios SET UltimoFolio = UltimoFolio + 1";
                using (SqlCommand cmd = new SqlCommand(queryUpdateFolio, con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Transaction = tran;
                    cmd.ExecuteNonQuery();
                }

                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }
        }
    }
}