using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SinTransaccion
{
    internal class Venta
    {
        public int Id { get; set; }
        public int Folio { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
        public List<VentaConcepto> Conceptos { get; set; } = new List<VentaConcepto>();
    }
}
